CREAR DB
az mariadb server create --resource-group myrg_dbservers --name mydemoserver --location westus --admin-user myadmin --admin-password <server_admin_password> --sku-name GP_Gen5_2 --version 10.2

ACCESO FIREWALL
az mariadb server firewall-rule create --resource-group myresourcegroup --server mydemoserver --name AllowMyIP --start-ip-address 192.168.0.1 --end-ip-address 192.168.0.1

SSL
az mariadb server update --resource-group myresourcegroup --name mydemoserver --ssl-enforcement Disabled

CONNECCION INFO
az mariadb server show --resource-group myresourcegroup --name mydemoserver
