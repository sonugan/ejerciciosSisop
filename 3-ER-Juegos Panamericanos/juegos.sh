##Parametros:
###Pais
###Disciplina

##Salida:
####Si ganó una medalla:
###<Nombre_de_país> obtuvo una medalla <metal_de_medalla> en
###<nombre_de_disciplina>” si ganó una medalla.

###No no ganó una medalla en la disciplina:
##<Nombre_de_país> no obtuvo ninguna medalla en
##<nombre_de_disciplina>

pais=$1;
disciplina=$2;

#CODIGO_PAIS;NOMBRE_PAIS;CODIGO_DISCIPLINA;NOMBRE_DISCIPLINA;FECHA_FINAL;ORO;PLATA;BRONCE;BATIO_RECORD;COMENTARIOS
#001;Argentina;01;Voley;esta es una fecha y no me importa;S;N;N;N;Comentario de prueba

linea=$(grep "^[^;]*;$pais;[^;]*;$disciplina;.*" "Resultados.dat");

mensajeOro=$(echo "$linea" | sed "s/^\([^;]*;\)\{5,5\}S.*/$pais obtuvo una medalla de oro en $disciplina/");
mensajePlata=$(echo "$linea" | sed "s/^\([^;]*;\)\{5,5\}[S N];S;.*/$pais obtuvo una medalla de plata en $disciplina/");
mensajeBronce=$(echo "$linea" | sed "s/^\([^;]*;\)\{5,5\}[S N];[S N];S;.*/$pais obtuvo una medalla de bronce en $disciplina/");

mensajeOro=$(echo "$mensajeOro" | sed "s/$linea//");
mensajePlata=$(echo "$mensajePlata" | sed "s/$linea//");
mensajeBronce=$(echo "$mensajeBronce" | sed "s/$linea//");

mensajeNoGano=$(echo "$linea" | sed "s/^\([^;]*;\)\{5,5\}N;N;N;.*/$pais no obtuvo ninguna medalla en $disciplina/");
mensajeNoGano=$(echo "$mensajeNoGano" | sed "s/$linea//");

echo "$mensajeOro";
echo "$mensajePlata";
echo "$mensajeBronce";
echo "$mensajeNoGano";


