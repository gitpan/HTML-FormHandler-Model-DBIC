
--
-- Table: roles_pages
--
DROP TABLE roles_pages;

CREATE TABLE roles_pages (
  role_fk NUMBER(38) NOT NULL,
  page_fk NUMBER(38) NOT NULL,
  edit_flag NUMBER(38) NOT NULL DEFAULT '0 ',
  created_date TIMESTAMP(6)(11) NOT NULL DEFAULT 'systimestamp',
  PRIMARY KEY (role_fk, page_fk)
);

CREATE INDEX roles_pages_idx_page_fk ON roles_pages (page_fk);
