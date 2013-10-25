EEOver
======

Ellipse-Ellipse overlap area: Calculte the overlaping area of two arbitrary ellipses.


17.10.2013
----------------------
Usage:
1) compile the code: make
2) run the executable: ./overlap inputFile 
3) two output files are produced:
   3.1) resultFile: results_Day_Month_Year_Hour_Min_Second.txt 
   3.2) rootFile: roots_Day_Month_Year_Hour_Min_Second.txt

Formats of files:
1) the inputFile should be in the following format 
id A1 B1 H1 K1 PHI_1 A2 B2 H2 K2 PHI_2
(11 columns)

2) resultsFile:   id  areaEllipse1(pi.A.B)  areaEllipse2(pi.A.B)  OverlapAreaAnalytical  OverlapAreaPolynomial  err
3) rootsFile: #roots: id x0 	y0 	x1 	y1  x2 	y2 ...
 this file is used by the plot-script (plot.py)

How to plot the results:
python plot.py inputFile rootsFile

in the directory ./cases/ you should find a bunch of png-files. 

Requirement: 
1) GSL: to solve the quartic equations
2) Boost.polygon: to compare the results of this code, the overlap-area of polygonized ellipses is calculated with Boost.polygon.


Below is an instrument for running your program on Windows.
(courtesy to Jerry He)

1. get a gsl that support for cmake from: https://github.com/vitaut/gsl

git clone git://github.com/vitaut/gsl.git

2. use cmake to create a Visual studio project for GSL. (install cmake if you don't have it.)

> cd gsl
> cmake .

3. after step two, you will see a GSL.sln and many other project files in the root directory of GSL, use Visual Studio (in my case, it's VS10) to open it.

4. compile gsl project and you will get a static gsl.lib, use it to link in the ellipseoverlap program.