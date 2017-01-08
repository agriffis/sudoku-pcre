SCRIPTS = solver.pl solver.py solver.rb solver.js
TIMES = $(SCRIPTS:solver.%=%.times)
INPUTS = inputs/*.input*

TIMES.md: $(TIMES)
	fields=$$(seq 2 2 $$(($$(wc -w <<<"$^") * 2)) | xargs | sed 's/ /,/g'); \
	( echo -n '||'; printf '%s|' $(^:%.times=solver.%); echo; \
	    echo -n '|---|'; for t in $^; do echo -n '---|'; done; echo; \
	    paste $^ | cut -f1,$$fields --output-delimiter='|' | sed 's/^/|/' | sed 's/$$/|/'; \
	) | tee $@

%.times: solver.% regex.txt $(INPUTS)
	for x in $(INPUTS); do \
	    printf "%s\t" "$$x"; \
	    time=$$( ( time ./$< < $$x > tmp ) 2>&1 | awk -F'[ms]' '/user/{print $$(NF-1)}'); \
	    if cmp tmp $${x/.input/.output} &>/dev/null; then echo $$time; \
	    else echo failed; fi; \
	done | tee $@
	rm -f tmp
	awk '{sum+=$$2} END{printf "\t%0.3f\n", sum/NR}' $@ >> $@

regex.txt: generate-regex.pl
	./$< > $@

.PHONY: clean
clean:
	rm -f $(TIMES) TIMES.md
