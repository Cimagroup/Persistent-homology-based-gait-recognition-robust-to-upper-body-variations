%
% Authors: Javier Lamar-Leon, Raul Alonso-Baryolo.
% Department of Pattern Recognition, Advanced Tecnologies Application
% Center, 2016.
%
%Code for paper: "Persistent homology-based gait recognition robust to
%upper body variations". To be evaluated in ICPR 2016.
%
%This fuction gives a set of persons signatures, resulting of the training a
%nearest mean classifier.
%
%Params:
%1. GaitSignatures: Set of topological signatures of each 90 degrees video
%secuence in CASIA-B database. The dataset for 90 degrees secuences consists
%in 123 persons, and 10 samples for each one, wich results in a total of
%1230 gait signatures. The signatures are in the file GaitSignatures.mat,
%which is included in this package.
%
%2. TrainSamples: A list of the numbers of samples (must be in [1, 10]),
%represents the samples used to train the classifier. Sample 1 and 2 represent persons
%carring a bag, samples 3 and 4 represent persons using coat, and samples
%from 5 to 10 represent persons walking under natural conditions.
%
%3. TrainPersons: A list of the numbers of persons used for training the
%classifier (numbers must be in [1, 124], number 5 can not be used as it is
%not in the dataset). If you pass 0 in this parameter, the whole set of 123
%persons is used for obtaining the classifier.
%
%Output:
%TrainedDataset: A set of mean topological signatures, each mean represents
%a person used for nearest mean classification
%
%Example:
%TrainedDataset = GetTrainingDataset(GaitSignatures, [1 3 5 6 7 8], [15 100 40 50 65 35 20 98 70 14]);
%In this case we train with the videos or signatures [1 3 5 6 7 8] of the
%persons [15 100 40 50 65 35 20 98 70 14] in CASIA-B.

function  TrainedDataset = GetTrainingDataset(GaitSignatures, TrainSamples, TrainPersons)

Samples = 10; %each person has 10 samples in the dataset.
Labels = GaitSignatures.Labels;

if(TrainPersons~=0)
    TrainLabels = zeros(size(TrainPersons,2)*Samples,1);
    for i=1 : size(TrainPersons,2)
        TrainLabels(i*Samples,1) = TrainPersons(1,i);
        TrainLabels(i*Samples-1,1) = TrainPersons(1,i);
        TrainLabels(i*Samples-2,1) = TrainPersons(1,i);
        TrainLabels(i*Samples-3,1) = TrainPersons(1,i);
        TrainLabels(i*Samples-4,1) = TrainPersons(1,i);
        TrainLabels(i*Samples-5,1) = TrainPersons(1,i);
        TrainLabels(i*Samples-6,1) = TrainPersons(1,i);
        TrainLabels(i*Samples-7,1) = TrainPersons(1,i);
        TrainLabels(i*Samples-8,1) = TrainPersons(1,i);
        TrainLabels(i*Samples-9,1) = TrainPersons(1,i);
        
    end    
    TrainedDataset.Labels = unique(TrainLabels);
    TrainedDataset.Labels(find(TrainedDataset.Labels==0)) = [];
else
   TrainLabels = TrainPersons;
   
   TrainedDataset.Labels = unique(Labels);
   TrainedDataset.Labels(find(TrainedDataset.Labels==0)) = [];
end

TrainedDataset.PersistentHomologyXRC = MedianSignature(GaitSignatures.PersistentHomologyXRC, Labels,TrainSamples,TrainLabels);
TrainedDataset.PersistentHomologyXLC = MedianSignature(GaitSignatures.PersistentHomologyXLC, Labels,TrainSamples,TrainLabels);
TrainedDataset.PersistentHomologyXRT = MedianSignature( GaitSignatures.PersistentHomologyXRT, Labels,TrainSamples,TrainLabels);
TrainedDataset.PersistentHomologyXLT = MedianSignature(GaitSignatures.PersistentHomologyXLT, Labels,TrainSamples,TrainLabels);

TrainedDataset.PersistentHomologyYRC = MedianSignature(GaitSignatures.PersistentHomologyYRC, Labels,TrainSamples,TrainLabels);
TrainedDataset.PersistentHomologyYLC = MedianSignature(GaitSignatures.PersistentHomologyYLC, Labels,TrainSamples,TrainLabels);
TrainedDataset.PersistentHomologyYRT = MedianSignature(GaitSignatures.PersistentHomologyYRT, Labels,TrainSamples,TrainLabels);
TrainedDataset.PersistentHomologyYLT = MedianSignature(GaitSignatures.PersistentHomologyYLT, Labels,TrainSamples,TrainLabels);

TrainedDataset.PersistentHomologyXYRC = MedianSignature(GaitSignatures.PersistentHomologyXYRC, Labels,TrainSamples,TrainLabels);
TrainedDataset.PersistentHomologyXYLC = MedianSignature(GaitSignatures.PersistentHomologyXYLC, Labels,TrainSamples,TrainLabels);
TrainedDataset.PersistentHomologyXYRT = MedianSignature(GaitSignatures.PersistentHomologyXYRT, Labels,TrainSamples,TrainLabels);
TrainedDataset.PersistentHomologyXYLT = MedianSignature(GaitSignatures.PersistentHomologyXYLT, Labels,TrainSamples,TrainLabels);

TrainedDataset.PersistentHomologyYXRC = MedianSignature(GaitSignatures.PersistentHomologyYXRC, Labels,TrainSamples,TrainLabels);
TrainedDataset.PersistentHomologyYXLC = MedianSignature(GaitSignatures.PersistentHomologyYXLC, Labels,TrainSamples,TrainLabels);
TrainedDataset.PersistentHomologyYXRT = MedianSignature(GaitSignatures.PersistentHomologyYXRT, Labels,TrainSamples,TrainLabels);
TrainedDataset.PersistentHomologyYXLT = MedianSignature(GaitSignatures.PersistentHomologyYXLT, Labels,TrainSamples,TrainLabels);

end

function  Median = MedianSignature(Signatures, Labels, TrainSamples, TrainLabels)

VectorsSum = zeros(1,size(Signatures,2));
if(TrainLabels==0)
  TrainLabels = unique(Labels);
end
TrainLabels = unique(TrainLabels);
TrainLabels(TrainLabels==0)=[];
for i=1: size(TrainLabels,1)
    [row,col] = find(Labels==TrainLabels(i));
    count = 0;
    for j=1 : size(row,1)
        Current = find(j==TrainSamples);
        if(size(Current,2)~=0)
            if(sum(Signatures(row(j),:))~=0)
                VectorsSum = VectorsSum + Signatures(row(j),:);
                count= count+1;
            end
        end
    end
    MedianVector = VectorsSum/count;
    Median(i,:) = MedianVector;
    VectorsSum = zeros(1,size(Signatures,2));
end
end




