
--
-- Table: pages
--
DROP TABLE pages;

CREATE TABLE pages (
  id INTEGER PRIMARY KEY NOT NULL,
  display_value VARCHAR2(30) NOT NULL,
  description VARCHAR2(200),
  modified_date TIMESTAMP(11),
  created_date TIMESTAMP(11) NOT NULL DEFAULT 'systimestamp'
);

