#!/bin/bash


if [ $# -ne 1 ]; then
	echo "Usage : `basename $0` nom_machine"
exit 1
fi

nom_machine=$1
nom_template=vstemplate-centos7
folder_templates=Templates
ssh_user=root
ssh_password=qwerty
vlan=QA_VLAN20
datastore=SAN_LUN3
resource_pool=CLUSTER_INTDEV_QA_UAT_PREPROD
destination_folder=Chef


knife vsphere vm clone $nom_machine --template $nom_template -f $folder_templates \
 --cips DHCP --ssh-user $ssh_user --ssh-password $ssh_password --cvlan $vlan \
 --resource-pool $resource_pool --datastore $datastore --dest-folder $destination_folder \
 --start --bootstrap
