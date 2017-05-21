##Parametro: año: aaaa

if($#ARGV < 0){
	print "Debe indicar el año\n";
	exit;
}

$anio=@ARGV[0];

%servicios;
open(ARCHI, "<datos/categorias.txt") || die "Archivo de categorias inexistente\n";
@registros=<ARCHI>;
close(ARCHI);

foreach my $linea (@registros) {
	chomp($linea);
	($categoria, $servicio)=split(";",$linea);
	if(!exists $servicios{$servicio}){
		$servicios{$servicio}=$categoria;
	}
}

opendir(DIR, "datos") || die "directorio de datos inexistente\n";
@archivos=readdir(DIR);
closedir(DIR);

$hay_archivos="N";
%categorias;
foreach my $archivo (@archivos){
	if($archivo ne "." && $archivo ne ".."){
		if($archivo =~ /trafico$anio[0-9][0-9].txt/){
			$hay_archivos="S";
			open(ARCHI, "<datos/$archivo") || die "Error abriendo el archivo $archivo\n";
			@lineas=<ARCHI>;
			close(ARCHI);
			foreach $linea (@lineas){
				chomp($linea);
				($usuario_servicio,$dia,$kb)=split(";",$linea);
				($usuario,$servicio)=split("-",$usuario_servicio);
				$categoria=$servicios{$servicio};
				if(! exists $categorias{$categoria}){
					$categorias{$categoria} = 0;
				}
				$categorias{$categoria}+=$kb;
			}
		}
	}
}

if($hay_archivos eq "N"){
	print "No hay archivos para el año indicado ($anio). Ingrese otro\n";
	exit;
}

if(! -d "hashtotal"){
	print "El directorio hashtotal no existe\n";
	exit;
}

if(! -e "hashtotal/reporte.txt"){
	open(ARCHI, ">hashtotal/reporte.txt");
}else{
	open(ARCHI, ">>hashtotal/reporte.txt");
}

foreach $categoria (keys %categorias){
	print ARCHI "$anio;$categoria;$kb\n";
}

close(ARCHI);
