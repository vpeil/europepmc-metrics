#!/usr/bin/env perl

use Catmandu::Sane;
use Catmandu -load;
use Catmandu::Importer::JSON;
use Catmandu::Fix qw(epmc_dblinks);
use Moo;
use MooX::Options;

option source => (
  is => 'ro',
  short => 's',
  default => sub { 'citations' },
  doc => "Possible values are 'citations', 'references' or 'dblinks'.",
);
option verbose => (
  is => 'ro',
  short => 'v',
  doc => 'Print details',
);

Catmandu->load;
Catmandu->config;

my $rec;

sub _cit_ref {
  my ($self, $item) = @_;

  my $source = $self->source;
  my $pmid = $item->{request}->{id};
  $rec->{$pmid}->{_id} = $pmid;
  $rec->{$pmid}->{total} = $item->{hitCount};

  if ($source eq 'citations') {
    $rec->{$pmid}->{entries} = $item->{citationList}->{citation};
  } elsif ($source eq 'references') {
    $rec->{$pmid}->{entries} = $item->{referenceList}->{reference};
  }

}

sub _dblinks {
  my ($self, $item) = @_;

  my $pmid = $item->{request}->{id};
  my $db_item = $item->{dbCrossReferenceList}->{dbCrossReference}->[0];
  my $db_name = $db_item->{dbName};

  my $db_fixer = Catmandu::Fix->new(fixes => ["epmc_dblinks($db_name)"]);
  my $fixed_db = $db_fixer->fix($db_item);

  $rec->{$pmid}->{_id} = $pmid;
  $rec->{$pmid}->{db}->{$db_name}->{total} = $db_item->{dbCount};
  $rec->{$pmid}->{db}->{$db_name}->{entries} = $fixed_db;

}

sub run {
  my ($self) = @_;

  my $source = $self->source;

  my $imp = Catmandu->importer('default', file => "$source.json");

  $imp->each(sub{
    my $item = $_[0];
    next if $item->{errMsg};

    if ($source eq 'citations' or $source eq 'references') {
      $self->_cit_ref($item);
    } elsif ($source eq 'dblinks') {
      $self->_dblinks($item);
    }
  });

  my $bag = Catmandu->store->bag("epmc_$source");
  map { $bag->add($rec->{$_}); } keys %$rec;
}

main->new_with_options->run;

1;
