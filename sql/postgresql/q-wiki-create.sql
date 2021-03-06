-- q-wiki-create.sql
--
-- @author Dekka Corp.
-- @for OpenACS.org
-- @cvs-id
--

-- we are not going to reference acs_objects directly, so that this can be used
-- separate from acs-core.
CREATE TABLE qw_page_object_id_map (
     page_id integer,
     object_id integer 
        -- page_id can be constrained to object_id for permissions
);


CREATE SEQUENCE qw_page_id_seq start 10000;
SELECT nextval ('qw_page_id_seq');


CREATE TABLE qw_wiki_page (
        id integer not null primary key,
        template_id integer,
        instance_id integer,
        -- object_id of mounted instance (context_id)
        user_id integer,
        -- user_id of user that created page
        name varchar(300),
        title varchar(300),
        keywords varchar(100),
        description varchar(1000),
        trashed varchar(1),
        popularity integer,
        flags varchar(12),
        -- this is only diffferent from created when flags or trashed change since changes to visible content create new page revisions
        last_modified timestamptz,
        created timestamptz,
        content text,
        comments text
     );    

create index qw_wiki_page_id_idx on qw_wiki_page (id);
create index qw_wiki_page_template_id_idx on qw_wiki_page (template_id);
create index qw_wiki_page_instance_id_idx on qw_wiki_page (instance_id);
create index qw_wiki_page_user_id_idx on qw_wiki_page (user_id);
create index qw_wiki_page_trashed_idx on qw_wiki_page (trashed);

CREATE TABLE qw_page_url_map (
        -- max size must consider url encoding all qw_wiki_page.name characters
        url varchar(903) not null,
        page_id integer not null,
        --  should be a value from qw_wiki_page.id
        trashed varchar(1),
        instance_id integer
        );

create index qw_page_url_map_url_idx on qw_page_url_map (url);
create index qw_page_url_map_instance_id_idx on qw_page_url_map (instance_id);
create index qw_page_url_map_page_id_idx on qw_page_url_map (page_id);
