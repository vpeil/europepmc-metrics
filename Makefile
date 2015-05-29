PROG=perl fetch_epmc.pl

initial:
	$(PROG) --initial

citations: epmc.json
	$(PROG) --source citations

references: epmc.json
	$(PROG) --source references

dblinks: epmc.json
	$(PROG) --source dblinks

epmc.json: pmid.csv
	$(PROG) --initial

.PHONY: clean

clean:
	rm -f *.json && rm -f *.log
