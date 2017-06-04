
param="$1";

cant_huesp=$(echo "$param" | sed 's/\(^[^,]*\),.*/\1/');
estrellas=$(echo "$param" | sed 's/^[^,]*,\(.*\)/\1/');

lineas=$(grep "^[^-]*-[^-]*-[^-]*-[^-]*-[^-]*-17\/02\/2013-DISP" "disponibilidad.dat" | wc -l);

echo "$lineas";




