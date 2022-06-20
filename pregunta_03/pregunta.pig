/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letra:chararray,
            fecha:chararray,
            num:int
    );
ordenar = FOREACH data GENERATE num;
ordenados = ORDER ordenar BY num ASC;
cinco_menores = LIMIT ordenados 5;
STORE cinco_menores INTO 'output' USING PigStorage(',');
