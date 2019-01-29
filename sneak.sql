DROP SCHEMA alfsneak CASCADE;
CREATE SCHEMA IF NOT EXISTS alfsneak;

-- Queries by Morgan Patou
-- https://blog.dbi-services.com/alfresco-some-useful-database-queries/

CREATE OR REPLACE FUNCTION alfsneak.nodes_by_qname(qname VARCHAR(200))
RETURNS BIGINT
LANGUAGE SQL
AS $$
    SELECT COUNT(*) AS nodes
    FROM alf_node AS n
    JOIN alf_qname AS q ON (n.type_qname_id=q.id)
    WHERE q.local_name=qname;
$$;

CREATE OR REPLACE FUNCTION alfsneak.n_users()
RETURNS BIGINT
LANGUAGE SQL
AS $$
    SELECT alfsneak.nodes_by_qname('user');
$$;

CREATE OR REPLACE FUNCTION alfsneak.n_all_docs()
RETURNS BIGINT
LANGUAGE SQL
AS $$
    SELECT alfsneak.nodes_by_qname('content');
$$;


-- CREATE OR REPLACE FUNCTION alfsneak. 
-- RETURNS 
-- LANGUAGE SQL
-- AS $$

