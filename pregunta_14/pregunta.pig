/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       color 
   FROM 
       u 
   WHERE 
       color NOT LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/
data = LOAD 'data.csv' USING PigStorage(',')
    AS (
            index:int,
            nombre:chararray,
            apellido:chararray,
            fecha:chararray,
            color:chararray,
            numb:int
    );
data_col = FOREACH data GENERATE color;
data_fil = FILTER data_col BY NOT (color MATCHES '.*^[bB].*');
STORE data_fil INTO 'output' USING PigStorage(',');
