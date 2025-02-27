# We declare these as phony targets because 'all' and 'clean' do not directly produce files
.PHONY: all clean

# The all target: we want to end up with the final report
all: report/count_report.html

# To get the report, we need all the figures:
report/count_report.html: results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png report/count_report.qmd
	quarto render report/count_report.qmd

##################################
# Rules for generating figures
##################################
results/figure/isles.png: results/isles.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/isles.dat --output_file=results/figure/isles.png

results/figure/abyss.png: results/abyss.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/abyss.dat --output_file=results/figure/abyss.png

results/figure/last.png: results/last.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/last.dat --output_file=results/figure/last.png

results/figure/sierra.png: results/sierra.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/sierra.dat --output_file=results/figure/sierra.png

##################################
# Rules for generating .dat files
##################################
results/isles.dat: data/isles.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/isles.txt --output_file=results/isles.dat

results/abyss.dat: data/abyss.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/abyss.txt --output_file=results/abyss.dat

results/last.dat: data/last.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/last.txt --output_file=results/last.dat

results/sierra.dat: data/sierra.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/sierra.txt --output_file=results/sierra.dat

##################################
# Clean target
##################################
clean:
	rm -f results/*.dat
	rm -f results/figure/*.png
	rm -rf report/count_report.html report/count_report_files
