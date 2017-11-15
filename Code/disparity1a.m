%Part 1a: find the disparity between 2 images
%left_img is the left image gray matrix, i.e run rgb2gray function
%right_img is the right image gray matrix
%function disparity1a(left_img, right_img)
    %TEMP CODE FOR TESTING. Using Matlabs test images
    close all;
    numOfTestImgs = 3; 
    imgsList = getData([], 'test', 'list'); 
    imageNums = imgsList.ids(1:numOfTestImgs);
    imgDepths = {};
        disparityRange = [-6 10];

    %go through each image and find/show depth
    for i = drange(1:numOfTestImgs)
        %left_img = rgb2gray(double(imread('um_000000.png'))/255);
        %right_img = rgb2gray(double(imread('scene_right.png'))/255);
        
        left_imdata = getData(imageNums{i}, '/road_left/training/results', 'left');
        left_img = left_imdata.im;
        right_imdata = getData(imageNums{i}, '/road_left/training/', 'right');
        right_img = left_imdata.im;

        disparityMap = disparity(left_img,right_img,'BlockSize',patch_size,'DisparityRange',disparityRange);
        
        
        fileLocation = sprintf('%s/%s/%s_disparity.mat', DATA_DIR,'/road_left/training/results',imageNums{i});
        save(fileLocation,'disparityMap');
        
        
        figure,imshow(disparityMap,disparityRange);
        title('Test Disparity Map');
        colormap(gca,jet) 
        colorbar
        
    end
    
    
    
    
    
    
    
    
%     need to figure out camera parms for this to work
%     fx_d = 5.8262448167737955e+02;  
%     fy_d = 5.8269103270988637e+02;
%     px_d = 3.1304475870804731e+02;
%     py_d = 2.3844389626620386e+02;
%     matrix3d = zeros(size(disparityMap,1),size(disparityMap,2),3);
%     
%     for x =drange(1:size(disparityMap,2))
%         for y = drange(1:size(disparityMap,1))
%             z = disparityMap(y,x);
%             mx = (x-px_d).*z/fx_d; 
%             my = (y-py_d).*z/fy_d; 
%             matrix3d(y,x,:) = [mx,my,z];
%         end
%     end
% 
%     figure,plot3(matrix3d(:,:,1),matrix3d(:,:,2),matrix3d(:,:,3))
%     s = surf(matrix3d(:,:,1),matrix3d(:,:,2),matrix3d(:,:,3),imread('scene_left.png'))
%     set(s,'LineStyle','none');
% 
%     axis equal;
%     ------
%     
%    
%     for x = drange(15,size(left_img,2)-15)
%         for y = drange(15,size(left_img,1)-15)
%            xStart = floor(x-patch_size/2);
%            yStart = floor(y-patch_size/2);
%             
%             patch_left = imcrop(left_img,[xStart yStart patch_size patch_size]);
%             
%             currentSSDs = [];
%             
%             for xr = drange(15,size(right_img,2)-15)
%                 xrStart = floor(xr-patch_size/2);
%             
%                 patch_right = imcrop(right_img,[xrStart yStart patch_size patch_size]);
% 
%                 currentSSDs(size(currentSSDs,2)+1) = sum(sum((patch_left - patch_right)^2));
%                 
%             end
%         min(currentSSDs)
%         end
%     end
% 
% 
%     
%     
%     
%     
%     
%     
% %end