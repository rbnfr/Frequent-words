$|=1;
sub vecinasD{
    my ($secuencia,$d)=@_;
    my %vecinas = ($secuencia => 1);
    my (@vecinas,$elemento,$vecina);
    #Se recorre la cadena "d" veces
    for (my $i = 1; $i <= $d; $i++){
        #Para cada elemento de la tabla, se guarda una lista con sus variaciones
        foreach $elemento(keys %vecinas){
            #Cada variacion se añade o se actualiza en la tabla
            @vecinas=vecinas1($elemento);
            foreach $vecina(@vecinas){
                $vecinas{$vecina} = 1;
            }
        }
    }
    return keys(%vecinas);
    }
    
sub PalabrasFrecuentes{
    my ($secuencia, $k) = @_; # Parámetros
    
    # Variables locales
    my %tabla = (); # Tabla que asocia los k-meros con un contador de apariciones
    my $max_apariciones = 0; # Número máximo de apariciones
    my @resultado = (); # Lista que almacena el resultado de la función
    
    # 1. Recorrer la secuencia y construir la tabla de apariciones de k-meros
    for (my $i = 0; $i < (length $secuencia) - ($k - 1); $i++) {
    my $kmero = substr ($secuencia, $i, $k);
        if (exists $tabla{$kmero}) {
            $tabla{$kmero} += 1;
        }
        else {
            $tabla{$kmero} = 1;
        }
    }
    # 2. Recorrer la columna "valores" para buscar el número máximo de apariciones
    foreach my $contador (values %tabla) {
        if ($contador > $max_apariciones) {
            $max_apariciones = $contador;            
        }        
    }
        # Este valor será asignado a "max_apariciones".
    # 3. Recorrer la tabla y añadir a la lista "resultado" los k-meros con "max_apariciones"
    foreach my $kmero (keys %tabla) {
        if ($tabla{$kmero} == $max_apariciones) {
            push @resultado, $kmero;        
        }
    }
 
    return @resultado;
}
sub vecinas1{
    #Parametros
    my ($secuencia) = @_;
    
    #Variables locales
    chomp ($secuencia);
    my @vecina = ($secuencia);
    my @nucleotidos = ("A","T","C","G");
    my ($letra,$vecina);
        #Bucle para recorrer cada caracter de la secuencia.
        for (my $i = 0; $i < (length $secuencia); $i++){
            #Se extrae cada nucleotido y se almacena
            $letra = substr($secuencia,$i,1);
            #Se compara con los nucleotidos que hemos guardado en la lista.
            foreach my $nucleotido (@nucleotidos){
                #Los que no coincidan se introducen en la cadena y el resultado se añade a la lista junto a la secuencia original.
                if ($nucleotido ne $letra) {
                    $vecina = substr($secuencia,0,$i).$nucleotido.substr($secuencia,$i+1); 
                    push(@vecina, $vecina);
                }
            }
        }
        return @vecina;
    }
sub palabrasfrecuentesdiscrepancias{
    my ($secuencia, $k, $d) = @_; 
    my %tabla = ();
    my $max_apariciones = 0;
    my @resultado = ();
    my @candidatas = ();
    my ($candidata);
    #Bucle para recorrer la secuencia un numero de veces tal que
    #el ultimo nucleotido del ultimo kmero sea el ultimo de la secuencia.
    for (my $i = 0;$i < (length $secuencia)-($k-1); $i++){
        #Extraccion de los kmeros de la secuencia.
        my $kmero = substr($secuencia,$i,$k);
        #Se crea una lista con las posibles variaciones del kamero permitiendo "d" variaciones mediante
        #la función vecinasD.
        @candidatas = vecinasD($kmero,$d);
        #Bucle para agregar cada candidata generada mediante vecinasD a la tabla, si no existe,
        #o actualizar su contador si ya se encuentra en la tabla.
        foreach $candidata(@candidatas){ 
            if (exists $tabla{$candidata}) {
                $tabla{$candidata} += 1;
            }
            else {
                $tabla{$candidata} = 1;
            }
        }
    }
    #Una vez construida la tabla, se recorren los valores numericos asociados a
    #cada secuencia candidata, guardandolos en la variable contador, y pasando el valor a
    #max_apariciones cuando el valor sea mayor que el que ya tuviera esta ultima variable.
    #De esta forma, max_apariciones se quedara con el valor más alto de la tabla.
    foreach my $contador(values %tabla){ 
        if ($contador > $max_apariciones) {
                $max_apariciones = $contador;
        }
    }
    #Se recorren las candidatas de la tabla y se compara su valor con el mas
    #alto (max_apariciones). Si coinciden los valores, la cadidata se guarda
    #como palabra frecuente.
    foreach $candidata (keys %tabla) {
        if ($tabla{$candidata} == $max_apariciones) {
            push @resultado, $candidata;        
        }
    }
return @resultado;
}
sub cargarfasta{
    my ($fichero)=@_;
    my @lineas = ();
    my %resultado = ();
    my $secuencia="";
    my ($cabecera);
    open(FICHERO,$fichero);
    if (not open(FICHERO,$fichero)) {
        $resultado{'error'} = 1;
        return %resultado;
    }
    @lineas = <FICHERO>; 
   
    #Construccion de la tabla
    foreach my $linea(@lineas){
        #Si la linea comienza con el caracter ">", lo añadira a la variable "cabecera".
        if ($linea =~ /^>/) {
            $cabecera = $linea;
            $secuencia = ""; #Esta linea evita que se guarde la primera secuencia bajo el segundo identificador.
        }
        #El resto de lineas serán asignadas a la variable secuencia, hasta que se encuentre otra cabecera.
        else { 
            $secuencia .= $linea;
            chomp($secuencia); 
        }
        #Se almacena el resultado en la tabla, asociando a cada cabecera la serie de lineas que le siguen en el fichero FASTA.
        $resultado{$cabecera} = $secuencia; 
    }
    close(FICHERO);
return %resultado;
}
    
