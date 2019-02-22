%
% Authors: Javier Lamar-Leon, Raul Alonso-Baryolo.
% Department of Pattern Recognition, Advanced Tecnologies Application
% Center, 2016.
%
%Code for paper: "Persistent homology-based gait recognition robust to
%upper body variations". To be evaluated in ICPR 2016.
%
%This fuction gives the topological signature representing a person in
%CASIA-B dataset.
%
%Params:
%1. GaitSignatures: Set of topological signatures of each 90 degrees video
%secuence in CASIA-B database. The dataset for 90 degrees secuences consists
%in 123 persons, and 10 samples for each one, wich results in a total of
%1230 gait signatures. The signatures are in the file GaitSignatures.mat,
%which is included in this package.
%
%2. PersonToExtrac: The number of the person used for extracting the
%signature (the number must be in [1, 124], number 5 can not be used as it is
%not in the dataset).
%
%3. Sample: Number of the sample of the selected person (must be in [1, 10]). 
%Sample 1 and 2 represent persons carring a bag, samples 3 and 4 represent
%persons using coat, and samples from 5 to 10 represent persons walking
%under natural conditions.
%
%Output:
%Person: The topological signature representing a given person of the
%CASIA-B dataset.
%
%Example:
%Person = PersonSignatures(GaitSignatures, 70, 2);
%In this case we get the signature for the second sample (carring a bag) of
%the person 70 in CASIA-B dataset.

function Person = PersonSignatures(GaitSignatures, PersonToExtrac, Sample)
Person = [];
Labels = GaitSignatures.Labels;


if(PersonToExtrac == 5)
    disp('Person 5 is no in the dataset')
else
    
    [row, col] = find(Labels == PersonToExtrac);
    sample = row(Sample, 1);
    
    vectors.PersistentHomologyXLC = GaitSignatures.PersistentHomologyXLC(sample,:);
    vectors.PersistentHomologyXLT = GaitSignatures.PersistentHomologyXLT(sample,:);
    vectors.PersistentHomologyXRC = GaitSignatures.PersistentHomologyXRC(sample,:);
    vectors.PersistentHomologyXRT = GaitSignatures.PersistentHomologyXRT(sample,:);
    
    vectors.PersistentHomologyYLC = GaitSignatures.PersistentHomologyYLC(sample,:);
    vectors.PersistentHomologyYLT = GaitSignatures.PersistentHomologyYLT(sample,:);
    vectors.PersistentHomologyYRC = GaitSignatures.PersistentHomologyYRC(sample,:);
    vectors.PersistentHomologyYRT = GaitSignatures.PersistentHomologyYRT(sample,:);
    
    vectors.PersistentHomologyXYLC  = GaitSignatures.PersistentHomologyXYLC(sample,:);
    vectors.PersistentHomologyXYLT  = GaitSignatures.PersistentHomologyXYLT(sample,:);
    vectors.PersistentHomologyXYRC = GaitSignatures.PersistentHomologyXYRC(sample,:);
    vectors.PersistentHomologyXYRT  = GaitSignatures.PersistentHomologyXYRT(sample,:);
    %
    vectors.PersistentHomologyYXLC  = GaitSignatures.PersistentHomologyYXLC(sample,:);
    vectors.PersistentHomologyYXLT = GaitSignatures.PersistentHomologyYXLT(sample,:);
    vectors.PersistentHomologyYXRC  = GaitSignatures.PersistentHomologyYXRC(sample,:);
    vectors.PersistentHomologyYXRT  = GaitSignatures.PersistentHomologyYXRT(sample,:);
    
    Person = vectors;
    
end
end