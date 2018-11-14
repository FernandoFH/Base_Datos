SPOOL T30_TIPOSCONTENIDOS.ctl
SELECT    'LOAD DATA
REPLACE INTO TABLE '
       || 'T30_TIPOSCONTENIDOS_PROD'
       || '
FIELDS TERMINATED BY ''|''  OPTIONALLY ENCLOSED BY ''$$''
TRAILING NULLCOLS ('
  FROM DUAL
UNION ALL
SELECT tab_cols
  FROM (  SELECT column_name || ',' tab_cols
            FROM user_tab_cols
           WHERE table_name = 'T30_TIPOSCONTENIDOS_PROD'
        ORDER BY column_id)
UNION ALL
SELECT ')' FROM DUAL;
SPOOL OFF

-- ## Limpiar .ctl
-- sed -i '1,16d' *.ctl 
-- sed -i '$d' *.ctl 
