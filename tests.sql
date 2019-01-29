-- Number of ...
SELECT alfsneak.nodes_by_qname('user');
SELECT alfsneak.n_users();
SELECT alfsneak.nodes_by_qname('content');
SELECT alfsneak.n_all_docs();

-- Number of docs
SELECT alfsneak.docs_by_extension('xml');
SELECT alfsneak.docs_by_extension('pdf');
