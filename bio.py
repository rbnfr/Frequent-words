#bio.py
from typing import Union

def palabrasfrecuentesdiscrepancias(sequence, k, discrepances) -> Union[list, int]:
    tabla = dict()
    max_apariciones = 0
    resultado = list()
    candidatas = list()
    candidata = ""

    # Bucle para recorrer la secuencia un numero de veces tal que
    # el ultimo nucleotido del ultimo kmero sea el ultimo de la secuencia.
    for i in range(len(sequence) - (k-1)):
        #Extraccion de los kmeros de la secuencia.
        kmer = sequence[i:k+i]
        # Se crea una lista con las posibles variaciones del kamero permitiendo "d" variaciones mediante
        # la función vecinasD.
        candidatas = vecinasD(kmer,discrepances)
        # Bucle para agregar cada candidata generada mediante vecinasD a la tabla, si no existe,
        # o actualizar su contador si ya se encuentra en la tabla.
        for candidata in candidatas: 
            if candidata in tabla:
                tabla[candidata] += 1
            else:
                tabla[candidata] = 1
            

    # Una vez construida la tabla, se recorren los valores numericos asociados a
    # cada secuencia candidata, guardandolos en la variable contador, y pasando el valor a
    # max_apariciones cuando el valor sea mayor que el que ya tuviera esta ultima variable.
    # De esta forma, max_apariciones se quedara con el valor más alto de la tabla.
    for contador in tabla.values(): 
        max_apariciones = contador if contador > max_apariciones else max_apariciones
        
    
    # Se recorren las candidatas de la tabla y se compara su valor con el mas
    # alto (max_apariciones). Si coinciden los valores, la cadidata se guarda
    # como palabra frecuente.
    for candidata in tabla.keys():
        if tabla[candidata] == max_apariciones:
            resultado.append(candidata)
    
    return resultado, max_apariciones

def vecinasD(kmer, discrepances) -> list:
    vecinas = {kmer : 1}
    vecinas_list = list()
    #Se recorre la cadena "d" veces
    for i in range(discrepances):
        #Para cada elemento de la tabla, se guarda una lista con sus variaciones
        for elemento in (vecinas.keys()):
            #Cada variacion se añade o se actualiza en la tabla
            vecinas_list = vecinas1(elemento)
        for vecina in vecinas_list:
            vecinas[vecina] = vecinas.get(vecina, 0) + 1
    
    return list(vecinas.keys())

def vecinas1(sequence:str) -> list:    
    #Variables locales
    vecina = str()
    vecinas = list()
    nucleotids = ["A","T","C","G"]
    # my ($letra,$vecina);
    #Bucle para recorrer cada caracter de la secuencia.
    for i in range(len(sequence)):
        for nucleotid in nucleotids:
            #Se compara con los nucleotidos que hemos guardado en la lista.
            #Los que no coincidan se introducen en la cadena y el resultado se añade a la lista junto a la secuencia original.
            if list(sequence)[i] != nucleotid:
                vecina = sequence[0:i] + nucleotid + sequence[i+1:]
                vecinas.append(vecina)
        
    return vecinas
   
def PalabrasFrecuentes(sequence:str, k:int):    
    # Variables locales
    tabla           = dict(); # Tabla que asocia los k-meros con un contador de apariciones
    max_apariciones = 0       # Número máximo de apariciones
    resultado       = list(); # Lista que almacena el resultado de la función
    
    # 1. Recorrer la secuencia y construir la tabla de apariciones de k-meros
    for i in range(len(sequence)-(k-1)):
        kmero = sequence[i:k]
        tabla[kmero] = tabla.get(kmero, 0) + 1

    # 2. Recorrer la columna "valores" para buscar el número máximo de apariciones
    for contador in tabla.values():
        max_apariciones = contador if contador > max_apariciones else max_apariciones
    
    # 3. Recorrer la tabla y añadir a la lista "resultado" los k-meros con "max_apariciones"
    for kmero in tabla.keys():
        if (tabla[kmero] == max_apariciones):
            resultado.append(kmero)    
 
    return resultado

def cargarfasta(file:str) -> dict:
    lines     = list()
    resultado = dict()
    sequence  = str()
    cabecera  = str()
    with open(file) as f:
        lines = f.readlines()
   
        #Construccion de la tabla
        for line in lines:
            #Si la linea comienza con el caracter ">", lo añadira a la variable "cabecera".
            if line.startswith('>'):
                cabecera = line[1:].strip()
                sequence = "" #Esta linea evita que se guarde la primera secuencia bajo el segundo identificador.
            
            #El resto de lineas serán asignadas a la variable secuencia, hasta que se encuentre otra cabecera.
            else:  
                sequence += line
            #Se almacena el resultado en la tabla, asociando a cada cabecera la serie de lineas que le siguen en el fichero FASTA.
            resultado[cabecera] = sequence
        
        f.close()
        
    return resultado

    

