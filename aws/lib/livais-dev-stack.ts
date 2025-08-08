import * as cdk from 'aws-cdk-lib';
import { CfnOutput } from 'aws-cdk-lib'
import { Application } from "aws-cdk-lib/aws-appconfig";
import { Construct } from 'constructs';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import { KeyPair } from "cdk-ec2-key-pair";


export class LivaisDevStack extends cdk.Stack {
    constructor(scope: Construct, id: string, props?: cdk.StackProps) {
        super(scope, id, props);

        // VPC
        // publicSubnet, privateSubnetを各AZに1つずつ作成
        const vpc = new ec2.Vpc(this, 'DevVpc', {
            ipAddresses: ec2.IpAddresses.cidr('10.0.0.0/16'),
            maxAzs: 1, // AZは1つのみ
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
            vpcName: 'DevVpc',
        })

        // Security Group
        const serverSecurityGroup = new ec2.SecurityGroup(this, 'DevServerSecurityGroup', {
            vpc
        })
        serverSecurityGroup.connections.allowFromAnyIpv4(ec2.Port.tcp(22))   // SSHの許可
        serverSecurityGroup.connections.allowFromAnyIpv4(ec2.Port.tcp(443))  // Httpsの許可

        const databaseSecurityGroup = new ec2.SecurityGroup(this, 'DevDatabaseSecurityGroup', {
            vpc
        })
        serverSecurityGroup.connections.allowFrom(serverSecurityGroup, ec2.Port.tcp(3306))  // EC2からMySQLへのアクセスを許可

        // EC2 Instance
        const devServer = new ec2.Instance(this, 'DevServer', {
            vpc,
            vpcSubnets: vpc.selectSubnets({
                subnetType: ec2.SubnetType.PUBLIC,
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
            instanceName: 'DevServer'
        })

        // ElasticIPをEC2に設定
        new ec2.CfnEIP(this, 'DevServerElasticIp', {
            instanceId: devServer.instanceId,
        })

        // CloudFormationへの出力
        new CfnOutput(this, 'VPC', { value: vpc.vpcId })
        new CfnOutput(this, 'Security Group', { value: serverSecurityGroup.securityGroupId })
        new CfnOutput(this, 'EC2', { value: devServer.instanceId })
    }
}
