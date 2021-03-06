
The filenames for each question are given below.  We will grade
only the questions marked with a dagger in the PDF file.  They are
marked with + below.

All text output should be printed to standard output (stdout). Just
use printf or cout which prints to stdout by default.

Programs that take input must read it from standard input (stdin).
By default lex/flex and yacc/bison reads from stdin and printf
prints to stdout.

The testcases directory contains useful test cases; the mapping
between the homework questions and test cases is given below. The
list below shows the binaries that will be tested. We must be able
to create the binaries by running 'make' in the answer directory.
The easiest way to use make is to edit the file 'answer/makefile'
and add your lex program name (without any suffix) to targets or
cpptargets (if C++). If you add 'prog' to targets in answer/makefile
then running 'make' in the answer directory will create the binary
'prog' from 'prog.y'

Test your programs by running: "python check-hw2.py". Run without
arguments and it will print out a detailed help text about usage
and grading.

If the auto check above gives exit failure make sure that you are
always using exit(0) as the last line of your main function in your
C or C++ code. Use exit(1) to indicate failure.

Do this as soon as you can. There is no advantage to waiting to
submit. We just pull your solution on the deadline.

%%

q1: multexpr
q2: varexpr
q3: expr-interpreter
+q4: quicksort # file: quicksort.decaf  (dropped)
+q5: expr-parse
q6: decafLRGrammar # file: decafLRGrammar.y
+q7: decaf-parse
