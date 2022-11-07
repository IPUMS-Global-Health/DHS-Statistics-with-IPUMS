# IPUMS DHS Indicators Stata

### Introduction

The purpose of this repository is to share the code necessary to replicate DHS Final Report statistics using IPUMS DHS data. 

Each chapter in the repository creates statistics for the corresponding chapter in a DHS Final Report. For example, Chapter 2 of DHS Final Reports shows "Household Characteristics;" Chapter 2 of this repository allows users to create those statistics for themselves. 

Nearly all of the Stata code in this repository is a modification of Stata .do files from [this DHS program project](https://github.com/DHSProgram/DHS-Indicators-Stata). The modifications are designed to make the code work with IPUMS DHS data. 

### Steps To Run
Here are the general steps necessary to run the code in this repository correctly. Note that each chapter also has its own README file with more specific information. 

<b>Step 1.</b> Clone this repository to your local drive. 

<b>Step 2.</b> Create One or More Data Files using [IPUMS DHS](https://dhs.ipums.org). 

<ol>
<li>
Select "GET DATA." Use the chapter-specific readme file to determine your Unit of Analysis (women, children, births, household members, or men). Some chapters require you to create data files for more than one unit of analysis. In that case, create one file at a time by repeating steps 2-7 below.
</li>
<li>
Select the data sample(s) that interest you.
</li>
<li>
Select variables for your project using the search function or the Topics drop-down menu. Each chapter's README lists the specific variables you need to conduct the analysis for that chapter.
</li>
<li>When you have selected all the samples and variables you want, click "VIEW CART"; then click “CREATE DATA EXTRACT”. (Don't worry if you forget a variable. You can always add or change variables or samples to your data file by clicking "MY DATA" on the IPUMS DHS homepage.)
</li>
<li>Choose your desired data format. *Note: For use with Stata: choose “Stata (.dta)”
</li>
<li>
Optional: Describe your extract for easy organization between your multiple data extracts
</li>
<li>Select “SUBMIT EXTRACT”. You will receive an email when your extract is ready to download. Download, unzip and save your data file. Repeat these steps for another Unit of Analysis, if required by the chapter readme file.
</li>
</ol>

<b>Step 3.</b> On your local drive, update the executing files with specifics-- the file name(s) with paths, the name(s) of your sample specific geography variable(s), and a map to your working directory. 

<b>Step 4.</b> Run the Main file for your chapter.
 
 
