PROG=perl fetch_epmc.pl
IMP=perl import_epmc.pl

.PHONY: clean citations references dblinks install import

start: data/pmid.csv
	$(PROG) --initial

citations: data/epmc.json
	$(PROG) --source citations

references: data/epmc.json
	$(PROG) --source references

dblinks: data/epmc.json
	$(PROG) --source dblinks

epmc.json: data/pmid.csv
	$(PROG) --initial

data/pmid.csv:
	catmandu -L /srv/www/pub export backup --bag publication \
	to CSV --fix export.fix --fields 'pmid' > data/pmid.csv

import: data/citations.json data/referneces.json data/dblinks.json
	$(IMP) --source citations
	$(IMP) --source references
	$(IMP) --source dblinks

install:
	cpanm --installdeps .

clean:
	rm -f *.json && rm -f *.log
