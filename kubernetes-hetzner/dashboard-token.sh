#!/bin/bash

TARGET=root@$1

ssh $TARGET 'cat ~/dashboard-admin-token'
