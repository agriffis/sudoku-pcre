TARGETS = solver.pl solver.py solver.rb
TIMES = $(TARGETS:solver.%=%.times)
INPUTS = inputs/*.input*

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	rm -f $(TARGETS) $(TIMES) TIMES.md

TIMES.md: $(TIMES)
	fields=$$(seq 2 2 $$(($$(wc -w <<<"$^") * 2)) | xargs | sed 's/ /,/g'); \
	( echo -n '||'; printf '%s|' $(^:%.times=solver.%); echo; \
	    echo -n '|---|'; for t in $^; do echo -n '---|'; done; echo; \
	    paste $^ | cut -f1,$$fields --output-delimiter='|' | sed 's/^/|/' | sed 's/$$/|/'; \
	) | tee $@

%.times: solver.% $(INPUTS)
	for x in $(INPUTS); do \
	    printf "%s\t" "$$x"; \
	    time=$$( ( time ./$< < $$x > tmp ) 2>&1 | awk -F'[ms]' '/user/{print $$(NF-1)}'); \
	    if cmp tmp $${x/.input/.output} &>/dev/null; then echo $$time; \
	    else echo failed; fi; \
	done | tee $@
	rm -f tmp
	awk '{sum+=$$2} END{printf "\t%0.3f\n", sum/NR}' $@ >> $@

solver.%: solver.%.in regex.txt
	m4 --prefix-builtins $< > $@
	@chmod +x $@

regex.txt: generate-regex.pl
	./generate-regex.pl > regex.txt
