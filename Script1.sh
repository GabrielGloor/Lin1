# Création des fichiers LDIF
echo "Création des fichiers LDIF..."
cat <<EOT > ./ldap_groups.ldif
dn: cn=Managers,ou=Groups,dc=lin1,dc=local
objectClass: top
objectClass: posixGroup
gidNumber: 20000

dn: cn=Ingenieurs,ou=Groups,dc=lin1,dc=local
objectClass: top
objectClass: posixGroup
gidNumber: 20010

dn: cn=Developpeurs,ou=Groups,dc=lin1,dc=local
objectClass: top
objectClass: posixGroup
gidNumber: 20020
EOT

cat <<EOT > ./ldap_users.ldif
dn: uid=man1,ou=Users,dc=lin1,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
objectClass: person
uid: man1
userPassword: {crypt}x
cn: Man 1
givenName: Man
sn: 1
loginShell: /bin/bash
uidNumber: 10000
gidNumber: 20000
displayName: Man 1
homeDirectory: /mnt/Share/Perso/man1
mail: man1@$Ldap_Domain_Name
description: Man 1 account

dn: uid=man2,ou=Users,dc=lin1,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
objectClass: person
uid: man2
userPassword: {crypt}x
cn: Man 2
givenName: Man
sn: 2
loginShell: /bin/bash
uidNumber: 10001
gidNumber: 20000
displayName: Man 2
homeDirectory: /mnt/Share/Perso/man2
mail: man2@$Ldap_Domain_Name
description: Man 2 account

dn: uid=ing1,ou=Users,dc=lin1,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
objectClass: person
uid: ing1
userPassword: {crypt}x
cn: Ing 1
givenName: Ing
sn: 1
loginShell: /bin/bash
uidNumber: 10010
gidNumber: 20010
displayName: Ing 1
homeDirectory: /mnt/Share/Perso/ing1
mail: ing1@$Ldap_Domain_Name
description: Ing 1 account

dn: uid=ing2,ou=Users,dc=lin1,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
objectClass: person
uid: ing2
userPassword: {crypt}x
cn: Ing 2
givenName: Ing
sn: 2
loginShell: /bin/bash
uidNumber: 10011
gidNumber: 20010
displayName: Ing 2
homeDirectory: /mnt/Share/Perso/ing2
mail: ing2@$Ldap_Domain_Name
description: Ing 2 account

dn: uid=dev1,ou=Users,dc=lin1,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
objectClass: person
uid: dev1
userPassword: {crypt}x
cn: Dev 1
givenName: Dev
sn: 1
loginShell: /bin/bash
uidNumber: 10020
gidNumber: 20020
displayName: Dev 1
homeDirectory: /mnt/Share/Perso/dev1
mail: dev1@$Ldap_Domain_Name
description: Dev 1 accountEOT

cat <<EOT > ./ldap_ou.ldif
dn: ou=Users,dc=lin1,dc=local
objectClass: organizationalUnit
ou: Users

dn: ou=Groups,dc=lin1,dc=local
objectClass: organizationalUnit
ou: Groups
EOT

cat <<EOT > ./ldap_admin.ldif
dn: cn=admin,dc=lin1,dc=local
changetype: modify
replace: userPassword
userPassword: Password
EOT

