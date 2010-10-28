
DROP TABLE roles;

CREATE TABLE roles (
  id INTEGER PRIMARY KEY NOT NULL,
  display_value VARCHAR2(30) NOT NULL,
  description VARCHAR2(200),
  active smallint(38) NOT NULL DEFAULT '1 ',
  modified_date TIMESTAMP(11),
  created_date DATETIME(11) NOT NULL DEFAULT date('now')
);

CREATE UNIQUE INDEX unique_role ON roles (display_value);
