# Create a new VPC with a CIDR block of
VPC_ID=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.VpcId' --output text)

# Create a new subnet in the VPC with a CIDR block of
SUBNET_PUB=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24 --availability-zone ap-south-1a --query 'Subnet.SubnetId' --output text)
SUBNET_PRIV1=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.2.0/24 --availability-zone ap-south-1b --query 'Subnet.SubnetId' --output text)
SUBNET_PRIV2=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.3.0/24 --availability-zone ap-south-1c --query 'Subnet.SubnetId' --output text)

export vpc_id="$VPC_ID"
export subnet_pub="$SUBNET_PUB"
export priv1="$SUBNET_PRIV1"
export priv2="$SUBNET_PRIV2"

printf 'vpc_id=%s\nsubnet_pub=%s\npriv1=%s\npriv2=%s\n' \
  "$vpc_id" "$subnet_pub" "$priv1" "$priv2"

# Create a new Internet Gateway
# IGW_ID=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)

# Attach the Internet Gateway to the VPC
# aws ec2 attach-internet-gateway --vpc-id $VPC_ID --internet-gateway-id $IGW_ID
