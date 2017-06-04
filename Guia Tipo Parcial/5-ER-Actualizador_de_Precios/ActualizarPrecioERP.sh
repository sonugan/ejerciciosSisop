##Parametros
###ID del articulo del ERP
###Precio: sin separador de decimales. Los dos ultimos nros son los decimales
###ID de sucursal destino

id_articulo=$1;
precio=$2;
id_sucursal=$3;

#ID_ARTICULO;NOMBRE;DESCRIPCION;COD_EAN13;COD_EAN7;OTROS

##Busco el codigo de articulo
codigo=$(grep "^$id_articulo;.*" ARTICULOS.dat | sed "s/\($articulo\);.*/\1/");

precio=$(sed "s/^\([0-9]*\)\([0-9][0-9]\)$/\1\.\2/");
echo $precio;
echo $codigo;
#return SetPriceFlejes $codigo $precio $id_sucursal;