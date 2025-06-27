#!/bin/bash

# Tên app gốc
BASE_NAME="videozzz-bot"
REGION="iad" # ví dụ: iad = Washington DC, Mỹ
COUNT=100

for i in $(seq 1 $COUNT); do
    APP_NAME="${BASE_NAME}-${i}"
    echo "🚀 Deploying $APP_NAME..."

    fly apps create $APP_NAME --org personal
    fly launch --name $APP_NAME --region $REGION --no-deploy --copy-config
    fly deploy --app $APP_NAME --region $REGION --remote-only &
done

# Chờ tất cả deploy xong
wait

echo "⏱ Waiting 30 minutes..."
sleep 1800  # 30 phút

echo "🧹 Cleaning up..."
for i in $(seq 1 $COUNT); do
    APP_NAME="${BASE_NAME}-${i}"
    fly apps destroy $APP_NAME --yes
done
