/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letra:chararray,
            conjunto:chararray,
            lista:chararray
    );
data_total = FOREACH data GENERATE FLATTEN(TOKENIZE(conjunto,',')) as conj_desg, FLATTEN(TOKENIZE(lista,',')) as list_deg;
dato_organizar = FOREACH data_total GENERATE REPLACE(conj_desg, '([^a-zA-Z\\s]+)','') AS letra, REPLACE(list_deg,'([^a-zA-Z\\s]+)','') AS clave;
data_tuplas = FOREACH dato_organizar GENERATE TOTUPLE(letra,clave) as tupla;
data_agrupar = GROUP data_tuplas BY tupla;
data_contar = FOREACH data_agrupar GENERATE group, COUNT(data_tuplas);
STORE data_contar INTO 'output' USING PigStorage(',');
