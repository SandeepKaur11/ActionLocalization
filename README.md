# Action Localization
## Localising actions in Image Sequences
This project is based on Current state-of-the-art human action recognition is focused on the classification of temporally trimmed videos in which only one action occurs per frame. In this work we address the problem of action localisation and instance segmentation in which multiple concurrent actions of the same class may be segmented out of an image sequence.
## Implicit Shape Model for action detection
The local descriptor votes for the spatial center of the action and start and end frame of the action. DataStructure contains all the training local descriptors from a class. NoSTIPS is the numnber of Space Time Interest Points (STIPs) detected in the image sequences of the class.
The function ism_test_voting calculates the voting maps for a single image sequence.
The hough_array is a matrix with 7 rows, each column indicating the predicted(votes) spatial location, predicted (voted) start and end frames, the votes, bounding box values(scale compensated). Example: Let a descriptor matched with the codeword (with one offset) cast votes at the spatial location [x,y], temporal location [s,e] (predictions for start and end frames), bounding box values [b1 b2] (stored during training with value(weight) 'v', then corresponding column in the matrix hough_array will be [x y s e v b1 b2]'.
 
 
 ![alt text](Demo/plot1.jpg?raw=true)
 ![alt text](Demo/plot2.jpg?raw=true)
 
