% read the parental mice model
iMM1865 = readCbModel('path/to/mouseGEM.mat');

% work with iMAT
% initiate cobra toolbox first and get the gurobi license activated 
initCobraToolbox('false');
changeCobraSolver ('gurobi', 'all');

% set the path to the folder where the individual CSV files are located
PFAS_path = 'Path/to/TPM_normalized_data';  
files = dir(fullfile(PFAS_path, '*.csv'));  % Get a list of all CSV files in the folder
disp({files.name});  % Display the names of all files

% get the BIOMASS_reaction:
printObjective(iMM1865);

% Initialize cell array to store models
allModels = cell(length(files), 1);

% create the sample-specific models 
for i = 1:length(files)
    % Construct the full file path for the CSV file
    file_path = fullfile(files(i).folder, files(i).name);
    
    % Read the csv file, specifying variable types for each column
    data = readtable(file_path);
    
    % Extract genes and expression values from the CSV
    genes = iMM1865.genes; % get that from iMMA865 gene list which is already in the same order as that of gene expression data 
    expression_values = data{:, 2};
    
    % Map the gene expression data to the model
    exprData.gene = genes;
    exprData.value = expression_values;
    
    % Map expression to model reactions
    [rxn_expression, parsedGPR] = mapExpressionToReactions(iMM1865, exprData);
    rxn_expression(4878,1) = 1; % set the expression value of objective reaction to 1
    
    % Calculate threshold
    a = median(prctile(rxn_expression, 50));
    tol = 1e-6;  % Define tolerance
    core = {'BIOMASS_reaction'};  % Define core reactions
    
    % Run iMAT to create the tissue-specific model for each sample
    iMAT_model = iMAT(iMM1865, rxn_expression, 0, a, tol, core);
    
    % Update the list of genes
    iMAT_model = updateGenes(iMAT_model);
    
    % Save the model for each sample (as .mat file)
    output_folder = '/path/to/iMAT_output';  
    model_filename = fullfile(output_folder, ['iMAT_model_' files(i).name(1:end-4) '.mat']);
    save(model_filename, 'iMAT_model');
    
    % Display progress
    fprintf('Processed file: %s\n', files(i).name);
end
