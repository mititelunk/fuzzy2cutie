/*1) create a SQL function a selection FCL*/
CREATE FUNCTION FuzzyInitFclFile(text) RETURNS integer
     AS '$libdir/libfuzzy2cutie.so', 'FuzzyInitFclFile'
     LANGUAGE c STRICT;

/*2) create a SQL function*/
CREATE FUNCTION FuzzyEvaluateValue(text, text) RETURNS double precision
     AS '$libdir/libfuzzy2cutie.so', 'FuzzyEvaluateValue'
     LANGUAGE c STRICT;

/*3) choose your FCL*/
select FuzzyInitFclFile('/home/nic/fuzzy2cutie/riskines_transaction.fcl');
/*4) show the transaction in accordance with the specified risk exposure and
sorted in descending order by the value of the membership function*/
select *, FuzzyEvaluateValue('riskiness_debited ='|| CAST(riskiness_debited AS VARCHAR) ||
                            ',riskiness_country ='|| CAST(riskiness_country AS VARCHAR) ||
                            ',riskiness_sum ='    || CAST(riskiness_sum AS VARCHAR),
                            'riskiness_transaction') AS riskiness_transaction
from riskiness_transaction
where    FuzzyEvaluateValue('riskiness_debited ='|| CAST(riskiness_debited AS VARCHAR) ||
                           ',riskiness_country ='|| CAST(riskiness_country AS VARCHAR) ||
                           ',riskiness_sum ='    || CAST(riskiness_sum AS VARCHAR),
                            'riskiness_transaction') > 0.1
AND    FuzzyEvaluateValue('riskiness_debited ='|| CAST(riskiness_debited AS VARCHAR) ||
                           ',riskiness_country ='|| CAST(riskiness_country AS VARCHAR) ||
                           ',riskiness_sum ='    || CAST(riskiness_sum AS VARCHAR),
			    'riskiness_sum') > 1
OR    FuzzyEvaluateValue('riskiness_debited ='|| CAST(riskiness_debited AS VARCHAR) ||
                           ',riskiness_country ='|| CAST(riskiness_country AS VARCHAR) ||
                           ',riskiness_sum ='    || CAST(riskiness_sum AS VARCHAR),
			    'riskiness_debited') > 1
order by FuzzyEvaluateValue('riskiness_debited ='|| CAST(riskiness_debited AS VARCHAR) ||
                           ',riskiness_country ='|| CAST(riskiness_country AS VARCHAR) ||
                           ',riskiness_sum ='    || CAST(riskiness_sum AS VARCHAR),
                            'riskiness_transaction') desc;

/*5) or create a view and  4)*/ 
CREATE VIEW v_riskiness_transaction AS
SELECT *, FuzzyEvaluateValue('riskiness_debited ='
          || CAST(riskiness_debited AS VARCHAR) 
          || ',riskiness_country ='
          || CAST(riskiness_country AS VARCHAR) 
          || ',riskiness_sum ='    
          || CAST(riskiness_sum AS VARCHAR),
             'riskiness_transaction') AS riskiness_transaction_value FROM      riskiness_transaction;
SELECT * FROM v_riskness_transaction WHERE riskness_transaction_value > 0.1 ORDER BY riskness_transaction_value DESC;

