#/*----------------------------------------
#Pràctica 4 - awk
#Grau en Enginyeria Informàtica
#Administració i Manteniment de Sistemes i Aplicacions
#Joel Farré Cortés - 78103400T
#----------------------------------------*/
#!/bin/bash
if [ `whoami` != "root" ] 
then
	echo "ERROR: Has d'estar registrat com a root per executar el programa."
	exit -1
fi

# S'inicialitza el runlevel a 5
init 5
echo "---------- Runlevel 5 inicialitzat ----------"

# S'actualitza el repositori d'Ubuntu
echo "---------- Actualitzant el repositori ----------"
apt-get update
echo "---------- Repositori actualitzat ----------"

# S'instala el servidor web
echo "---------- Instal·lant el servidor web ----------"
apt-get install apache2
echo "---------- Servidor instal·lat ----------"

# Es comprova l'estat del servidor
echo "---------- Comprovant estat del servidor ----------"
systemctl status apache2
