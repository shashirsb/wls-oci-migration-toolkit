echo "==================="

echo "Tenancy OCID"
echo "ocid1.tenancy.oc1..aaaaaaaaro7aox2fclu4urtpgsbacnrmjv46e7n4fw3sc2wbq24l7dzf3kba"

echo "Region"
echo "us-phoenix-1"

echo "User OCID"
echo "ocid1.user.oc1..aaaaaaaadm5bgksiguoedcgp7zszuukweh647exriceuub4d3x4tpe7phbza"
echo " "
echo " "
echo "==================="
read -p "If you want to continue press Y [Y/N]: " useroption
if [ $useroption == 'Y' ] || [ $useroption == 'y' ]; then
    continue;
else
   exit;
fi
