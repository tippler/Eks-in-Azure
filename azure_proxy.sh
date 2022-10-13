az login -u $username -p $password
export AZ_GROUP=$(az group list | jq .[0].name | sed 's/"//g')

export MACHINE_IP=$( \
az vm create \
--name rober-1 \
--image UbuntuLTS \
--admin-username cloud-user \
--ssh-key-values /root/.ssh/id_rsa.pub \
--size Standard_A1_v2 \
--public-ip-sku Standard \
--resource-group $AZ_GROUP | jq .publicIpAddress |  sed 's/"//g' );
echo $MACHINE_IP

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