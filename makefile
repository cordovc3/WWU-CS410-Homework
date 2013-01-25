
lexlib=l
bindir=.
rm=/bin/rm -f
targets=leftcontext-inp reject simpletok simplebigram rmcomments idtoken tokenizer
assignments=rmcomments idtoken tokenizer

all: $(targets) move

$(targets): %: %.lex
	@echo "compiling lex file:" $<
	@echo "output file:" $@
	flex -o$@.c $<
	gcc -o $(bindir)/$@ $@.c -l$(lexlib)
	$(rm) $@.c

clean:
	$(rm) $(targets)
	$(rm) *.pyc
	$(rm) *~

test:
	python check-hw1.py -d answer/ testcases/

move:
	cp rmcomments answer/rmcomments
	cp tokenizer answer/tokenizer
	cp idtoken answer/idtoken
