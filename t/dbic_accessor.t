use Test::More;
use lib 't/lib';

use BookDB::Schema;
use BookDB::Form::Book;

my $schema = BookDB::Schema->connect('dbi:SQLite:t/db/book.db');
ok($schema, 'get db schema');

my $form = BookDB::Form::Book->new(schema => $schema);

# set "comment" accessor
my $params = {
    'title' => 'Humpty Dumpty Processors',
    'author' => 'J.M.Smith',
    'isbn'   => '123-92995-0502-2' ,
    'publisher' => 'Somewhere Publishing',
    'comment'   => 'This is a comment',
};

ok( $form->process( $params ), 'non-column, non-rel accessor validates' );

ok( $form->update_model, 'Update validated data');
END { $form->item->delete }

my $book = $form->item;
ok ($book, 'get book object from form');

is( $book->extra, 'This is a comment', 'get  data set by accessor');

done_testing;
