/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

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
data_total = FOREACH data GENERATE lista;
data_list_desag = FOREACH data_total GENERATE FLATTEN(TOKENIZE(lista)) AS clave;
solo_letras = FOREACH data_list_desag GENERATE REPLACE (clave,'([^a-zA-Z\\s]+)','') as clave;
grupos = GROUP solo_letras BY clave;
contar = FOREACH grupos GENERATE group, COUNT(solo_letras);
STORE contar INTO 'output' USING PigStorage(',');

