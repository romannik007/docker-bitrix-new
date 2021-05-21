#!/bin/bash

#bitrix-base-new-backup > invent-stage
#bitrix-base-new-mysql-backup > invent-stage-mysql

docker load -i bitrix-base-new-backup
docker load -i bitrix-base-new-mysql-backup