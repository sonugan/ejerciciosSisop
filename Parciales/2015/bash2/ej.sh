
if [ "$#" -eq 1 ]
then
	id_cliente=$1;
	for file in $(ls "ok")
	do
		coincidencias=$(grep "^$id_cliente|.*" "ok/$file");
		for linea in $coincidencias
		do
			nombre_apellido=$(grep "^$id_cliente,.*" "mae/clientes.dat" | sed "s/^$id_cliente,\([^,]*\),.*/\1/");
			linea=$(echo "$linea" | sed "s/^\($id_cliente\)|/\1 $nombre_apellido /");
			linea=$(echo "$linea" | sed "s/|/ /g");
			echo "$linea";
		done;
	done;
fi;

if [ ! -d "novedades" ]
then
	echo "Error: no existe el archivo de novedades";
	exit;
fi;

for file in $(ls "novedades")
do
	formato_nombre_valido=$(echo "$file" | sed "s/^[^_]\{1,\}_[0-9]\{6,6\}.txt/S/");
	if [ "$formato_nombre_valido" != "S" ]
	then
		mv "novedades/$file" "rechazados/$file";
	else
		oficina=$(echo "$file" | sed "s/^\([^_]*\)_.*/\1/");
		res=$(grep "^$oficina,.*" "mae/oficinas.dat");
		if [ "$?" -ne 0 ]
		then
			mv "novedades/$file" "rechazados/$file";
		else
			valido="S";
			while read -r linea
			do
				formato_registro_valido=$(echo "$linea" | sed "s/^[^|]\{1,\}|[^|]\{1,\}|[^|]\{1,\}/S/");
				if [ "$formato_registro_valido" != "S" ]
				then
					mv "novedades/$file" "rechazados/$file";
					valido="N";
					echo "3";
					break;
				else
					id_cliente=$(echo "$linea" | sed "s/^\([^|]*\)|.*/\1/");
					res=$(grep "^$id_cliente,.*" "mae/clientes.dat");
					if [ "$?" -ne 0 ]
					then
						#cliente invalido
						mv "novedades/$file" "rechazados/$file";
						valido="N";
						echo "4";
						break;
					fi;
				fi;
			done < "novedades/$file";

			if [ "$valido" == "S" ]
			then
				mv "novedades/$file" "ok/$file";
			fi;
		fi;
	fi;
done;