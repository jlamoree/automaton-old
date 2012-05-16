SET client_min_messages TO warning;

/*
On a new database:
CREATE LANGUAGE plpgsql;
*/

/*
Last Modified Trigger Function

Usage:
  CREATE TRIGGER last_mod_trigger BEFORE UPDATE ON table_name
  FOR EACH ROW EXECUTE PROCEDURE set_last_modified();

*/
CREATE OR REPLACE FUNCTION set_last_modified()
RETURNS TRIGGER AS $$
BEGIN
   NEW.last_mod_time = now(); 
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/*
Database
*/
CREATE DATABASE automaton WITH OWNER = automaton ENCODING = 'UTF-8';


/*
Application User
*/

-- Production
CREATE ROLE automaton WITH LOGIN PASSWORD 'secret';

-- Development
-- ALTER ROLE automaton WITH PASSWORD 'secret';
