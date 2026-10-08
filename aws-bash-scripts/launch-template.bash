#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${subnet_pub:-}" ]]; then
    printf 'Error: subnet_pub is not set. Source vpc-subnet.bash in this shell first.\n' >&2
    exit 1
fi

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
USER_DATA=$(base64 -w 0 "$SCRIPT_DIR/usr-data.bash")

aws ec2 create-launch-template \
    --launch-template-name app1-launch-template \
    --version-description "Initial version" \
    --launch-template-data '{
        "ImageId": "ami-0c55b159cbfafe1f0",
        "InstanceType": "t3.micro",
        "UserData": "'$USER_DATA'"
    }'

aws ec2 autoscaling create-auto-scaling-group \
    --auto-scaling-group-name app1-auto-scaling-group \
    --launch-template "LaunchTemplateName=app1-launch-template,Version=1" \
    --min-size 1 \
    --max-size 3 \
    --desired-capacity 1 \
    --vpc-zone-identifier "$subnet_pub"