#!/bin/bash
source service.osrc
# This part is for obtain the all the instances on the Environment
> stratus-resource-utilisation-novalist-report.txt
for i in $( cat /etc/hosts | grep comp | grep mgmt |awk '{print $2}');
do nova list --all-tenants --host $i | sed -e '1,3d' | sed '$d' | tr '|' ',' | awk -v hostvar="$i" '{print hostvar $0;}' 
echo; done >> stratus-resource-utilisation-novalist-report.txt
sed -e '/^[[:blank:]]*$/d' stratus-resource-utilisation-novalist-report.txt > stratus-resource-utilisation-novalist-report.csv

# This part is for obtain all the volumes per instance and host 
> stratus-resource-utilisation-novashow-volumes-report.txt
for i in $( cat /home/stack/stratus-resource-utilisation-novalist-report.csv | awk '{print $2}');
do >novashowtemp.txt && nova show $i > novashowtemp.txt && host=$(cat novashowtemp.txt | grep OS-EXT-SRV-ATTR:hypervisor_hostname | tr '|' ',' | awk '{print $4}') && name=$(cat novashowtemp.txt | grep -w "name" | tr '|' ',' | awk '{print $4}') && cat novashowtemp.txt | grep os-extended-volumes:volumes_attached | tr '|' ',' | awk -v namevar="$name" '{print namevar $0;}' | awk -v instanceidvar="$i""," '{print instanceidvar $0;}' | awk -v hostvar="$host""," '{print hostvar $0;}' | sed -e 's/\<id\>//g' | sed 's/\://g' | sed 's/\"//g' | tr -d '[]{}' | tr -d ' '
echo; done >> stratus-resource-utilisation-novashow-volumes-report.txt
sed -e '/^[[:blank:]]*$/d' stratus-resource-utilisation-novashow-volumes-report.txt > stratus-resource-utilisation-novashow-volumes-report.csv

# sed -e '/^[[:blank:]]*$/d' stratus-resource-utilisation-novashow-volumes-report.csv > stratus-resource-utilisation-novashow-volumes-report.csv


# host=$(nova show 0013fac7-8165-414d-ae3e-13ec55cdcffd | grep OS-EXT-SRV-ATTR:hypervisor_hostname | tr '|' ',' | awk '{print $4}') && nova show 0013fac7-8165-414d-ae3e-13ec55cdcffd | grep os-extended-volumes:volumes_attached | tr '|' ',' | awk -v hostvar="$host" '{print hostvar $0;}'
i=b4b5c21a-c774-4cad-a005-6a4304811b0a
>novashowtemp.txt && nova show $i > novashowtemp.txt && host=$(cat novashowtemp.txt | grep OS-EXT-SRV-ATTR:hypervisor_hostname | tr '|' ',' | awk '{print $4}') && name=$(cat novashowtemp.txt | grep -w "name" | tr '|' ',' | awk '{print $4}') && cat novashowtemp.txt | grep os-extended-volumes:volumes_attached | tr '|' ',' | awk -v namevar="$name" '{print namevar $0;}' | awk -v instanceidvar="$i""," '{print instanceidvar $0;}' | awk -v hostvar="$host""," '{print hostvar $0;}' | sed -e 's/\<id\>//g' | sed 's/\://g' | sed 's/\"//g' | tr -d '[]{}' | tr -d ' '
i=e0ed6c40-a49c-45d8-b631-7335bb003084
>novashowtemp.txt && nova show $i > novashowtemp.txt && host=$(cat novashowtemp.txt | grep OS-EXT-SRV-ATTR:hypervisor_hostname | tr '|' ',' | awk '{print $4}') && name=$(cat novashowtemp.txt | grep -w "name" | tr '|' ',' | awk '{print $4}') && cat novashowtemp.txt | grep os-extended-volumes:volumes_attached | tr '|' ',' | awk -v namevar="$name" '{print namevar $0;}' | awk -v instanceidvar="$i""," '{print instanceidvar $0;}' | awk -v hostvar="$host""," '{print hostvar $0;}' | sed -e 's/\<id\>//g' | sed 's/\://g' | sed 's/\"//g' | tr -d '[]{}' | tr -d ' '


