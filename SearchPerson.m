%
% Authors: Javier Lamar-Leon, Raul Alonso-Baryolo.
% Department of Pattern Recognition, Advanced Tecnologies Application
% Center, 2016.
%
%Code for paper: "Persistent homology-based gait recognition robust to
%upper body variations". To be evaluated in ICPR 2016.
%
%This fuction gives the classification of a person as a candidates list
%given the trained classifier, the person represented by its signature and a threshold.
%
%Params:
%1. TrainedSignatures: Trained classifier, it is just the set of means
%obtained by the fuction GetTrainingDataset.m distributed with this
%package.
%
%2. Person: Signature of a person in CASIA-B dataset, it is just the result
%obtained by the function PersonSignatures.m distributed with this package.
%
%3. Threshold: This is the aceptance threshold, it must be in [0, 1440],
%since it is the sum of the angles of 16 vectors, the best value whould be
%0 in case of a perfect comparison. Figure 6 in the paper: "Persistent
%homology-based gait recognition robust to upper body variations" could
%help to understand better the goal of this value.
%
%Output:
%This fuctions prints a list of at most 10 persons numbers, orderes in
%descending order of similarity with the person represented by "Person". If
%the number of similar persons with a threshold bigger than "Threshold" is
%smaller than 10, then only those persons are printed.
%
%Example: 
%SearchPerson(TrainedDataset,Person,253.8);
%Result: "The persons found by descendig similarity values are ---> 70"
%In this case we look for the person represented by "Person" (obtained by
%the function PersonSignatures.m) in the set of persons represented by
%TrainedDataset (obtained by the fuction GetTrainingDataset.m) with a
%threshold of 253.8.


function f = SearchPerson(TrainedDataset, Person, Threshold)
f = 0;
CosineMeasureMax = inf;
Index = 0;

if(size(TrainedDataset.Labels, 1) > 10)
    Rank = 10;
else
    Rank = size(TrainedDataset.Labels,1);
end

for k=1 : size(TrainedDataset.PersistentHomologyXRC,1)
    
    SimilarityCR = CosineSimilarity(TrainedDataset.PersistentHomologyXRC(k,:),Person.PersistentHomologyXRC);
    SimilarityCL = CosineSimilarity(TrainedDataset.PersistentHomologyXLC(k,:),Person.PersistentHomologyXLC); 
    SimilarityTR = CosineSimilarity(TrainedDataset.PersistentHomologyXRT(k,:),Person.PersistentHomologyXRT);
    SimilarityTL = CosineSimilarity(TrainedDataset.PersistentHomologyXLT(k,:),Person.PersistentHomologyXLT); 
    
    SimilarityCRy = CosineSimilarity(TrainedDataset.PersistentHomologyYRC(k,:),Person.PersistentHomologyYRC); 
    SimilarityCLy = CosineSimilarity(TrainedDataset.PersistentHomologyYLC(k,:),Person.PersistentHomologyYLC); 
    SimilarityTRy = CosineSimilarity(TrainedDataset.PersistentHomologyYRT(k,:),Person.PersistentHomologyYRT); 
    SimilarityTLy = CosineSimilarity(TrainedDataset.PersistentHomologyYLT(k,:),Person.PersistentHomologyYLT); 
       
    SimilarityCRxy = CosineSimilarity(TrainedDataset.PersistentHomologyXYRC(k,:),Person.PersistentHomologyXYRC); 
    SimilarityCLxy = CosineSimilarity(TrainedDataset.PersistentHomologyXYLC(k,:),Person.PersistentHomologyXYLC); 
    SimilarityTRxy = CosineSimilarity(TrainedDataset.PersistentHomologyXYRT(k,:),Person.PersistentHomologyXYRT); 
    SimilarityTLxy = CosineSimilarity(TrainedDataset.PersistentHomologyXYLT(k,:),Person.PersistentHomologyXYLT); 
    
    SimilarityCRYX = CosineSimilarity(TrainedDataset.PersistentHomologyYXRC(k,:),Person.PersistentHomologyYXRC); 
    SimilarityCLYX = CosineSimilarity(TrainedDataset.PersistentHomologyYXLC(k,:),Person.PersistentHomologyYXLC); 
    SimilarityTRYX = CosineSimilarity(TrainedDataset.PersistentHomologyYXRT(k,:),Person.PersistentHomologyYXRT); 
    SimilarityTLYX = CosineSimilarity(TrainedDataset.PersistentHomologyYXLT(k,:),Person.PersistentHomologyYXLT); 
  
    
    Similarity1 = SimilarityCR +  SimilarityCL + SimilarityTR + SimilarityTL;
    Similarity2 = SimilarityCRy + SimilarityCLy + SimilarityTRy + SimilarityTLy;
    Similarity3 = SimilarityCRxy + SimilarityCLxy +  SimilarityTRxy + SimilarityTLxy;
    Similarity4 = SimilarityCRYX + SimilarityCLYX +  SimilarityTRYX + SimilarityTLYX;
    
    Similarity = Similarity1 + Similarity2 + Similarity3 + Similarity4;
   
    Values(1,k) =  Similarity;
   
    if(Similarity<CosineMeasureMax && Similarity<=Threshold)
        Index = k;
        CosineMeasureMax=Similarity;
    end
end

[a, SortedIndexes] = sort(Values,'ascend');
val = find(Values(SortedIndexes) <= Threshold, 1, 'last');
SortedIndexes = SortedIndexes(1 : val);

if(size(SortedIndexes, 1) > Rank)
 PersonsLabels = TrainedDataset.Labels(SortedIndexes(1:Rank,1),:)';
else
 PersonsLabels = TrainedDataset.Labels(SortedIndexes(1,1:end),:)'; 
end

if(Index~=0)
    disp(['The persons found by descendig similarity values are ---> ', num2str(PersonsLabels)]);
    f = PersonsLabels(1,1);
else
    disp('The person you are looking is not in the trained list');
end

end

function Similarity = CosineSimilarity(LeftVector, RightVector)
LeftVector = LeftVector';
RightVector = RightVector';

InnerProduct = sum(RightVector.*LeftVector);

LeftVectorNorm = sqrt(sum(power(RightVector,2)));
RightVectorNorm = sqrt(sum(power(LeftVector,2)));

Similarity = acos(InnerProduct/(LeftVectorNorm*RightVectorNorm))*180/pi;

end

