# europepmc-metrics

A small project to fetch and store citations, references and database links
from [Europe PMC](https://europepmc.org.)

## Installation

Make sure all the dependencies are installed

```bash
$ make install

# or equivalently

$ cpanm --installdeps .
```

## Usage

You need a CSV file with header  `data/pmid.csv` which looks like
```csv
pmid
12345678
87654321
98765433
```

Run
```bash
$ make
```

to fetch the initial data from Europe PMC.

Then you may specify the source to be fetched, e.g. `citations`, `references` or `dblinks`
```bash
$ make citations

# or

$ make references

# or

$make dblinks
```

To import the data into a database run
```bash
$ make import
```
