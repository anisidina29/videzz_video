#!/bin/bash

REGION="iad"         # IP Mỹ (có thể đổi: sjc, ord, ewr...)
BASE_NAME="videzz-video"
ORG="personal"       # Hoặc tên org thật nếu bạn có team
COUNT=100

for i in $(seq 1 $COUNT); do
    APP_NAME="${BASE_NAME}-${i}"
    echo "🚀 [$i/$COUNT] Creating $APP_NAME..."

    fly apps create $APP_NAME --org $ORG --auto-confirm
    fly launch --name $APP_NAME --region $REGION --no-deploy --copy-config --auto-confirm
    fly deploy --app $APP_NAME --remote-only &

    sleep 1  # tránh rate-limit
done

wait

echo "🕒 Waiting 30 minutes before cleanup..."
sleep 1800

for i in $(seq 1 $COUNT); do
    APP_NAME="${BASE_NAME}-${i}"
    echo "🧹 Destroying $APP_NAME..."
    fly apps destroy $APP_NAME --yes
done
