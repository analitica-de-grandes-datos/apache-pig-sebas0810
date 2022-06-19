/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

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
data_total = FOREACH data GENERATE conjunto;
data_conj_desag = FOREACH data_total GENERATE FLATTEN(TOKENIZE(conjunto)) AS letra;
solo_letras = FILTER data_conj_desag BY (letra MATCHES '.*[a-z].*');
grupos = GROUP solo_letras BY letra;
contar = FOREACH grupos GENERATE group, COUNT(solo_letras);
STORE contar INTO 'output' USING PigStorage(',');
