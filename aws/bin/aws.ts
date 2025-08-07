#!/usr/bin/env node
import * as cdk from 'aws-cdk-lib';
import {AwsStack} from '../lib/aws-stack';

const app = new cdk.App();
new AwsStack(app, 'LivaisDevStack', {
    description: 'Stack for Developing Livais',
});
