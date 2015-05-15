requires 'perl', 'v5.10.1';

on test {
  requires 'Test::More';
  requires 'Test::Script', '>=1.10';
};

requires 'Catmandu';
requires 'Catmandu::Importer::getJSON';
requires 'MooX::Options';
requires 'Try::Tiny'
