This package is conceived for doing experimentation with the features introduced in the paper: 
"Persistent homology-based gait recognition robust to upper body variations".
Which has been presented in ICPR2016.

The package is created in MATLAB and consists in the following files:
1. GaitSignatures.mat: This files contains the features (topological signatures) introduced in the paper 
for the 10 samples of 123 persons in lateral view (90 degrees) of the CAISA-B dataset. Person 5 is removed due to bad segmentation.
2. GetTrainingDataset.m: Matlab function, you can consult the help in the header of the file.
3. PersonSignatures.m: Matlab function, you can consult the help in the header of the file.
4. SearchPerson.m: Matlab function, you can consult the help in the header of the file.

For using the package you must load in MATLAB the file "GaitSignatures.mat", later the functions 
"GetTrainingDataset.m", "PersonSignatures.m", "SearchPerson.m" must be used in this order.
