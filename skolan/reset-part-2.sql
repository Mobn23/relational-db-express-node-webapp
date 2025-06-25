-- Skapa om en tom databas
source create-database.sql

-- Skapa tabellen för lärare
source ddl-larare.sql

-- Lägg till rader i tabellen lärare
source insert-larare.sql

-- Uppdatera tabellen lärare och lägg till kompetensen.
source ddl-alter.sql

-- Förbered lönerevisionen, alla lärare har grundlön.
source dml-update.sql

source ddl-copy.sql

source dml-update-lonerevision.sql

-- Kopiera till larare_pre innan lönerevisionen.
-- source ddl.sql
-- source insert-csv.sql;
source dml-view.sql

-- Utför lönerevisionen.
-- source dml-update-lonerevision.sql

-- Skapa vyerna v_namn_alder och v_larare.
-- source dml-view.sql

-- source dml-join2.sql

-- Skapa vyn v_lonerevision.
source dml-join.sql