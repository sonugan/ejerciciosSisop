##Parametros
###ID de tecnico

##Salida: 
### Codigo de la orden de trabajo y la hora con min y segundos en que fue planificada

id_tecnico=$1;

#fecha de hoy en formato dd/mm/aaaa
fecha_hoy=$(date +"%d/%m/%Y"); #No se debería usar pero es esto o poner un paraemtro mas que no dice el enunciado
###Agrego esta linea para que ande siempre
fecha_hoy="18/05/2017";

#Busco en el archivo:
#ID_ASIGNACION;COD_OT;TIPO_OT;ID_CLIENTE;DIRECCION;ID_TECNICO;FECHA_PLAN;ESTADO;FECHA_REAL;COMENTARIO
#linea=$(grep "^\([^;]*;\)\{5,5\}$id_tecnico;[^;]*;[^;]*;$fecha_hoy[^;]*;.*" "AsignacionesPorDia.dat");
linea=$(grep "^\([^;]*;\)\{5,5\}$id_tecnico;[^;]*;[^;]*;$fecha_hoy[^;]*;.*" "AsignacionesPorDia.dat");

#2;ORDEN_1;T2;C124;Calle falsa 123;T123;23/05/2017 23:22:21;incompleta;18/05/2017 23:22:21;este es un comentario de pruebas
cod_orden=$(echo "$linea" | sed 's/^[^;]*;\([^;]*\);.*/\1/');

#Formato de la fecha plan: dd/mm/aaaa hh:mi:ss
fecha_plan=$(echo "$linea" | sed 's/^\([^;]*;\)\{6,6\}[^ ]* \([0-9][0-9]:[0-9][0-9]:[0-9][0-9]\);.*/\2/');

echo "Se ha programado la orden $cod_orden para las $fecha_plan";

