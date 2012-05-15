
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "base class that holds DBIC model role",
  "AUTHOR" => "FormHandler Contributors - see HTML::FormHandler",
  "BUILD_REQUIRES" => {
    "DateTime::Format::MySQL" => 0,
    "DateTime::Format::SQLite" => 0,
    "DateTime::Format::W3CDTF" => 0,
    "Test::More" => "0.94"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "HTML-FormHandler-Model-DBIC",
  "EXE_FILES" => [
    "script/form_generator.pl"
  ],
  "LICENSE" => "perl",
  "NAME" => "HTML::FormHandler::Model::DBIC",
  "PREREQ_PM" => {
    "DBIx::Class" => 0,
    "DBIx::Class::ResultSet::RecursiveUpdate" => "0.25",
    "HTML::FormHandler" => "0.34001",
    "Moose" => "2.0007",
    "namespace::autoclean" => "0.09"
  },
  "VERSION" => "0.20",
  "test" => {
    "TESTS" => "t/*.t t/xt/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



