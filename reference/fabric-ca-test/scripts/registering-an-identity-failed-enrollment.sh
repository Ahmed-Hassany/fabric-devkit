#!/bin/bash

echo "========================================================="      
echo " fabric-ca-server started with the following credentials "
echo " admin:adminpw"
echo "========================================================"
echo 
echo "Expected user in fabric-ca-server database"
echo "  admin"
echo
sqlite3 ./fabric-ca-server/fabric-ca-server.db "select * from users"
echo

echo "========================================================="
echo "Enrolling this client with the following credentials"
echo "at fabric-ca-server:7050"
echo "========================================================="
echo
echo "  username: admin1"
echo "  password: admin1pw"
echo
fabric-ca-client enroll -u http://admin1:admin1pw@fabric-ca-server:7054
echo "Client not enrolled!"

echo
id_attrs='hf.Revoker=true,admin=true:ecert'
echo "======================================================"
echo "Registering a peer following an unsucessful enrollment"
echo "======================================================"
echo
echo " id.type: peer"
echo " id.name: admin1"
echo " id.affliliation: org1.department1"
echo " id.attrs: '$id_attrs'"
echo
fabric-ca-client register --id.type peer --id.name admin1 --id.affiliation org1.department1 --id.attrs $id_attrs

