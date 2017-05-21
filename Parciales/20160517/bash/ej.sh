#Validar que el nombre de los archivos sea correcto: fecha valida y anterior a la actual
#Para cada registro: validar que exista un registro en el maestro para el id_servicio y la region
#Si hay archivos o registros con error, guardarlos en rechazados


es_fecha_valida(){
	echo $1;
	date -d "$1" "+%Y%m%d" > /dev/null 2>&1;
	return "$?";
}

rechazar(){
	mv "input/$1" "rechazados/$1";
}

for file in $(ls "input")
do
	fecha_archivo=$(echo "$file" | sed "s/sol_fact_\([0-9]*\)/\1/");
	
	#Valido que tenga una fecha valida
	res=$(date -d "$fecha_archivo" "+%Y%m%d" > /dev/null 2>&1);
	if [ "$?" -ne 0 ]
	then
		rechazar "$file";
	else
		#valido que la fecha sea anterior a la actual
		fecha_actual=$(date +"%Y%m%d");
		res=$(echo "$fecha_actual - $fecha_archivo" | bc);
		if [ "$res" -le 0 ]
		then
			rechazar "$file";
		else
			#Para cada registro: validar que exista un registro en el maestro para el id_servicio y la region
			while read -r linea;
			do
				id_servicio=$(echo "$linea" | sed "s/^\([^;]*\);.*/\1/");
				region=$(echo "$linea" | sed "s/^\([^;]*;\)\{3,3\}\([^;]*\);.*/\2/");

				linea_maestro=$(grep "$id_servicio;[^;]*;$region;.*" "mae/segba.dat");
				if [ "$?" -ne 0 ]
				then
					if [ ! -e "rechazados/$file" ]
					then
						touch "rechazados/$file";
					fi;			
					echo "$linea" >> "rechazados/$file";
				else
					porcentaje=$(echo "$linea_maestro" | sed "s/^[^;]*;[^;]*;[^;]*;\(.*\)/\1/");
					importe=$(echo "$linea" | sed "s/^[^;]*;[^;]*;\([^;]*\);.*/\1/");
					id_cuenta=$(echo "$linea" | sed "s/^[^;]*;\([^;]*\);.*/\1/");
					fecha_vto=$(echo "$linea" | sed "s/^[^;]*;[^;]*;[^;]*;[^;]*;\(.*\)/\1/");
					res=$(grep "$cuenta" "mae/tarifa_social.dat");
					if [ "$?" -eq 0 ]
					then
						porcentaje=0;
					fi;

					nuevo_importe=$(echo "$importe+$importe*$porcentaje" | bc -l);
					if [ ! -e "resultado/$file" ]
					then
						touch "resultado/$file";
					fi;
					echo "$id_servicio;$id_cuenta;$nuevo_importe;$fecha_vto" >> "resultado/$file";
				fi;
			done < "input/$file";		
		fi;
	fi;

	
done;