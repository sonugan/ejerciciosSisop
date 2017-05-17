#Parametros:
##Número de teléfono origen---> (nn)(nnnnnn)nnnn
###---->>	caracteres 6 a 11 contienen el código de área
###---->> 	caracteres 13 a 16 contienen el número
##Código del cliente
##Canal


###Api: RegistrarVentaPPV
####Parametros: 
##-------> código de cliente
##-------> señal PPV

####Archvivo: Signals&Chanels.dat


telefono="$1";
cod_cliente="$2";
canal="$3";

cod_area=$(echo "$telefono" | sed 's/^([0-9]\{2,2\})(\([0-9]\{6,6\}\))[0-9]\{4,4\}/\1/');
senial=$(grep "^[^;]*;[^;]*;[^;]*;$cod_area;$canal;.*" "Signals&Chanels.dat" | sed 's/^[^;]*;\([^;]*\);.*/\1/');

#echo "$cod_area";
#echo "$senial";

#Llamo al api:
RegistrarVentaPPV "$cod_cliente" "$senial";
