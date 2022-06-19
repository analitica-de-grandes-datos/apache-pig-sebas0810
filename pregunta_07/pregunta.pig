/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

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
data_total = FOREACH data GENERATE letra, TOKENIZE(conjunto,',') as conj_desg, TOKENIZE(lista,',') as list_deg;
data_contar = FOREACH data_total GENERATE letra, COUNT(conj_desg) as num_conj, COUNT(list_deg) as num_list;
data_final = ORDER data_contar BY letra, num_conj, num_list ASC;
STORE data_final INTO 'output' USING PigStorage(',');
