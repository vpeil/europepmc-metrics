# europepmc-metrics

A small project to fetch and store citations, references and database links
from http://europepmc.org.

## Installation

Make sure all the dependencies are installed:

```bash
$ cpanm --installdeps .
```

## Usage

You need a file called `pmid.csv` which looks like
```csv
pmid
12345678
87654321
98765433
```

Run the following command

```bash
$ perl fetch_epmc.pl --initial
```

to fetch the initial data from Europe PMC. Then you may specify the source to be fetched, e.g. `citations`

```bash
$ perl fetch_epmc.pl -s citations
```

Run

```bash
$ perl fetch_epmc.pl --help
```

to display more options.

There's also a tiny `Makefile` as a wrapper for the fetch_epmc.pl script.
