curl https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux.tar.gz -o openshift-install.tar.gz
curl https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz -o openshift-client.tar.gz
tar -xzf openshift-install.tar.gz --directory /usr/local/bin
tar -xzf openshift-client.tar.gz --directory /usr/local/bin
rm -rf openshift-install.tar.gz
rm -rf openshift-client.tar.gz

