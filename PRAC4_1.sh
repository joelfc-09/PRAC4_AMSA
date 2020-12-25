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

cd /proc

# Es crea el document mem_lliure.lst i s'escriu la data.
echo "---------- Creant el document ----------"
awk 'BEGIN{system("date")}'>/home/mem_lliure.lst

echo "---------- Escrivint al document ----------"
echo "Temps restant:"
for i in {60..1}; do
	# Escriu al fitxer la memòria total i lliure.
	awk '/MemTotal/{memt=$2; print memt};/MemFree/{memf=$2; print memf; exit}' meminfo >> /home/mem_lliure.lst
	# Escriu al fitxer la càrrega del sistema durant l'últim minut.
	 awk '{print $1}{exit}' loadavg >> /home/mem_lliure.lst
	# Escriu al fitxer la meòria disponible i utilitzada del sistema de fitxers.
	awk 'BEGIN{FS=","}/dev/&&/size/{tmp=$3;print tmp}' mounts | awk 'BEGIN{FS="="}NR==1{print $2}' >> /home/mem_lliure.lst
	echo "$i"
	sleep 1
done

echo "---------- Informació escrita ----------"

# Es torna a escriure la data.
awk 'BEGIN{system("date")}' >> /home/mem_lliure.lst

echo "Vols esborrar el document? S/N"
read opcio
if [ $opcio == "S" ]
then
	rm -rf mem_lliure.lst
	echo "Fitxer esborrat."
	exit 0
fi
if [ $opcio == "N" ]
then
	exit 0
fi
