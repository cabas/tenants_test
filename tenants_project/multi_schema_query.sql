CREATE OR REPLACE FUNCTION for_all_schemas(raw_query text) RETURNS integer AS $$
DECLARE
final_statement text;
all_schema_query text;
schema RECORD;
schema_names text[];
name text;
temptable_select text;
temptable_selects text[];
 
BEGIN
-- kill temp tables
DISCARD TEMP;
 
-- get all the schemas
FOR schema IN SELECT schema_name AS schema_name FROM information_schema.schemata WHERE schema_name NOT IN ('pg_catalog','public','information_schema')
LOOP
schema_names := array_append(schema_names, CAST(schema.schema_name AS text));
final_statement := 'CREATE TEMPORARY TABLE ' || schema.schema_name || '_temptable AS    '
|| 'SELECT '
|| 'CAST(''' || schema.schema_name || ''' AS text) AS schema_name, '
|| 'q.* FROM ('
|| raw_query
|| ') AS q';
EXECUTE 'SET search_path = ' || schema.schema_name || ', public';
EXECUTE final_statement;
END LOOP;
 
FOREACH name IN ARRAY schema_names
LOOP
temptable_select := 'SELECT * FROM ' || name || '_temptable';
temptable_selects := array_append(temptable_selects, temptable_select);
END LOOP;
final_statement := 'CREATE TEMPORARY TABLE temptable AS ' || array_to_string(temptable_selects, ' UNION ALL ')
|| ' ORDER BY schema_name';
EXECUTE final_statement;
RETURN 0;
END;$$ LANGUAGE plpgsql;

SELECT for_all_schemas(
  'SELECT * FROM groups'
);
SELECT * FROM temptable;