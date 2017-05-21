##Parametros:
###ID de espectador
###Directorio de input


##Validar que haya exactamente 2 parametros sino terminar ejecucion
##Validar que en el directorio de input exista al menos un archivo de espectadores. Si no existe o no tiene archivos, terminar ejecicion

if($#ARGV != 1){
	print "Error: la cantidad de parametros no es correcta!!\n";
	exit;
}

$id_espectador=@ARGV[0];
$directorio=@ARGV[1];

opendir(DIR, "$directorio") || die "Error: el directorio no existe\n";

@archivos=readdir(DIR);

$contador=0;
foreach $archivo (@archivos){
	if($archivo ne "." && $archivo ne ".."){
		$contador++;
	}
}
closedir(DIR);

if($contador==0){
	print "Error: el directorio se encuentra vacio!!\n";
	exit;
}

if(! -e "catalogos/peliculas.mae"){
	print "Error: el archivo de peliculas no existe\n";
}

#Levanto los generos de cada pelicula
open(ARCHI, "<catalogos/peliculas.mae") || die "Error: abiendo el archivo de peliculas\n";
@lineas=<ARCHI>;
close(ARCHI);
%peliculas;
foreach $pelicula (@lineas){
	chomp($pelicula);
	($id_pelicula, $titulo, $clasificacion, $duracion, $direccion, $produccion, $categoria, $protagonistas)=split(":",$pelicula);
	($genero,$subgenero)=split("-",$categoria);
	if(!exists $peliculas{$id_pelicula}){
		$peliculas{$id_pelicula}=$genero; 
	}
}

%generos;
foreach $archivo (@archivos){
	if($archivo ne "." && $archivo ne ".."){
		open(ARCHI, "<data/$archivo") || die "Error abriendo el archivo $archivo";
		@lineas=<ARCHI>;
		close(ARCHI);
		foreach $linea (@lineas){
			chomp($linea);
			($sala, $id, $id_pelicula, $funcion, $fecha, $cant_entradas)=split(":",$linea);
			if($id_espectador eq $id){
				if(exists $peliculas{$id_pelicula}){
					$genero=$peliculas{$id_pelicula};
				}else{
					$genero="Indeterminado";
				}
				if(!exists $generos{$genero}){
					$generos{$genero}=0;
				}
				$generos{$genero}+=$cant_entradas;
			}
		}
	}	
}

foreach $genero (keys %generos){
	print "Clave: $genero Cantidad de entradas: $generos{$genero}\n";
}

print "Desea guardar el resultado en un archivo?\n";
$res=<STDIN>;
chomp($res);
if($res eq "SI"){
	opendir(DIR,"output") || die "Error: el directorio output no existe\n";
	open(ARCHI,">output/$id_espectador.txt") || die "Error creando el archivo de salida\n";
	foreach $genero (keys %generos){
		printf ARCHI "Clave: $genero Cantidad de entradas: $generos{$genero}\n";
	}
	close(ARCHI);
}


