
dir_log=$1;

#Valido que exista  el directorio
if [ ! -d "$dir_log" ]
then
	echo "Error: no existe el directorio $dir_log";
	exit;
fi;

for file in $(ls "$dir_log")
do
	path="$dir_log/$file";
	#Valido que el archivo sea regular
	if [ -f "$path" ] 
	then
		estructura_nombre_valida=$(echo "$file" | sed "s/AP_[0-9]\{6,6\}.log/S/");
		if [ $estructura_nombre_valida == "S" ]
		then
			anio_mes_archivo=$(echo "$file" | sed "s/AP_\([0-9]\{6,6\}\).log/\1/");
			#valido que sea una fecha valida
			anio_mes_hoy=$(date +"%Y%m");
			if [ $anio_mes_hoy -ge $anio_mes_archivo ]
			then
				while read -r linea
				do
					#Si el registro es un error
					es_error=$(echo "$linea" | sed "s/^[^;]*;ERROR;.*/S/");
					if [ $es_error == "S" ]
					then
						#Si es un registro de una app valida
						cod_app=$(echo "$linea" | sed "s/^[^;]*;[^;]*;\([^;]*\);.*/\1/");
						res=$(grep "^$cod_app;.*" "mae/aplic.dat");
						if [ "$?" -eq 0 ]
						then
							echo "$linea";
						fi;
					fi;
				done < "$path";
			fi;
		else
			echo "$path, no tiene un nombre valido";
		fi
	else
		echo "$path, no es un archivo regular";
	fi
done;