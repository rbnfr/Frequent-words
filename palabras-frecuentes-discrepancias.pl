$|=1;
use strict;
use warnings;
use bio;
my $secuencia = "ACGTTGCATGTCGCATGATGCATGAGAGCT";
my $k = 5;
my $discrepancias = 2;
print "En la siguiente secuencia: ".$secuencia.", se repiten con más frecuencia los siguientes grupos de ".$k." nucleotidos si se permiten ".$discrepancias." discrepancias: ".join(", ",palabrasfrecuentesdiscrepancias($secuencia,$k,$discrepancias)).".";