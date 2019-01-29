DROP SCHEMA alfsneak CASCADE;
CREATE SCHEMA IF NOT EXISTS alfsneak;

-- Queries by Morgan Patou
-- https://blog.dbi-services.com/alfresco-some-useful-database-queries/

CREATE OR REPLACE FUNCTION alfsneak.n_nodes_by_qname(qname VARCHAR(200))
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
    SELECT alfsneak.n_nodes_by_qname('user');
$$;

CREATE OR REPLACE FUNCTION alfsneak.n_all_docs()
RETURNS BIGINT
LANGUAGE SQL
AS $$
    SELECT alfsneak.n_nodes_by_qname('content');
$$;


CREATE OR REPLACE FUNCTION alfsneak.n_docs_by_extension(extension VARCHAR(32))
RETURNS BIGINT
LANGUAGE SQL
AS $$
    SELECT COUNT(*) AS docs
    FROM alf_node AS n
    JOIN alf_qname AS q ON (n.type_qname_id = q.id)
    JOIN alf_node_properties AS p ON (n.id = p.node_id)
    WHERE p.qname_id IN (SELECT id FROM alf_qname WHERE local_name='name')
      AND q.local_name='content'
      AND p.string_value LIKE '%.' || extension;
$$;

-- Finding documents per content store

CREATE OR REPLACE FUNCTION alfsneak.n_docs_per_store(
    protocol VARCHAR(50)
,   identifier VARCHAR(100)
)
RETURNS BIGINT
LANGUAGE SQL
AS $$
    SELECT COUNT(*) AS docs
    FROM alf_node AS n
    JOIN alf_qname AS q ON (n.type_qname_id = q.id)
    JOIN alf_store AS s ON (n.store_id = s.id)
    WHERE q.local_name = 'content'
    AND s.protocol = protocol
    AND s.identifier = identifier;
$$;

CREATE OR REPLACE FUNCTION alfsneak.n_docs_live()
RETURNS BIGINT
LANGUAGE SQL
AS $$
    SELECT alfsneak.n_docs_per_store('workspace', 'SpacesStore');
$$;

CREATE OR REPLACE FUNCTION alfsneak.n_docs_trash()
RETURNS BIGINT
LANGUAGE SQL
AS $$
    SELECT alfsneak.n_docs_per_store('archive', 'SpacesStore');
$$;

-- CREATE OR REPLACE FUNCTION alfsneak. 
-- RETURNS 
-- LANGUAGE SQL
-- AS $$

