#!/usr/bin/env node
import * as cdk from 'aws-cdk-lib';
import { LivaisDevStack } from '../lib/livais-dev-stack';
import dotenv from 'dotenv';
import path from "node:path";

dotenv.config({ path: path.resolve(__dirname, '../../.env') })

const app = new cdk.App();
new LivaisDevStack(app, 'LivaisDevStack', {
    description: 'Stack for Developing Livais',
    env: {
        account: process.env.CDK_DEFAULT_ACCOUNT,
        region: process.env.CDK_DEFAULT_REGION,
    },
});
