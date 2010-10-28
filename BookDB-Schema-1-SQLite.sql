-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Sun Feb 28 21:35:52 2010
-- 


BEGIN TRANSACTION;

--
-- Table: borrower
--
DROP TABLE borrower;

CREATE TABLE borrower (
  id INTEGER PRIMARY KEY NOT NULL,
  name varchar(100) NOT NULL,
  phone varchar(20) NOT NULL,
  url varchar(100) NOT NULL,
  email varchar(100) NOT NULL,
  active integer(1) NOT NULL
);

--
-- Table: country
--
DROP TABLE country;

CREATE TABLE country (
  iso character(2) NOT NULL,
  name character varying(80),
  printable_name character varying(80) NOT NULL,
  iso3 character(3) NOT NULL,
  numcode integer NOT NULL,
  PRIMARY KEY (iso)
);

--
-- Table: employer
--
DROP TABLE employer;

CREATE TABLE employer (
  employer_id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(32) NOT NULL,
  category  NOT NULL,
  country VARCHAR(32) NOT NULL
);

--
-- Table: format
--
DROP TABLE format;

CREATE TABLE format (
  id INTEGER PRIMARY KEY NOT NULL,
  name varchar(100) NOT NULL
);

--
-- Table: genre
--
DROP TABLE genre;

CREATE TABLE genre (
  id INTEGER PRIMARY KEY NOT NULL,
  name varchar(100) NOT NULL,
  is_active INTEGER
);

--
-- Table: licenses
--
DROP TABLE licenses;

CREATE TABLE licenses (
  license_id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(32) NOT NULL,
  label VARCHAR(32) NOT NULL,
  active INTEGER(1) NOT NULL
);

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

--
-- Table: roles
--
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

--
-- Table: author
--
DROP TABLE author;

CREATE TABLE author (
  last_name VARCHAR(16) NOT NULL,
  first_name VARCHAR(16) NOT NULL,
  country_iso character(2),
  birthdate DATETIME NOT NULL,
  PRIMARY KEY (first_name, last_name)
);

CREATE INDEX author_idx_country_iso ON author (country_iso);

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

CREATE INDEX roles_pages_idx_role_fk ON roles_pages (role_fk);

--
-- Table: user
--
DROP TABLE user;

CREATE TABLE user (
  user_id INTEGER PRIMARY KEY NOT NULL,
  user_name VARCHAR(32) NOT NULL,
  fav_cat VARCHAR(32) NOT NULL,
  fav_book VARCHAR(32) NOT NULL,
  occupation VARCHAR(32) NOT NULL,
  country_iso character(2),
  birthdate DATETIME NOT NULL,
  opt_in INTEGER(1) NOT NULL,
  license_id INTEGER(8) NOT NULL
);

CREATE INDEX user_idx_country_iso ON user (country_iso);

CREATE INDEX user_idx_license_id ON user (license_id);

--
-- Table: address
--
DROP TABLE address;

CREATE TABLE address (
  address_id INTEGER PRIMARY KEY NOT NULL,
  user_id INTEGER(8) NOT NULL,
  street VARCHAR(32) NOT NULL,
  city VARCHAR(32) NOT NULL,
  country_iso character(2)
);

CREATE INDEX address_idx_country_iso ON address (country_iso);

CREATE INDEX address_idx_user_id ON address (user_id);

--
-- Table: user_employer
--
DROP TABLE user_employer;

CREATE TABLE user_employer (
  employer_id INTEGER(8) NOT NULL,
  user_id INTEGER(8) NOT NULL,
  PRIMARY KEY (employer_id, user_id)
);

CREATE INDEX user_employer_idx_employer_id ON user_employer (employer_id);

CREATE INDEX user_employer_idx_user_id ON user_employer (user_id);

--
-- Table: book
--
DROP TABLE book;

CREATE TABLE book (
  id INTEGER PRIMARY KEY NOT NULL,
  isbn varchar(100) NOT NULL,
  title varchar(100) NOT NULL,
  author varchar(100) NOT NULL,
  publisher varchar(100) NOT NULL,
  pages INTEGER NOT NULL,
  year INTEGER NOT NULL,
  format INTEGER NOT NULL,
  borrower INTEGER NOT NULL,
  borrowed varchar(100) NOT NULL,
  owner INTEGER NOT NULL,
  extra varchar(100) NOT NULL
);

CREATE INDEX book_idx_borrower ON book (borrower);

CREATE INDEX book_idx_format ON book (format);

CREATE INDEX book_idx_owner ON book (owner);

CREATE UNIQUE INDEX author_title ON book (author, title);

CREATE UNIQUE INDEX isbn ON book (isbn);

--
-- Table: books_genres
--
DROP TABLE books_genres;

CREATE TABLE books_genres (
  book_id INTEGER NOT NULL,
  genre_id INTEGER NOT NULL,
  PRIMARY KEY (book_id, genre_id)
);

CREATE INDEX books_genres_idx_book_id ON books_genres (book_id);

CREATE INDEX books_genres_idx_genre_id ON books_genres (genre_id);

COMMIT;
