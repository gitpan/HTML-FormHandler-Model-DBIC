#!/usr/bin/env perl

use strict;
use warnings;

use lib ('t/lib');

use BookDB::Schema;

my $schema = BookDB::Schema->connect('dbi:SQLite:t/db/book.db');

my $sql_dir = 't/db/sql';
$schema->create_ddl_dir('SQLite', 1, $sql_dir );

