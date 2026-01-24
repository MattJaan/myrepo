# QMEE
BIO708 work 
 
The data is absorption over time of in vitro high-throughput sequencing NADPH assay of different CYP1 proteins in vitro. CYP proteins work in chemical defence to break down toxins. Each well of the plate was labeled with alphabetical rows and numerical columns with noted reagents. Different wells contained the desired protein, NADPH and reductase with the various different combinations to control for the changes in absorption of the individual components and combinations without proteins present. The goal of the data is to find target substrates for various cyp proteins in order to then use them in vivo with cyp knockout lines to see effects in the live organisms.

Assignment 2 is in the Assignment2 directory with two R scripts. Assingment2_1.R should be run first followed by Assignment2_2.R. The Assignment2_1.R file first converts the layout of the output from assignment 2 and also adds more data columns based on the layout of the experiment and well plates. It makes a singular slope column and adds columns (protein and assay) based on number components of the well plate labels. Assignment2_2.R makes a box and whisker plot based using the slopes for each protein and assay type. Both files should be ran in the Assignment2 directory. 

My investigation is looking into targets for specific CYP genes for use in various CYP knockout lines. The best way to make these more replicable would be to run them more generally without coding for specific file names but rather types i.e. all rds files from a directory and then having outputs having names depending on the name of the file that it is being ran on. Also maybe having other files with legends for the different proteins and plates to then allow for more robust code for more proteins and assays. 

Jan 23
Assignment 3 is in the Assignment 3 folder. The graphs made are trying to show the difference in slope which is representative of the activity level of protein in each assay for each protein. The facet grid by protein are made to show the activity level based the assay type to easily compare within a singular protein to see if the change in slope is actually caused by the protein or but assay controls. The second facet grid by assay is designed to compare the protein activity levels in each of the assays. This allows us to determine if the contents of the assay should be used as a target for those genes in vivo experiments. I wanted to make two of them just so that then the viewer doesn't need to compare vertically across plots but twice horizontally. Both are set up to see the average slope grouped by first by protein and then assay or vice versa with error bars or 2 times the standard error. 

BMB: 
* did you think about the ordering of the categories? looks like they're in the default (alphabetical) order. 
* units on the y-axis?
* I don't know what the units are, but does it make sense to scale by 10^4 or 10^5 (so that the values are -2 to 0 or -20 to 0 rather -0.00020 to 0, which makes the viewer count zeros ?
* is setting scale="free" useful (which expands the range we can see), or do we need all these plots to have the same ranges?
* you can turn the strip labels horizontal, which makes them easier to read
* would using facet_wrap instead of facet_grid make this easier to read?
* do you like the default theme (theme_gray) or did you consider other themes?
