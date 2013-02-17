cd answer
make clean
make
cd ..  
python check-hw2.py answer/ testcases/ > diffs.diff
cd answer
make clean
