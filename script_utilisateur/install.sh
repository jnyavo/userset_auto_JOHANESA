#Creation du daemon



#Modifier ici
CHEMIN_BDD="/home/BDD_user"
FICHIER_BDD="BDD.xls"
CHEMIN_SH="/usr/bin/check_user.sh"


#Ne pas modifier
sudo printf "%s\n" "[Unit]" "Description=Inscription automatique des utilisateurs" "[Service]" "ExecStart=${CHEMIN_SH} ${CHEMIN_BDD}/${FICHIER_BDD}" "Restart=on-failure" "[Install]" "WantedBy=multi-user.target" > /etc/systemd/system/check_user_nyavo.service

cp check_user.sh ${CHEMIN_SH} 

sudo chmod +x ${CHEMIN_SH}

#mise en place de la base de données xls
mkdir -p ${CHEMIN_BDD}

cp ${FICHIER_BDD} ${CHEMIN_BDD}



#Lancement du daemon
systemctl start check_user_nyavo.service
