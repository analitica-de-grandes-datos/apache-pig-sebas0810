/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.csv' USING PigStorage(',')
    AS (
            index:int,
            nombre:chararray,
            apellido:chararray,
            fecha:datetime,
            color:chararray,
            numb:int
    );
data_col = GROUP data BY GetYear(fecha);
data_conteo = FOREACH data_col GENERATE group, COUNT(data); 
STORE data_conteo INTO 'output' USING PigStorage(',');
