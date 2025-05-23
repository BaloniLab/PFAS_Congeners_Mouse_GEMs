# PFAS_Congeners_Mouse_GEMs  

Developed by Esraa Gabal, PhD candidate at Baloni lab, HSCI department, Purdue University  

**Integration of transcriptomics with GEM iMM1865**:  

**in R programming language:**  

step 1 : Acquire the Entrez gene ID and gene length for the transcriptomics data genes using biomaRt in R  

step 2: Map the transcriptomics data against the gene list from iMM1865 model using entrez_id as the shared column ... to maintain the gene order as that in model, use **left_join()** function in R  

step 3: Replace the NA in the datasets (model genes which are not present in the transcriptomics dataste and hence, no gene count for them) by zero: **data(is.na(data)) <- 0** in R and then export the data as csv file  

**in Matlab : (needs GUROBI solver and Cobratoolbox installation)**  

step 4: Either separate the TPM_normalized csv of samples as individual csv files and run the script for iMAT integration in Matlab  OR keep them in one file, and make loop to read through each coulumn and construct an individual GEM of it    

step 5: Export the indiviudal GEM models as .mat files  

**metabolic flux analysis**  

**in Python: (needs GUROBI solver and CobraPy installation)**  

step 6: Read the iMAT GEMs models and process with FBA analysis to define the flux state while optimizing the objective function ("BIOMASS_reaction") in Python    

step 7 : Read the iMAT GEMs models and process with FVA analysis to define the flux distribution of metabolic reactions in Python    

step 8 : Read the iMAT GEMs models and process with flux sampling using the OptGPSampler algorithm with 1000 iterations to investigate the flux changes in metabolic reactions in Python    

**metabolic flux visualization**  

**in R: **  

process the outputs of FBA, FVA, and flux sampling which are exported either as .xlsx or .csv format and visulize using **tidyplot** or **ggplot2**  

for FBA output, it was normalized using SIGDA in R as identified in the methods part within the paper 

