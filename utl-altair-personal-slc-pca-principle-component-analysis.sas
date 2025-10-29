%let pgm=utl-altair-personal-slc-pca-principle-component-analysis;

%stop_submission

RE: Altair-personal-slc-pca-prniciple-component-analysis

Too long to post to listserv, see github

github
https://github.com/rogerjdeangelis/utl-altair-personal-slc-pca-principle-component-analysis

elipsoid
https://github.com/rogerjdeangelis/utl-altair-personal-slc-pca-principle-component-analysis/blob/main/ellipsoid_plot.png

slc scree plots
https://github.com/rogerjdeangelis/utl-altair-personal-slc-pca-principle-component-analysis/blob/main/princomp_plots.png

community.altair
https://community.altair.com/discussion/42010
https://community.altair.com/discussion/42010/bug-in-pca-operator-output?tab=all&utm_source=community-search&utm_medium=organic-search&utm_term=pca


 CONTENTS

    1 il- conditioned principle components
      x1 = x2 perfect correlation
      correlation matrix sigular, non invertable

    2 slc proc princomp
      Explained variance ratio 0.6170 0.2651 0.1179
      Almost 90% with first two components
      Reduces demensionality from 3 to 2

    3 python same results
      Explained variance ratio: [0.61696455 0.26514956 0.11788589]

    4 r elipsoid (note this is original nonstandarized data use.
      Just for visualization not analysis.

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

BASKETBALL STATS

POINTS    ASSISTS    REBOUNDS

  22         8           4
  29         7           3
  10         4          12
 ...
 ...
  20         4           6
  25         8           8
  18         8           3


               EIGENVECTOR
               1    2    3
            ---+----+----+----+-----------
 PROPORTION |                            | PROPORTION
            | PRPORTION OF VARIANCE      |
            |                            |
            |            EIGENVALUES     |
     0.6000 +  1 62%     PROPORTIONS     + 0.6000
            |   \                        |
     0.4000 +    \        1 0.6170       + 0.4000
            |     \       2 0.2651       |
     0.3000 +  CUM \      3 0.1179       + 0.3000
            |  89%  2 27%                |
     0.2000 +        ".                  + 0.2000
            |          ".                |
     0.1000 + 100%       3 11%           + 0.1000
            ---+----+----+----+-----------
               1    2    3
               EIGENVECTOR

UNDERSTANDING YOUR TEAM

PRIN1 (The "Scoring vs. Rebounding" Axis): This is the most important pattern, explaining 61.7% of the variation in your data.
       It strongly contrasts players who score a lot of points (high POINTS, high ASSISTS) against players who grab a lot of rebounds (high REBOUNDS).

PRIN2 (The "Pure Playmaker" Axis): This is the second most important pattern, explaining 26.5% of the variation.
       It primarily identifies players who get a high number of assists.

                              PRIN1
     -3       -2       -1        0        1        2        3
     -+--------+--------+--------+--------+--------+--------+--
     | PRIN1<0 PRIN2>0           | PRIN1>0 and PRIN2>0        |
     |                           |   PLAYMAKERS               |
     | HIGH REBOUNDS             |   ----------               |
     | HIGH ASSISTS              | HIGH ASSISTS               |
PRIN2| LOW POINTS                | HIGH POINTS                |PRIN2
   2 +                           | LOW REBOUNDS               +  2
     | PASSING BIG MAN           |                            |
     | ---------------           |        MIKE                |
     |                           |                            |
     |                           |     THEO                   |
   1 +                       PETE|                            +  1
     |                JERRY      |            ALEX            |
     |                           |       JACK  KEN            |
     |   BILL ROGER              |                            |
     |            BEN            | JOE                        |
   0 +---------------------------+----------------------------+  0
     | PRIN1<0 PRIN2<0           | PRIN1<0 PRIN2>0            |
     |                           |                 SAM        |
     | BIG DEFENDER   AL   BARRY | HIGH POINTS                |
     | ------------      BOB     | MODERATE ASSISTS           |
  -1 +               PAT    BO   | LOW REBOUNDS               + -1
     | HIGH REBOUNDS             |                  SETH      |
     | LOW ASSISTS               | ZED        TED             |
     | MODERATE POINTS           |                            |
     |                           | SCOROMG GUARD              |
  -2 +                           | -------------              + -2
     |                           |                            |
     -+--------+--------+--------+--------+--------+--------+---
     -3       -2       -1        0        1        2        3
                               PRIN1


Only need to use the first two components for future modeling, becaus these axes acount for almost 90% of the variance,
reduce demensionality frm 3 to 2

/*   _ _ _                           _ _ _   _                      _
/ | (_) | |       ___ ___  _ __   __| (_) |_(_) ___  _ __   ___  __| |
| | | | | |_____ / __/ _ \| `_ \ / _` | | __| |/ _ \| `_ \ / _ \/ _` |
| | | | | |_____| (_| (_) | | | | (_| | | |_| | (_) | | | |  __/ (_| |
|_| |_|_|_|      \___\___/|_| |_|\__,_|_|\__|_|\___/|_| |_|\___|\__,_|

*/

data x123;
 input X1 X2 X3;
cards4;
1 1 0
1 1 1
1 1 2
0 0 0
0 0 1
;;;;
run;quit;

proc corr data=x123;
run;quit;

/*---
  Pearson Correlation Coefficients, N = 5
         Prob > |r| under H0: Rho=0

              X1            X2            X3

X1       1.00000       1.00000       0.32733
                        <.0001        0.5908
        ----------
X2      |1.00000 |     1.00000       0.32733
        | <.0001 |                    0.5908
        ----------
X3       0.32733       0.32733       1.00000
          0.5908        0.5908
---*/

proc princomp data=x123;
run;quit;

WARNING: The Correlation Matrix is not positive definite.

Variables X1 and X2 have perfect linear dependence (X1 always equals X2),
causing the correlation matrix to be singular and not positive definite.
This means the correlation matrix has eigenvalues that are zero or negative
due to this perfect multicollinearity, which PCA cannot handle because
it requires an invertible matrix for calculation.

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

222      ODS _ALL_ CLOSE;
1223      ODS LISTING;
1224      FILENAME WBGSF 'd:\wpswrk\_TD22640/listing_images';
1225      OPTIONS DEVICE=GIF;
1226      GOPTIONS GSFNAME=WBGSF;
1227      data x123;
1228       input X1 X2 X3;
1229      cards4;

NOTE: Data set "WORK.x123" has 5 observation(s) and 3 variable(s)
NOTE: The data step took :
      real time : 0.005
      cpu time  : 0.000


1230      1 1 0
1231      1 1 1
1232      1 1 2
1233      0 0 0
1234      0 0 1
1235      ;;;;
1236      run;quit;
1237
1238      proc corr data=x123;
1239      run;quit;
NOTE: 5 observations were read from "WORK.x123".
NOTE: Procedure corr step took :
      real time : 0.055
      cpu time  : 0.031


1240
1241      /*---
1242        Pearson Correlation Coefficients, N = 5
1243               Prob > |r| under H0: Rho=0
1244
1245                    X1            X2            X3
1246
1247      X1       1.00000       1.00000       0.32733
1248                              <.0001        0.5908
1249              ----------
1250      X2      |1.00000 |     1.00000       0.32733
1251              | <.0001 |                    0.5908
1252              ----------
1253      X3       0.32733       0.32733       1.00000
1254                0.5908        0.5908
1255      ---*/
1256
1257      proc princomp data=x123;
1258      run;quit;
NOTE: Procedure princomp step took :
      real time : 0.066
      cpu time  : 0.015


1259      quit; run;
1260      ODS _ALL_ CLOSE;
1261      FILENAME WBGSF CLEAR;


/*___        _                   _
|___ \   ___| | ___   _ __  _ __(_)_ __   ___ ___  _ __ ___  _ __
  __) | / __| |/ __| | `_ \| `__| | `_ \ / __/ _ \| `_ ` _ \| `_ \
 / __/  \__ \ | (__  | |_) | |  | | | | | (_| (_) | | | | | | |_) |
|_____| |___/_|\___| | .__/|_|  |_|_| |_|\___\___/|_| |_| |_| .__/
                     |_|                                    |_|
*/
data my_data;
    input points assists rebounds;
    datalines;
22 8 4
29 7 3
10 4 12
5 5 15
35 6 2
8 3 10
10 4 8
8 4 3
2 5 17
4 5 19
9 9 4
7 6 4
31 5 3
4 6 13
5 7 8
8 8 4
10 4 8
20 4 6
25 8 8
18 8 3
;
run;

WORK.my_data

POINTS    ASSISTS    REBOUNDS

  22         8           4
  29         7           3
  10         4          12
 ...
 ...
  20         4           6
  25         8           8
  18         8           3

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utlfkil(d:/png/princomp_plots.png);

proc datasets lib=work nolist nodetails;
  delete stats out_data;
run;quit;

filename gout temp;
ods html(id=add_dest) body=gout gpath="d:\png";
ods graphics on / imagename="princomp_plots" reset=all;
ods output eigenvalues =  eigval;
ods output eigenvectors = eigvec;

proc princomp data=my_data out=out_data outstat=stats;
    var points assists rebounds;
run;
ods trace off;
ods graphics off;

proc print data=out_data;
title "GenStat";
run;

proc print data=stats;
title "Stats";
run;

proc print data=eigvec;
title "Eigenvectors";
run;

proc print data=eigval;
title "Eigenvalues";
run;

title;

filename gout clear;
ods graphics off;
ods _all_ close;
ods listing;

/*--- ASCI GRAPHICS ---*/

options ls=64 ps=32;
proc plot data=eigval;
  plot proportion*number/box haxis=0 to 4 by 1 vaxis=0,1 to .7 by ,1 ;
run;quit;

libname sd1 "d:/sd1";

options ls=64 ps=32;
proc plot data=sd1.out_data;;
  plot prin1*prin2/box vaxis=-3 to 4 by 1;
run;quit;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

Altair SLC

The PRINCOMP Procedure

Observations          20
Variables              3

                 Simple Statistics

              POINTS         ASSISTS        REBOUNDS

Mean     13.50000000     5.800000000     7.700000000
StD      10.06034424     1.765159900     5.120649630

           Correlation Matrix

            POINTS    ASSISTS    REBOUNDS

POINTS      1.0000     0.2341      -.6232
ASSISTS     0.2341     1.0000      -.3855
REBOUNDS    -.6232     -.3855      1.0000

           Eigenvalues of the Correlation Matrix

        Eigenvalue    Difference    Proportion    Cumulative

   1    1.85089366    1.05544499        0.6170        0.6170
   2    0.79544867    0.44179099        0.2651        0.8821
   3    0.35365768                      0.1179        1.0000

                Eigenvectors

               PRIN1       PRIN2       PRIN3

POINTS      0.603439    -.478471    0.637908
ASSISTS     0.460853    0.862106    0.210683
REBOUNDS    -.650750    0.166848    0.740733

Altair SLC

Obs    POINTS    ASSISTS    REBOUNDS     PRIN1       PRIN2       PRIN3

  1      22         8           4        1.55444     0.54966     0.26633
  2      29         7           3        1.84031    -0.30424     0.44617
  3      10         4          12       -1.22635    -0.57255     0.18525
  4       5         5          15       -1.64642     0.25140     0.42153
  5      35         6           2        2.06620    -1.11059     0.56261
  6       8         3          10       -1.35322    -1.03100    -0.35023
  7      10         4           8       -0.71801    -0.70289    -0.39337
  8       8         4           3       -0.20256    -0.77068    -1.24347
  9       2         5          17       -2.08054     0.45925     0.52062
 10       4         5          19       -2.21474     0.42929     0.93675
 11       9         9           4        1.03576     1.65635    -0.43862
 12       7         6           4        0.13254     0.28626    -0.92351
 13      31         5           3        1.43811    -1.37616     0.33427
 14       4         6          13       -1.19115     0.72219     0.18817
 15       5         7           8       -0.23467     1.00012    -0.35235
 16       8         8           4        0.71469     1.21551    -0.62139
 17      10         4           8       -0.71801    -0.70289    -0.39337
 18      20         4           6        0.13598    -1.24365    -0.04860
 19      25         8           8        1.22605     0.53732     1.03517
 20      18         8           3        1.44159     0.70732    -0.13196


Altair SLC

Obs     _TYPE_      _NAME_     POINTS     ASSISTS    REBOUNDS

  1    MEAN                    13.5000     5.8000      7.7000
  2    STD                     10.0603     1.7652      5.1206
  3    N                       20.0000    20.0000     20.0000
  4    CORR        POINTS       1.0000     0.2341     -0.6232
  5    CORR        ASSISTS      0.2341     1.0000     -0.3855
  6    CORR        REBOUNDS    -0.6232    -0.3855      1.0000
  7    EIGENVAL                 1.8509     0.7954      0.3537
  8    SCORE       Prin1        0.6034     0.4609     -0.6508
  9    SCORE       Prin2       -0.4785     0.8621      0.1668
 10    SCORE       Prin3        0.6379     0.2107      0.7407


                     EIGENVALUES

 1st Eigenvalue accounts for 62% of the variance



            EIGENVECTOR
               1    2    3
            ---+----+----+----+-----------
 PROPORTION |                            |  PROPORTION
            | PRPORTION OF VARIANCE      |
            |                            |
            |            EIGENVALUES     |
     0.6000 +  1 62%     PROPORTIONS     + 0.6000
            |   \                        |
     0.4000 +    \        1 0.6170       + 0.4000
            |     \       2 0.2651       |
     0.3000 +      \      3 0.1179       + 0.3000
            |       2 27%                |
     0.2000 +        ".                  + 0.2000
            |          ".                |
     0.1000 +            3 11%           + 0.1000
            ---+----+----+----+-----------
               1    2    3
            EIGENVECTOR

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

2023      ODS _ALL_ CLOSE;
2024      ODS LISTING;
2025      FILENAME WBGSF 'd:\wpswrk\_TD22640/listing_images';
2026      OPTIONS DEVICE=GIF;
2027      GOPTIONS GSFNAME=WBGSF;
2028
2029      %utlfkil(d:/png/princomp_plots.png);
The file d:/png/princomp_plots.png does not exist
2030
2031      proc datasets lib=work nolist nodetails;
2032        delete stats out_data;
2033      run;quit;
NOTE: Deleting "WORK.STATS" (memtype="DATA")
NOTE: Deleting "WORK.OUT_DATA" (memtype="DATA")
NOTE: Procedure datasets step took :
      real time : 0.001
      cpu time  : 0.000


2034
2035      filename gout temp;
NOTE: Writing HTML(add_dest) BODY file
      d:\wpswrk\_TD22640\#LN00006
2036      ods html(id=add_dest) body=gout gpath="d:\png";
2037      ods graphics on / imagename="princomp_plots" reset=all
2037    ! ;
2038      ods output eigenvalues =  eigval;
2039      ods output eigenvectors = eigvec;
2040      proc princomp data=my_data out=out_data outstat=stats;
2041          var points assists rebounds;
2042      run;
NOTE: Successfully written image d:\png\princomp_plots.png
NOTE: Successfully written image d:\wpswrk\_TD22640\ODS LISTING
      images\I0000010.png
NOTE: Data set "WORK.stats" has 10 observation(s) and 5
      variable(s)
NOTE: Data set "WORK.out_data" has 20 observation(s) and 6
      variable(s)
NOTE: Procedure princomp step took :
      real time : 0.234
      cpu time  : 0.109


2043      ods trace off;
2044      ods graphics off;
2045
2046      proc print data=out_data;
2047      title "GenStat";
2048      run;
NOTE: 20 observations were read from "WORK.out_data"
NOTE: Procedure print step took :
      real time : 0.025
      cpu time  : 0.015


2049
2050      proc print data=stats;
2051      title "Stats";
2052      run;
NOTE: 10 observations were read from "WORK.stats"
NOTE: Procedure print step took :
      real time : 0.007
      cpu time  : 0.000


2053
2054      proc print data=eigvec;
2055      title "Eigenvectors";
2056      run;
NOTE: 3 observations were read from "WORK.eigvec"
NOTE: Procedure print step took :
      real time : 0.020
      cpu time  : 0.000


2057
2058      proc print data=eigval;
2059      title "Eigenvalues";
2060      run;
NOTE: 3 observations were read from "WORK.eigval"
NOTE: Procedure print step took :
      real time : 0.005
      cpu time  : 0.000


2061
2062      title;
2063
2064      filename gout clear;
WARNING: The filename "gout" has not been assigned
2065      ods graphics off;
2066      ods _all_ close;
2067      ods listing;
2078      quit; run;
2079      ODS _ALL_ CLOSE;
2080      FILENAME WBGSF CLEAR;

/*____               _   _
|___ /   _ __  _   _| |_| |__   ___  _ __
  |_ \  | `_ \| | | | __| `_ \ / _ \| `_ \
 ___) | | |_) | |_| | |_| | | | (_) | | | |
|____/  | .__/ \__, |\__|_| |_|\___/|_| |_|
        |_|    |___/
*/
options set=PYTHONHOME "D:\python310";
proc python;
submit;
import numpy as np
import pandas as pd
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler

# Create the dataset
data = np.array([
    [22, 8, 4],
    [29, 7, 3],
    [10, 4, 12],
    [5, 5, 15],
    [35, 6, 2],
    [8, 3, 10],
    [10, 4, 8],
    [8, 4, 3],
    [2, 5, 17],
    [4, 5, 19],
    [9, 9, 4],
    [7, 6, 4],
    [31, 5, 3],
    [4, 6, 13],
    [5, 7, 8],
    [8, 8, 4],
    [10, 4, 8],
    [20, 4, 6],
    [25, 8, 8],
    [18, 8, 3]
])

# Create column names
columns = ['points', 'assists', 'rebounds']
df = pd.DataFrame(data, columns=columns)

print("Original Data:")
print(df)

# Standardize the data (important for PCA)
scaler = StandardScaler()
scaled_data = scaler.fit_transform(df)

# Apply PCA
pca = PCA()
principal_components = pca.fit_transform(scaled_data)

# Create DataFrame for principal components
pc_df = pd.DataFrame(
    data=principal_components,
    columns=[f'PC{i+1}' for i in range(principal_components.shape[1])]
)

print("\nPrincipal Components:")
print(pc_df)

# Explained variance
print(f"\nExplained variance ratio: {pca.explained_variance_ratio_}")
print(f"Total variance explained: {sum(pca.explained_variance_ratio_):.4f}")

# PCA loadings (eigenvectors)
print("\nPCA Loadings (Eigenvectors):")
loadings = pd.DataFrame(
    pca.components_.T,
    columns=[f'PC{i+1}' for i in range(pca.components_.shape[0])],
    index=columns
)
print(loadings)
endsubmit;
run;quit;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

The PYTHON Procedure

Original Data:

    points  assists  rebounds
0       22        8         4
1       29        7         3
2       10        4        12
3        5        5        15
4       35        6         2
5        8        3        10
6       10        4         8
7        8        4         3
8        2        5        17
9        4        5        19
10       9        9         4
11       7        6         4
12      31        5         3
13       4        6        13
14       5        7         8
15       8        8         4
16      10        4         8
17      20        4         6
18      25        8         8
19      18        8         3


Principal Components:

         PC1       PC2       PC3
0  -1.594820  0.563943  0.273245
1  -1.888120 -0.312146  0.457762
2   1.258204 -0.587428  0.190064
3   1.689194  0.257929  0.432486
4  -2.119881 -1.139439  0.577223
5   1.388379 -1.057785 -0.359332
6   0.736664 -0.721147 -0.403592
7   0.207819 -0.790704 -1.275773
8   2.134584  0.471176  0.534147
9   2.272274  0.440444  0.961086
10 -1.062663  1.699375 -0.450019
11 -0.135987  0.293699 -0.947501
12 -1.475470 -1.411915  0.342958
13  1.222099  0.740954  0.193059
14  0.240768  1.026099 -0.361499
15 -0.733258  1.247082 -0.637531
16  0.736664 -0.721147 -0.403592
17 -0.139508 -1.275963 -0.049866
18 -1.257900  0.551275  1.062067
19 -1.479044  0.725696 -0.135391


Explained variance ratio: [0.61696455 0.26514956 0.11788589]

Total variance explained: 1.0000


PCA Loadings (Eigenvectors):

               PC1       PC2       PC3
points   -0.603439 -0.478471  0.637908
assists  -0.460853  0.862106  0.210683
rebounds  0.650750  0.166848  0.740733

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

2922      ODS _ALL_ CLOSE;
2923      ODS LISTING;
2924      FILENAME WBGSF 'd:\wpswrk\_TD22640/listing_images';
2925      OPTIONS DEVICE=GIF;
2926      GOPTIONS GSFNAME=WBGSF;
2927
2928      options set=PYTHONHOME "D:\python310";
2929      proc python;
2930      submit;
2931      import numpy as np
2932      import pandas as pd
2933      from sklearn.decomposition import PCA
2934      from sklearn.preprocessing import StandardScaler
2935
2936      # Create the dataset
2937      data = np.array([
2938          [22, 8, 4],
2939          [29, 7, 3],
2940          [10, 4, 12],
2941          [5, 5, 15],
2942          [35, 6, 2],
2943          [8, 3, 10],
2944          [10, 4, 8],
2945          [8, 4, 3],
2946          [2, 5, 17],
2947          [4, 5, 19],
2948          [9, 9, 4],
2949          [7, 6, 4],
2950          [31, 5, 3],
2951          [4, 6, 13],
2952          [5, 7, 8],
2953          [8, 8, 4],
2954          [10, 4, 8],
2955          [20, 4, 6],
2956          [25, 8, 8],
2957          [18, 8, 3]
2958      ])
2959
2960      # Create column names
2961      columns = ['points', 'assists', 'rebounds']
2962      df = pd.DataFrame(data, columns=columns)
2963
2964      print("Original Data:")
2965      print(df)
2966
2967      # Standardize the data (important for PCA)
2968      scaler = StandardScaler()
2969      scaled_data = scaler.fit_transform(df)
2970
2971      # Apply PCA
2972      pca = PCA()
2973      principal_components = pca.fit_transform(scaled_data)
2974
2975      # Create DataFrame for principal components
2976      pc_df = pd.DataFrame(
2977          data=principal_components,
2978          columns=[f'PC{i+1}' for i in range(principal_components.shape[1])]
2979      )
2980
2981      print("\nPrincipal Components:")
2982      print(pc_df)
2983
2984      # Explained variance
2985      print(f"\nExplained variance ratio: {pca.explained_variance_ratio_}")
2986      print(f"Total variance explained: {sum(pca.explained_variance_ratio_):.4f}")
2987
2988      # PCA loadings (eigenvectors)
2989      print("\nPCA Loadings (Eigenvectors):")
2990      loadings = pd.DataFrame(
2991          pca.components_.T,
2992          columns=[f'PC{i+1}' for i in range(pca.components_.shape[0])],
2993          index=columns
2994      )
2995      print(loadings)
2996      endsubmit;

NOTE: Submitting statements to Python:


2997      run;quit;
NOTE: Procedure python step took :
      real time : 31.638
      cpu time  : 0.000


2998
2999      quit; run;
3000      ODS _ALL_ CLOSE;
3001      FILENAME WBGSF CLEAR;


/*  _                 _ _                 _     _
| || |    _ __    ___| (_)_ __  ___  ___ (_) __| |
| || |_  | `__|  / _ \ | | `_ \/ __|/ _ \| |/ _` |
|__   _| | |    |  __/ | | |_) \__ \ (_) | | (_| |
   |_|   |_|     \___|_|_| .__/|___/\___/|_|\__,_|
                         |_|
*/

&_init_;
proc r;
export data=my_data r=data;
submit;

# Load required packages
library(rgl)
library(matlib)

data<-as.matrix(data)

# Calculate covariance matrix and eigen decomposition
cov_mat <- cov(data)
eig <- eigen(cov_mat)
eigen_vectors <- eig$vectors
eigen_values <- eig$values

eigen_vectors;
eigen_values;
mu<-c(13.5, 5.8, 7.7)
# Create ellipsoid
ellipsoid <- ellipse3d(cov_mat, centre = mu , level = 0.95)

# Create LARGE window for high-resolution output
open3d(windowRect = c(50, 50, 1800, 1800))  # 1750x1750 pixels

# Plot with slightly larger elements for the bigger window
shade3d(ellipsoid, col = "lightblue", alpha = 0.3, lit = FALSE)
points3d(data, col = "red", size = 4)  # Slightly larger points

scale_factor <- 2
for(i in 1:3) {
  start <- mu
  end <- mu + scale_factor * sqrt(eigen_values[i]) * eigen_vectors[,i]
  lines3d(c(start[1], end[1]), c(start[2], end[2]), c(start[3], end[3]),
          col = "darkblue", lwd = 4)  # Thicker lines
  text3d(end[1], end[2], end[3],
         texts = paste("Eigenvector", i),
         col = "darkblue", cex = 1.8)  # Larger text
}

axes3d()
title3d(xlab = "X", ylab = "Y", zlab = "Z")
mtext3d("Principal Axes", "z++", line = 2)
aspect3d("iso")

legend3d("topright",
         legend = c("Data Points", "95% Confidence Ellipsoid", "Eigenvectors"),
         col = c("red", "lightblue", "darkblue"),
         pch = c(16, NA, NA),
         lty = c(NA, 1, 1),
         lwd = c(NA, 2, 3))

# Save high-resolution PNG
rgl.snapshot("d:/png/ellipsoid_plot.png", fmt = "png")
endsubmit;
run;quit;


/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

d:/png/ellipsoid_plot.png

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

3002      ODS _ALL_ CLOSE;
3003      ODS LISTING;
3004      FILENAME WBGSF 'd:\wpswrk\_TD22640/listing_images';
3005      OPTIONS DEVICE=GIF;
3006      GOPTIONS GSFNAME=WBGSF;
3007
3008      &_init_;
3009      proc r;
NOTE: Using R version 4.5.1 (2025-06-13 ucrt) from d:\r451
3010      export data=my_data r=data;
NOTE: Creating R data frame 'data' from data set 'WORK.my_data'

3011      submit;
3012
3013      # Load required packages
3014      library(rgl)
3015      library(matlib)
3016
3017      data<-as.matrix(data)
3018
3019      # Calculate covariance matrix and eigen decomposition
3020      cov_mat <- cov(data)
3021      eig <- eigen(cov_mat)
3022      eigen_vectors <- eig$vectors
3023      eigen_values <- eig$values
3024
3025      eigen_vectors;
3026      eigen_values;
3027      mu<-c(13.5, 5.8, 7.7)
3028      # Create ellipsoid
3029      ellipsoid <- ellipse3d(cov_mat, centre = mu , level = 0.95)
3030
3031      # Create LARGE window for high-resolution output
3032      open3d(windowRect = c(50, 50, 1800, 1800))  # 1750x1750 pixels
3033
3034      # Plot with slightly larger elements for the bigger window
3035      shade3d(ellipsoid, col = "lightblue", alpha = 0.3, lit = FALSE)
3036      points3d(data, col = "red", size = 4)  # Slightly larger points
3037
3038      scale_factor <- 2
3039      for(i in 1:3) {
3040        start <- mu
3041        end <- mu + scale_factor * sqrt(eigen_values[i]) * eigen_vectors[,i]
3042        lines3d(c(start[1], end[1]), c(start[2], end[2]), c(start[3], end[3]),
3043                col = "darkblue", lwd = 4)  # Thicker lines
3044        text3d(end[1], end[2], end[3],
3045               texts = paste("Eigenvector", i),
3046               col = "darkblue", cex = 1.8)  # Larger text
3047      }
3048
3049      axes3d()
3050      title3d(xlab = "X", ylab = "Y", zlab = "Z")
3051      mtext3d("Principal Axes", "z++", line = 2)
3052      aspect3d("iso")
3053
3054      legend3d("topright",
3055               legend = c("Data Points", "95% Confidence Ellipsoid", "Eigenvectors"),
3056               col = c("red", "lightblue", "darkblue"),
3057               pch = c(16, NA, NA),
3058               lty = c(NA, 1, 1),
3059               lwd = c(NA, 2, 3))
3060
3061      # Save high-resolution PNG
3062      rgl.snapshot("d:/png/ellipsoid_plot.png", fmt = "png")
3063      endsubmit;

NOTE: Submitting statements to R:

>
> # Load required packages
> library(rgl)
Attaching package: 'matlib'
The following object is masked from 'package:rgl':
    GramSchmidt
> library(matlib)
>
> data<-as.matrix(data)
>
> # Calculate covariance matrix and eigen decomposition
> cov_mat <- cov(data)
> eig <- eigen(cov_mat)
> eigen_vectors <- eig$vectors
> eigen_values <- eig$values
>
> eigen_vectors;
> eigen_values;
> mu<-c(13.5, 5.8, 7.7)
> # Create ellipsoid
> ellipsoid <- ellipse3d(cov_mat, centre = mu , level = 0.95)
>
> # Create LARGE window for high-resolution output
> open3d(windowRect = c(50, 50, 1800, 1800))  # 1750x1750 pixels
>
> # Plot with slightly larger elements for the bigger window
> shade3d(ellipsoid, col = "lightblue", alpha = 0.3, lit = FALSE)
> points3d(data, col = "red", size = 4)  # Slightly larger points
>
> scale_factor <- 2
> for(i in 1:3) {
+   start <- mu
+   end <- mu + scale_factor * sqrt(eigen_values[i]) * eigen_vectors[,i]
+   lines3d(c(start[1], end[1]), c(start[2], end[2]), c(start[3], end[3]),
+           col = "darkblue", lwd = 4)  # Thicker lines
+   text3d(end[1], end[2], end[3],
+          texts = paste("Eigenvector", i),
+          col = "darkblue", cex = 1.8)  # Larger text
+ }
>
> axes3d()
> title3d(xlab = "X", ylab = "Y", zlab = "Z")
> mtext3d("Principal Axes", "z++", line = 2)
> aspect3d("iso")
>
> legend3d("topright",
+          legend = c("Data Points", "95% Confidence Ellipsoid", "Eigenvectors"),
+          col = c("red", "lightblue", "darkblue"),
+          pch = c(16, NA, NA),
+          lty = c(NA, 1, 1),
+          lwd = c(NA, 2, 3))
>
> # Save high-resolution PNG

NOTE: Processing of R statements complete

> rgl.snapshot("d:/png/ellipsoid_plot.png", fmt = "png")
3064      run;quit;
NOTE: Procedure r step took :
      real time : 5.376
      cpu time  : 0.031


3065
3066      quit; run;
3067      ODS _ALL_ CLOSE;
3068      FILENAME WBGSF CLEAR;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
