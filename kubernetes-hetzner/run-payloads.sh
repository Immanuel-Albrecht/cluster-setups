#!/bin/bash

TARGET=root@$1

scp -r payloads $TARGET:'~'

ssh $TARGET 'chmod +x payloads/*'

ssh $TARGET "tmux new-session -d -s setup-session $2"
