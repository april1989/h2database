-- Copyright 2004-2019 H2 Group. Multiple-Licensed under the MPL 2.0,
-- and the EPL 1.0 (https://h2database.com/html/license.html).
-- Initial Developer: H2 Group
--

CREATE ALIAS MY_SQRT FOR "java.lang.Math.sqrt";
> ok

EXEC MY_SQRT 4;
> exception SYNTAX_ERROR_2

-- PostgreSQL-style EXECUTE doesn't work with MSSQLServer-style arguments
EXECUTE MY_SQRT 4;
> exception FUNCTION_ALIAS_NOT_FOUND_1

SET MODE MSSQLServer;
> ok

-- PostgreSQL-style PREPARE is not available in MSSQLServer mode
PREPARE TEST AS SELECT 1;
> exception SYNTAX_ERROR_1

-- PostgreSQL-style DEALLOCATE is not available in MSSQLServer mode
DEALLOCATE TEST;
> exception SYNTAX_ERROR_2

EXEC MY_SQRT 4;
>> 2.0

EXECUTE MY_SQRT 4;
>> 2.0

EXEC PUBLIC.MY_SQRT 4;
>> 2.0

EXEC SCRIPT.PUBLIC.MY_SQRT 4;
>> 2.0

EXEC UNKNOWN_PROCEDURE;
> exception FUNCTION_NOT_FOUND_1

EXEC UNKNOWN_SCHEMA.MY_SQRT 4;
> exception SCHEMA_NOT_FOUND_1

EXEC UNKNOWN_DATABASE.PUBLIC.MY_SQRT 4;
> exception DATABASE_NOT_FOUND_1

SET MODE Regular;
> ok

DROP ALIAS MY_SQRT;
> ok
