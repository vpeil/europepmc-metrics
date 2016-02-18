PROG=perl fetch_epmc.pl
IMP=perl import_epmc.pl

.PHONY: clean citations references dblinks install import

start: data/pmid.csv
	$(PROG) --initial

citations: data/epmc.json
	$(PROG) --source citations
	$(IMP) --source citations

references: data/epmc.json
	$(PROG) --source references
	$(IMP) --source references

dblinks: data/epmc.json
	$(PROG) --source dblinks
	$(IMP) --source dblinks

data/epmc.json: data/pmid.csv
	$(PROG) --initial

data/pmid.csv:
	catmandu -L /srv/www/pub export backup --bag publication \
	to CSV --fix export.fix --fields 'pmid' > data/pmid.csv

install:
	cpanm --installdeps .

clean:
	rm -f data/*
