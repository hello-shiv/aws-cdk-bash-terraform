
#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${priv1:-}" || -z "${priv2:-}" ]]; then
    source "$(dirname "${BASH_SOURCE[0]}")/vpc-subnet.bash"
fi

# 1. Create a DB Subnet Group
aws rds create-db-subnet-group \
    --db-subnet-group-name app-db-subnet \
    --db-subnet-group-description "RDS Subnet Group" \
    --subnet-ids "$priv1" "$priv2"


# 2. Create a Security Group for RDS
# SECURITY_GROUP_ID=$(aws ec2 create-security-group \
#     --group-name $SECURITY_GROUP_NAME \
#     --description "Security group for RDS MySQL" \
#     --vpc-id $VPC_ID \
#     --query 'GroupId' \
#     --output text)  

# 3. Launch RDS MySQL Instance
aws rds create-db-instance \
    --db-instance-identifier app1-mysql \
    --allocated-storage 20 \
    --db-instance-class db.t3.micro \
    --engine mysql \
    --master-username admin \
    --master-user-password mypassword123 \
    --db-subnet-group-name app-db-subnet