#!/bin/bash

TARGET=root@$1

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $TARGET 'cat ~/dashboard-admin-token'
