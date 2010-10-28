use strict;
use warnings;
use Test::More;

use lib ('t/lib');
use BookDB::Schema;

my $schema = BookDB::Schema->connect('dbi:SQLite:t/db/book.db');
my $user = $schema->resultset('User')->find(1);

{
   package Repeatable::Form::User;
   use HTML::FormHandler::Moose;
   extends 'HTML::FormHandler::Model::DBIC';

   has_field 'user_name';
   has_field 'occupation';

   has_field 'addresses' => ( type => 'Repeatable' );
   has_field 'addresses.address_id' => ( type => 'PrimaryKey' );
   has_field 'addresses.street';
   has_field 'addresses.city';
   has_field 'addresses.country' => ( type => 'Select' );

}

# the initial empty element in a repeatable field should
# still be there after 'process'
my $form2 = Repeatable::Form::User->new;
$form2->process( item => $schema->resultset('User')->new_result( {} ),
    params => {} );
ok( $form2->field('addresses')->field('0'),
    'Initial field exists after process' );

done_testing;
