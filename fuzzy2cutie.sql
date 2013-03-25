CREATE FUNCTION FuzzyInitFclFile(text]) RETURNS integer
     AS '$libdir/fuzzy2cutie.so', 'FuzzyInitFclFile'
     LANGUAGE c STRICT;
--посмотреть как в экзамплес тянет фцл
CREATE FUNCTION FuzzyEqualMean(double precision, text]) RETURNS double precision
     AS '$libdir/fuzzy2cutie.so', 'FuzzyEqualMean'
     LANGUAGE c STRICT;

select FuzzyInitFclFile('/home/mititelu/card.fcl');

select * from transaction where FuzzyEqualMean(risk, "Высокий") > 0.05 order by FuzzyEqualMean(risk, "Высокий");
