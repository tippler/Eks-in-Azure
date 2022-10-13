#!/bin/bash

az login -u $username -p $password -o none
export NAME=cluster
export AZ_GROUP=$(az group list | jq .[0].name | sed 's/"//g')
export AZ_VNET_NAME=$NAME-vnet
export AZ_VNET_ADDR=10.0.0.0/16
export AZ_VNET_SUB_NAME=$NAME-subnet
export AZ_VNET_SUB_ADDR=10.0.0.0/24
export MACH_USER=cloud-user

az network vnet create\
  -g $AZ_GROUP \
  -n $AZ_VNET_NAME \
  --address-prefix $AZ_VNET_ADDR \
  --subnet-name $AZ_VNET_SUB_NAME \
  --subnet-prefix $AZ_VNET_SUB_ADDR \
  -o none


echo "" > hardware.csv
for i in {1..1}
do  
    export MACHINE_NAME=$NAME-$i
    export MACHINE_IP=$( \
    az vm create \
    --name $MACHINE_NAME \
    --image UbuntuLTS \
    --admin-username $MACH_USER \
    --size Standard_DS2_v2 \
    --public-ip-sku Standard \
    --vnet-name $AZ_VNET_NAME \
    --subnet $AZ_VNET_SUB_NAME \
    --ssh-key-values /root/.ssh/id_rsa.pub \
    --resource-group $AZ_GROUP | jq .publicIpAddress |  sed 's/"//g' );
    
    echo "$MACHINE_NAME,,,,$MAC,$MACHINE_IP,"
done

echo "" > ~/.ssh/known_hosts
ssh -o "StrictHostKeyChecking=no" cloud-user@$MACHINE_IP "sudo curl https://raw.githubusercontent.com/tippler/Eks-in-Azure/main/id_rsa.pub -o /root/.ssh/authorized_keys"

echo ""
echo ""
echo ""
echo ""
echo ""
echo "---------------   $MACHINE_IP    --------------------"
echo ""
echo ""
echo ""
echo ""
echo ""
