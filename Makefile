PROG=perl fetch_epmc.pl

go: pub.json
	$(PROG) --initial

citations: epmc.json
	$(PROG) --source citations

references: epmc.json
	$(PROG) --source references

dblinks: epmc.json
	$(PROG) --source dblinks

.PHONY: clean

clean:
	rm *.json && rm *.log