# sed -i '1s/^/HOST,PROJECT, cpu , memory_mb , disk_gb  \n/' Stratus-Resource-Utilisation_HostDescribe1.txt
# sed -i 's/,$//' Stratus-Resource-Utilisation_HostDescribe1.txt
# sed '/^$/d' Stratus-Resourceant
-Utilisation_HostDescribe1.txt > Stratus-Resource-Utilisation_HostDescribe.csv
[{id: fd219dc2-ff9f-484d-b063-5546dadd02b0}, {id: 3c3ade81-22c5-4b4b-a6b6-100833c77f53}]
# cat stratus-resource-utilisation-novashow-volumes-report.txt | sed sed '/^\s*$/d'

# stratus-resource-utilisation-novashow-volumes-report.txt > stratus-resource-utilisation-novashow-volumes-report.csv
rt=`date +%d-%m-%y-%Hhr-%Mmin-%Ssec`
echo "sac-resource-utilisation-novashow-volumes-report.csv file" > mcon1
(cat mcon1 ; uuencode  stratus-resource-utilisation-novalist-report.csv  stratus-resource-utilisation-novalist-report.csv) | mail  gustavo.rojas@hpe.com -s "stratus-resource-utilisation-novashow-volumes-report.csv -- $rt"

# I need to create the a file with 
# http://stackoverflow.com/questions/4921879/getting-the-count-of-unique-values-in-a-column-in-bash

# awk -F '\t' '{print $1}' * Stratus-Resource-UtilisationInstances.csv | sort | uniq -c | sort -nr | > 123.txt

# sed -i '1s/^/HOST,ID, Name , Tenant ID , Status , Task State , Power State,Networks \n/' Stratus-Resource-UtilisationInstances.csv

# This part is for obtain the resources per host

cinder quota-usage FTL-testing
openstack quota show FTL-testing

openstack project list
+----------------------------------+-------------------+
| ID                               | Name              |
+----------------------------------+-------------------+
| 04af644a9b7b45c5b6293e1f92a77640 | demo              |
| 1090a9e2784f4206aec56cfbb2ac77b0 | CloudOps          |
| 33495e80139b4e659a57e3c18152da51 | glance-swift      |
| 5fa202e2682c4b17b57c65274740395b | backup            |
| 8b8dd2793263446aa05b3b56e50dcede | services          |
| 972d11480bf0478795583a9d54c1c449 | CMX               |
| a2662efb75a14de3b2246c3fe9b35b80 | CMX_Preproduction |
| a75d7b60714745eab0c9f4c345ae7322 | admin             |
| b0b732e9c2734a12b0fa50f0fcfa0d51 | FTL-testing       |
| d4ed5349429e4717be4ff7db5812c61d | swift-monitor     |
+----------------------------------+-------------------+


rt=`date +%d-%m-%y-%Hhr-%Mmin-%Ssec`
echo "stratus-resource-utilisation-novalist-report.csv file" > mcon1
(cat mcon1 ; uuencode  stratus-resource-utilisation-novalist-report.csv  stratus-resource-utilisation-novalist-report.csv) | mail  gustavo.rojas@hpe.com -s "stratus-resource-utilisation-novalist-report.csv -- $rt"

rt=`date +%d-%m-%y-%Hhr-%Mmin-%Ssec`
echo 'stratus-resource-utilisation-novashow-volumes-report.csv file' > mcon1
(cat mcon1 ; uuencode  stratus-resource-utilisation-novashow-volumes-report.csv  stratus-resource-utilisation-novashow-volumes-report.csv) | mail  gustavo.rojas@microfocus.com -s 'stratus-resource-utilisation-novashow-volumes-report.csv -- $rt'

rt=`date +%d-%m-%y-%Hhr-%Mmin-%Ssec`
echo 'all-volumes-three-par-and-open-stack.csv file' > mcon1
(cat mcon1 ; uuencode  all-volumes-three-par-and-open-stack.csv  all-volumes-three-par-and-open-stack.csv) | mail  gustavo.rojas@microfocus.com -s 'all-volumes-three-par-and-open-stack.csv -- $rt'



nova list --all-tenants --host  u03-isc-comp0001-mgmt

nova show 02557a50-74d9-490e-be9c-7b8aa564e990


awk -F "\"*,\"*" '{print $6}' stratus-resource-utilisation-novashow-volumes-report.csv
awk -F "\"*,\"*" '{print $7}' stratus-resource-utilisation-novashow-volumes-report.csv
awk -F "\"*,\"*" '{print $7}' stratus-resource-utilisation-novashow-volumes-report.csv



sed -e '/^[[:blank:]]*$/d' stratus-resource-utilisation-novashow-volumes-report.txt > stratus-resource-utilisation-novashow-volumes-report.csv