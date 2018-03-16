#!/bin/bash
source service.osrc
# This part is for obtain the all the instances on the Environment
> resource-utilisation-novalist-report.txt
for i in $( cat /etc/hosts | grep comp | grep mgmt |awk '{print $2}');
do nova list --all-tenants --host $i | sed -e '1,3d' | sed '$d' | tr '|' ',' | awk -v hostvar="$i" '{print hostvar $0;}' 
echo; done >> resource-utilisation-novalist-report.txt
sed -e '/^[[:blank:]]*$/d' resource-utilisation-novalist-report.txt > resource-utilisation-novalist-report.csv

# This part is for obtain all the volumes per instance and host 
> resource-utilisation-novashow-volumes-report.txt
for i in $( cat /home/stack/stratus-resource-utilisation-novalist-report.csv | awk '{print $2}');
do >novashowtemp.txt && nova show $i > novashowtemp.txt && host=$(cat novashowtemp.txt | grep OS-EXT-SRV-ATTR:hypervisor_hostname | tr '|' ',' | awk '{print $4}') && name=$(cat novashowtemp.txt | grep -w "name" | tr '|' ',' | awk '{print $4}') && cat novashowtemp.txt | grep os-extended-volumes:volumes_attached | tr '|' ',' | awk -v namevar="$name" '{print namevar $0;}' | awk -v instanceidvar="$i""," '{print instanceidvar $0;}' | awk -v hostvar="$host""," '{print hostvar $0;}' | sed -e 's/\<id\>//g' | sed 's/\://g' | sed 's/\"//g' | tr -d '[]{}' | tr -d ' '
echo; done >> resource-utilisation-novashow-volumes-report.txt
sed -e '/^[[:blank:]]*$/d' resource-utilisation-novashow-volumes-report.txt > stratus-resource-utilisation-novashow-volumes-report.csv
