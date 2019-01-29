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


CREATE OR REPLACE FUNCTION alfsneak.docs_by_extension(extension VARCHAR(32))
RETURNS BIGINT
LANGUAGE SQL
AS $$
    SELECT COUNT(*) as docs
    FROM alf_node AS n
    JOIN alf_qname AS q ON (n.type_qname_id = q.id)
    JOIN alf_node_properties AS p ON (n.id = p.node_id)
    WHERE p.qname_id IN (SELECT id FROM alf_qname WHERE local_name='name')
      AND q.local_name='content'
      AND p.string_value LIKE '%.' || extension;
$$


-- CREATE OR REPLACE FUNCTION alfsneak. 
-- RETURNS 
-- LANGUAGE SQL
-- AS $$

