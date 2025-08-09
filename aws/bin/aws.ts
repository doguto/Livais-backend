#!/usr/bin/env node
import * as cdk from 'aws-cdk-lib';
import { LivaisDevStack } from '../lib/livais-dev-stack';

const app = new cdk.App();
new LivaisDevStack(app, 'LivaisDevStack', {
    description: 'Stack for Developing Livais',
});
