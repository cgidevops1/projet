#!/bin/bash

#Auteurs : Pierre-Hugues Dorais, Samuel Ross, Marc Gauthier
#Date : 26 juin 2017

#Validation premier parametre.
if [ $# -ne 1 ]; then
	echo "Usage : `basename $0` nom_machine"
exit 1
fi

#Variables.
nom_machine=$1
nom_template=vstemplate-centos7
folder_templates=Templates
ssh_user=root
ssh_password=qwerty
vlan=QA_VLAN20
datastore=SAN_LUN3
resource_pool=CLUSTER_INTDEV_QA_UAT_PREPROD
destination_folder=Chef

#Verification VM. Si elle existe, la supprime dans vSphere et dans Chef.
if `knife vsphere vm list -f Chef | grep  "VM Name: $nom_machine" >/dev/null 2>&1`; then
	knife vsphere vm delete $nom_machine -f $destination_folder
	knife node delete $nom_machine -y
	knife client delete $nom_machine -y
fi


#Creation de VM dans vSphere et "bootstrapper" dans Chef.
knife vsphere vm clone $nom_machine --template $nom_template -f $folder_templates \
 --cips DHCP --ssh-user $ssh_user --ssh-password $ssh_password --cvlan $vlan \
 --resource-pool $resource_pool --datastore $datastore --dest-folder $destination_folder \
 --start --bootstrap
