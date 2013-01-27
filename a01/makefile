
lexlib=l
bindir=.
rm=/bin/rm -f
targets=simpletok rmcomments idtoken tokenizer decaflex
assignments=rmcomments idtoken tokenizer decaflex

all: $(targets) 

$(targets): %: %.lex 
	@echo "compiling lex file:" $<
	@echo "output file:" $@
	flex -o$@.c $<
	gcc -o $(bindir)/$@ $@.c -l$(lexlib)
	$(rm) $@.c
	cp $@ answer/$@
clean:
	$(rm) $(targets)
	$(rm) *.pyc
	$(rm) *~
	$(rm) *.yy.c
	$(rm) answer/*

test:
	python check-hw1.py -d answer/ testcases/

