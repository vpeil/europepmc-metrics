PROG=perl fetch_epmc.pl

initial:
	$(PROG) --initial

citations:
	$(PROG) --source citations

references:
	$(PROG) --source references

dblinks:
	$(PROG) --source dblinks

.PHONY: clean

clean:
	rm *.json && rm *.log
