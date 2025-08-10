import * as cdk from 'aws-cdk-lib';
import { CfnOutput, SecretValue } from 'aws-cdk-lib'
import { Construct } from 'constructs';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import * as rds from 'aws-cdk-lib/aws-rds';
import * as acm from 'aws-cdk-lib/aws-certificatemanager';
import { KeyPair } from "cdk-ec2-key-pair";
import { ARecord, HostedZone, RecordTarget } from "aws-cdk-lib/aws-route53";

export class LivaisDevStack extends cdk.Stack {
    constructor(scope: Construct, id: string, props?: cdk.StackProps) {
        super(scope, id, props)

        // AvailabilityZone
        const appRegion = 'ap-northeast-1'
        const availabilityZoneNames = [`${ appRegion }a`, `${ appRegion }c`]

        // VPC
        // publicSubnet, privateSubnetを各AZに1つずつ作成
        const vpcName = 'DevVpc'
        const vpc = new ec2.Vpc(this, vpcName, {
            ipAddresses: ec2.IpAddresses.cidr('10.0.0.0/16'),
            availabilityZones: availabilityZoneNames,
            natGateways: 0,
            subnetConfiguration: [
                {
                    cidrMask: 24,
                    name: 'PublicSubnet',
                    subnetType: ec2.SubnetType.PUBLIC,
                },
                {
                    cidrMask: 24,
                    name: 'PrivateSubnet',
                    subnetType: ec2.SubnetType.PRIVATE_ISOLATED,  // NATゲート無し
                },
            ],
            vpcName: vpcName,
        })

        // Security Group
        const serverSecurityGroup = new ec2.SecurityGroup(this, 'DevServerSecurityGroup', {
            vpc
        })
        serverSecurityGroup.connections.allowFromAnyIpv4(ec2.Port.tcp(22))   // SSHの許可
        serverSecurityGroup.connections.allowFromAnyIpv4(ec2.Port.tcp(80))   // Httpの許可
        serverSecurityGroup.connections.allowFromAnyIpv4(ec2.Port.tcp(443))  // Httpsの許可

        const databaseSecurityGroup = new ec2.SecurityGroup(this, 'DevDatabaseSecurityGroup', {
            vpc
        })
        databaseSecurityGroup.connections.allowFrom(serverSecurityGroup, ec2.Port.tcp(3306))  // EC2からMySQLへのアクセスを許可

        // EC2 Instance
        const serverName = 'DevServer'
        const devServer = new ec2.Instance(this, serverName, {
            vpc,
            vpcSubnets: vpc.selectSubnets({
                subnetType: ec2.SubnetType.PUBLIC,
                availabilityZones: [availabilityZoneNames[0]],  // EC2を2つ作成しないようにAZで絞り込み
            }),
            instanceType: ec2.InstanceType.of(ec2.InstanceClass.T2, ec2.InstanceSize.MICRO),  // 無料枠: t2.micro
            machineImage: new ec2.AmazonLinuxImage({
                generation: ec2.AmazonLinuxGeneration.AMAZON_LINUX_2,
            }),
            securityGroup: serverSecurityGroup,
            keyPair: new KeyPair(this, 'DevServerKeyPair', {
                keyPairName: 'DevServerSshKey',
                storePublicKey: true
            }),
            instanceName: serverName
        })

        // const setupScript = readFileSync('./lib/resources/setup-dev.sh', 'utf-8')
        // devServer.addUserData(setupScript)

        // ElasticIPをEC2に設定
        const devServerEip = new ec2.CfnEIP(this, 'DevServerElasticIp', {
            instanceId: devServer.instanceId,
        })

        // Route53
        const domainName = process.env.DOMAIN_NAME as string
        const hostZone = HostedZone.fromLookup(this, 'DevServerZone', {
            domainName: domainName,
        })

        const devDomainPrefix = 'dev'
        new ARecord(this, "DevServerARecord", {
            target: RecordTarget.fromIpAddresses(devServerEip.ref),
            zone: hostZone,
            recordName: devDomainPrefix,
            region: appRegion,
        })

        // https用証明書の取得
        const apiDomainName = `${ devDomainPrefix }.${ domainName }`
        new acm.Certificate(this, "DevServerCertificate", {
            domainName: apiDomainName,
            certificateName: "DevServerCertificate",
            validation: acm.CertificateValidation.fromDns(hostZone),
        })

        // RDS
        const databaseName = 'DevDatabase'
        const devDatabase = new rds.DatabaseInstance(this, databaseName, {
            vpc,
            vpcSubnets: vpc.selectSubnets({
                subnetType: ec2.SubnetType.PRIVATE_ISOLATED,
            }),
            engine: rds.DatabaseInstanceEngine.mysql({
                version: rds.MysqlEngineVersion.VER_8_0_41,
            }),
            instanceType: ec2.InstanceType.of(ec2.InstanceClass.T4G, ec2.InstanceSize.MICRO),  // 無料枠: t4g.micro
            multiAz: false,           // 無料枠: AZ1つ
            allocatedStorage: 20,     // 無料枠: 最大20GB
            maxAllocatedStorage: 20,  // 無料枠: 最大20GB
            securityGroups: [databaseSecurityGroup],
            credentials: rds.Credentials.fromUsername(process.env.DATABASE_USERNAME as string, {
                password: SecretValue.unsafePlainText(process.env.DATABASE_PASSWORD as string),
            }),
            instanceIdentifier: databaseName,
            databaseName: databaseName,
        })
        devDatabase.connections.allowDefaultPortFrom(devServer)

        // CloudFormationへの出力
        new CfnOutput(this, 'VPC', { value: vpc.vpcId })
        new CfnOutput(this, 'Security Group for EC2', { value: serverSecurityGroup.securityGroupId })
        new CfnOutput(this, 'Security Group for RDS', { value: databaseSecurityGroup.securityGroupId })
        new CfnOutput(this, 'EC2', { value: devServer.instanceId })
        new CfnOutput(this, 'RDS', { value: devDatabase.instanceIdentifier })
    }
}
