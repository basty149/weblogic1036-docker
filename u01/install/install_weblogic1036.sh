#!/bin/bash

# Déclaration des variables
v_user_weblogic=weblogic
v_mot_de_passe_weblogic=weblogic01
v_chemin_binaires=/u01/middleware1036
v_java=/u01/jdk1.6.0_45/bin/java
v_template=/u01/middleware1036/wlserver_10.3/common/templates/domains/wls.jar
v_chemin_domaine=/u01/domains
v_nom_domaine=base_domain
v_logiciel=/u01/install/wls1036_generic.jar
v_tmp_silent=/tmp/$$_silent.xml

# Installation de JVM
(cd /u01/ ; sh install/jdk-6u45-linux-x64.bin)

# Installation de Weblogic
echo '<?xml version="1.0" encoding="UTF-8"?>
<domain-template-descriptor>

<input-fields>
   <data-value name="BEAHOME"                   value="'$v_chemin_binaires'" />
   <data-value name="USER_INSTALL_DIR"          value="'$v_chemin_binaires'" />
   <data-value name="INSTALL_NODE_MANAGER_SERVICE"   value="no" />
   <data-value name="COMPONENT_PATHS" value="WebLogic Server|WebLogic Server/Administration Console" />
</input-fields>
</domain-template-descriptor>' > $v_tmp_silent

$v_java -jar $v_logiciel -mode=silent -silent_xml=$v_tmp_silent

source $v_chemin_binaires/wlserver_10.3/server/bin/setWLSEnv.sh

#
# https://docs.oracle.com/cd/E23943_01/web.1111/e14138/templates.htm#i1115503
# https://docs.oracle.com/cd/E28271_01/web.1111/e13813/reference.htm#i1250459
#
$v_java weblogic.WLST <<EOF
createDomain('$v_template','$v_chemin_domaine/$v_nom_domaine','$v_user_weblogic','$v_mot_de_passe_weblogic')
exit()
EOF


