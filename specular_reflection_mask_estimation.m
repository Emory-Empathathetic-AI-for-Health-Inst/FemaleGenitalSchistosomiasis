%% Task: this code is based on Specular reflection mask estimation using method in paper "Andriod Device-Based Cervical Cancer Screening for Resource-Poor
%Settings"
%%
clc
clear all
close all
restoredefaultpath

%% original images path
data_path='Sample_data\HEALTHY\';
save_path='SR_MASK\';
file_ID="1007_CN";
filename=fullfile(data_path,strcat(file_ID,".jpg"));
%%
flag_file=fileattrib(filename);
if (flag_file)

    img=double(imread(filename));

    % take G channel of RGB image
    G_ch=img(:,:,2);

    % convert rgb to hsv and take S channel
    hsv_img=rgb2hsv(img);
    S_ch=hsv_img(:,:,2);

    % convert rgb to LAB and take L channel
    lab_img=rgb2lab(img);
    L_ch=lab_img(:,:,1);
    A_ch=lab_img(:,:,2);
    B_ch=lab_img(:,:,3);

    Lfill = 50*ones(size(L_ch)); % pick some L level for representing A,B
    Zfill = zeros(size(L_ch));
    Lvis = mat2gray(L_ch);
    Avis = lab2rgb(cat(3,Lfill,A_ch,Zfill));
    Bvis = lab2rgb(cat(3,Lfill,Zfill,B_ch));

    % normalize G, S, L channel between 0-1
    S_norm=(S_ch-min(S_ch(:)))./(max(S_ch(:))-min(S_ch(:)));
    G_norm=(G_ch-min(G_ch(:)))./(max(G_ch(:))-min(G_ch(:)));
    L_norm=(L_ch-min(L_ch(:)))./(max(L_ch(:))-min(L_ch(:)));

    clearvars S_ch G_ch L_ch
    % obtain feature image F
    F_img=((1-S_norm).*G_norm.*L_norm);
    F_img=F_img.^3;

    figure
    subplot(231)
    imshow(F_img,[]);
    title('Raw Feature image');

    % filter the image using SD filter of size 3

    F_filt = stdfilt(F_img);
    subplot(232)
    imshow(F_filt,[]);
    title('filtered with SD filter');

    % normalize filtered image between 0-1
    F_norm=(F_filt-min(F_filt(:)))./(max(F_filt(:))-min(F_filt(:)));

    clearvars F_filt
    subplot(233)
    imshow(F_norm,[]);
    title('normalized after filtering');
    impixelinfo;

    % threshold the filtered normalized image
    thresh_F=zeros(size(F_norm));
    thresh_F=F_norm>0.05;
    clear F_norm

    subplot(234)
    imshow(thresh_F,[]);
    title('thresholded');
    impixelinfo;

    % fill the thresholded image
    fill_th=imfill(thresh_F,'holes');
    subplot(235)
    imshow(fill_th,[]);
    title('filled')
    impixelinfo;

    clear thresh_F

    % apply the dilation operation.
    SE=strel('disk',2);
    dil_F=imdilate(fill_th,SE);
    clear fill_th

    %display all the images.
    subplot(236)
    imshow(uint8(dil_F),[]);
    title('dilated image')
    impixelinfo;

    % mask will be not version of dilated image
    mask=~dil_F;

    mod_img=mask.*img;

    figure1=figure
    subplot(221)
    imshow(uint8(img),[])
    title('original')

    %% filling the blank values in RGB image

    %% MEthod I
    % Ir=regionfill(img(:,:,1),dil_F);
    % Ig=regionfill(img(:,:,2),dil_F);
    % Ib=regionfill(img(:,:,3),dil_F);
    %
    % Iout = cat(3,Ir,Ig,Ib);

    %%
    %Iout = inpaintExemplar(img,dil_F,'FillOrder','gradient','PatchSize',10);
    Iout = inpaintCoherent(img,dil_F);

    % % View the result
    subplot(222)
    imshow(uint8(mod_img),[])
    title('SR mask on original image')

    subplot(223)
    imshow(uint8(Iout),[])
    title('SR corrected')

    subplot(224)
    imshow(uint8(~mask),[])
    title('Mask SR')

    I2 = cast(Iout,'uint8');
    status=mkdir(save_path);
    if status
      imwrite(I2,strcat(save_path,file_ID,'_corr.jpg'));

      saveas(figure1, strcat(save_path, file_ID,'_SR.jpg'));
    end
end

