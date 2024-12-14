clc; clear; close all;

% varibles for overall metric parameters
Sum_Sensitivity = 0;
Sum_Specificity = 0;
Sum_Accuracy = 0;
Metrics = zeros(21,3);


for i=1:20
    % reading all test images
    if i<10
        ImageName = strcat("Q3\DRIVE\Test\images\",sprintf("0%d_test.tif",i));
        MaskName = strcat("Q3\DRIVE\Test\mask\",sprintf("0%d_test_mask.gif",i));
        ManualName = strcat("Q3\DRIVE\Test\1st_manual\",sprintf("0%d_manual1.gif",i));
    else
        ImageName = strcat("Q3\DRIVE\Test\images\",sprintf("%d_test.tif",i));
        MaskName = strcat("Q3\DRIVE\Test\mask\",sprintf("%d_test_mask.gif",i));
        ManualName = strcat("Q3\DRIVE\Test\1st_manual\",sprintf("%d_manual1.gif",i));
    end

    Original = im2double(imread(ImageName));
    Mask = im2double(imread(MaskName));
    Manual = im2double(imread(ManualName));
    
    % we only use green matrix of image
    GreenImage = Original(:,:,2);
    
    % adapthisteq 
    CLAHE = adapthisteq(GreenImage);
    Median = medfilt2(CLAHE);
    I_1 = Median .*(Mask);
    H = fspecial("average",[13 13]);
    Mean = imfilter(I_1,H);
    Diff =I_1 - Mean;
    Thresholded = imbinarize(Diff,-.042);
    Comp = 1- Thresholded;

    Final = Comp .*Mask;
    SE_2 = strel('disk',1);
    Final = imopen(Final,SE_2);
    Final = imdilate(Final,SE_2);

    TP = 0;
    TN = 0;
    FP = 0;
    FN = 0;
    
    [rows, cols] = size(Manual);

    for r = 1:rows    % for number of rows of the image
        for c = 1:cols    % for number of columns of the image
            if Manual(r,c) == 1 && Final(r,c) == 1
                TP = TP + 1;
            end
            if Manual(r,c) == 0 && Final(r,c) == 0
                TN = TN + 1;
            end
            if Manual(r,c) == 0 && Final(r,c) == 1
                FP = FP + 1;
            end
            if Manual(r,c) == 1 && Final(r,c) == 0
                FN = FN + 1;
            end
        end
    end
    
    Sensitivity = TP / (TP + FN);
    Specificity = TN / (TN + FP);
    Accuracy = (TP + TN) / (TP + TN + FP + FN);

    Metrics(i,1) = Sensitivity;
    Metrics(i,2) = Specificity;
    Metrics(i,3) = Accuracy;

    Sum_Sensitivity = Sum_Sensitivity + Sensitivity;
    Sum_Specificity = Sum_Specificity + Specificity;
    Sum_Accuracy = Sum_Accuracy + Accuracy;


    subplot(1,2,1)
    imshow(Manual);
    title('Manual Image')

    subplot(1,2,2)
    imshow(Final);
    title({num2str(i),['Sensitivity =' num2str(Sensitivity)],['Specificity =' num2str(Specificity)],['Accuracy =' num2str(Accuracy)]});

end

Avg_Sensitivity = Sum_Sensitivity/20;
Avg_Specificity = Sum_Specificity/20;
Avg_Accuracy = Sum_Accuracy/20;
