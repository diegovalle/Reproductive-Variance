Reproductive Variance Around the World
=======================================

Because of biological constraints the maximum number of children women can have is lower than that of men. Furthermore, human societies have many different mating arrangements: monogamy, serial monogamy, polygamy and in rare cases polyandry. All this means there should differences in the distributions of number of children women and men have. One simple way of measuring the difference would be the ratio of male variance in the number children had to that of females.


Possible Problems
-----------------

- Some men don't recognize their children
- Non-paternity events, where the child's biological father is someone other than who it is presumed to be
- The upper bound for the number of kids recorded in the world values survey is 8, this would skew the variance ratio in favor of women
- Men are older on average when they have their first child. I set a cutoff age of 33 since at that age the regression between age and number of children was no longer significant. I would have prefered something like 50, but sample size issues prevented me from doing it.
- Sample size (especially in less developed countries), this would tend to increase the error of the variance ratio
- According to Sarah Hrdy in _Mother Nature_, the children of men in polygamous marriage are more likely to die, I would expect them to be less likely to be recorded. This would skew the variance ratio in favor of women 

![Map of Reproductive Variance](http://imgur.com/HWt5M.png)

Requirements
---------------
1. Create two directories named "map" and "data"

2.  You'll need to download 3 files from the [world values survey website](http://www.wvsevsdb.com/wvs/WVSData.jsp?Idioma=I) and place them in the "data" directory. Make sure the files you download are in __STATA__ format

    _1) WVS 2000 official file compressed in ZIP format (SPSS=6.3Mb, SAS=7.1Mb, STATA=7.1Mb)_
  
    _2) WVS2005-List A official file v.20090901 compressed in ZIP format (SPSS=8.6Mb, SAS=14.6Mb, STATA=7.6Mb)_
  
    _3) WVS2005-List B official file v.20090901 compressed in ZIP format (SPSS=1.8Mb, SAS=2.8Mb, STATA=1.5Mb)_

    You'll have to register to download them. Once downloaded unzip them into the same directory.

3.  Download a shapefile of the [different countries of the world](http://thematicmapping.org/downloads/world_borders.php) and place it in the "map" directory: 

    [Direct link to shapefile](http://thematicmapping.org/downloads/TM_WORLD_BORDERS_SIMPL-0.3.zip)

    > The original shapefile (world_borders.zip, 3.2 MB) was downloaded from the [Mapping Hacks website](http://www.mappinghacks.com/data/): http://www.mappinghacks.com/data/

    > The dataset is available under a Creative Commons Attribution-Share Alike License. If you use this dataset, please provide a link to this website.



