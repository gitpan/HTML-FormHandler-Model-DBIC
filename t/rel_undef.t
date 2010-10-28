use strict;
use warnings;

use Test::More;
use lib 't/lib';

use BookDB::Form::User;
use BookDB::Schema;

my $schema = BookDB::Schema->connect('dbi:SQLite:t/db/book.db');
my $user = $schema->resultset('User')->find(1);

my $form = BookDB::Form::User->new( schema => $schema );

my $unemployed_params = {
   user_name => "No Employer",
   occupation => "Unemployed",
   'employers.0.employer_id' => '', # empty string
};
$form->process( $unemployed_params);
ok( $form->validated, "User with empty employer validates" );
ok( !$form->item->employers_rs->count, "No employers associated with unemployed user" );

$form->item->delete;

done_testing;
