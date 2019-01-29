SELECT set_config('search_path',
    current_setting('search_path') || ', alfsneak', false); 

-- Number of ...
SELECT n_nodes_by_qname('user');
SELECT n_users();
SELECT n_nodes_by_qname('content');
SELECT n_all_docs();

-- Number of docs
SELECT n_docs_by_extension('xml');
SELECT n_docs_by_extension('pdf');

SELECT n_docs_per_store('workspace', 'SpacesStore');
SELECT n_docs_live();
SELECT n_docs_per_store('archive', 'SpacesStore');
SELECT n_docs_trash();
