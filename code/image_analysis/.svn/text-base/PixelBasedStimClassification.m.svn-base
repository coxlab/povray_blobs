% ######################################################################################################################
%
%                    PixelBasedStimClassification
%         
% ######################################################################################################################
%
%   This function uses an SVM classifier to test generalization of performance across the set of blob stimuli used to
%   train/test the rats.
%
%   INPUTS:
%       - RunMode: choose what stage of the analysis must be performed:
%           1) 'build data struct'
%           2) 'classify no noise'
%           3) 'classify with noise'
%           4) 'plot perf matrix'
%       - Perf2load: choose what data files with a previously stored analysis must be opened (meaningful also is such a
%           file exists and when run in mode 4)
%       - sigma2plot: choose what level of sigma in the Gaussian noise must be displayed (when running in mode 4)
%
%   CALLED FUNCTIONS:
%
%   Example:
%       
%       1) Make classification
%       >> PixelBasedStimClassification( 'classify with noise' )
%
%       2) display results of a previously stored classification
%       >> PixelBasedStimClassification( 'plot perf matrix', 'PerfTrainTest_sigma_start0_step10_end1500_N10', 550 )
%
%
% ######################################################################################################################


function PixelBasedStimClassification( RunMode, Perf2load, sigma2plot );


PathName = 'Blobs_1and2_views_sizes/';
RangeSize = 40:-5:15;
% RangeSize = [40];
ViewRange = [-60:15:60];
% ViewRange = [-60];
N_size = length(RangeSize);
N_rot_dep = length(ViewRange);



% Build and save the training and testing data structures, using the pixel intensities to build the feature vectors
if strcmp( RunMode, 'build data struct' )


    X_trn = [];
    y_trn = [];
    size_trn = [];
    view_trn = [];
    X_tst = [];
    y_tst = [];
    size_tst = [];
    view_tst = [];

    figure;
    % Loop on the stimulus identity
    for N = [1,2]

        % Loop on the views
        for v = ViewRange
            % Loop on sizes
            for s = RangeSize

                ImageName = ['Blur_DwnSmp_Blob_N', num2str(N), '_CamRot_y', num2str(v), '_Size', num2str(s), '.png'];
                disp(['Load ', ImageName]);
                Img = imread([PathName,ImageName]);
                imshow(Img);
                drawnow;
                Img = double(Img);
                [row col] = size(Img);

                % Build structure with TRAINING data
                if s == 30 | v == 0
                    X_trn = [X_trn, reshape(Img, row*col, 1)];
                    y_trn = [y_trn, N];
                    size_trn = [size_trn, s];
                    view_trn = [view_trn, v];
                % Build structure with TESTING data    
                else
                    X_tst = [X_tst, reshape(Img, row*col, 1)];
                    y_tst = [y_tst, N];
                    size_tst = [size_tst, s];
                    view_tst = [view_tst, v];
                end;

            end; %for s
        end; %for v

    end; %for N
    disp(' ');

    disp( 'TRAINING data:' )
    trn.X = X_trn;
    trn.y = y_trn;
    trn.size = size_trn;
    trn.view = view_trn;
    [trn.dim trn.num_data] = size(X_trn);
    disp(['dimensions = ', num2str(trn.dim), '; samples = ', num2str(trn.num_data)]);
    disp(' ');

    disp( 'TESTING data:' );
    tst.X = X_tst;
    tst.y = y_tst;
    tst.size = size_tst;
    tst.view = view_tst;
    [tst.dim tst.num_data] = size(X_tst);
    disp(['dimensions = ', num2str(tst.dim), '; samples = ', num2str(tst.num_data)]);
    disp(' ');

    % Save data struct (this flag is for double safety ... to avoid deleting previously stored feature vecotrs)
    FlagSaveDataStruct = 1;
    if FlagSaveDataStruct
        save( [PathName,'TrainingAndTestingData.mat'], 'trn', 'tst' );
    else
        disp( 'WARNING: the data structure WAS NOT SAVED! Set FlagSaveDataStruct to 1 to save it!' );
    end;

    
elseif strcmp(RunMode, 'classify no noise')
    
    load([PathName,'TrainingAndTestingData.mat']);
    disp(['load ', PathName,'TrainingAndTestingData.mat']);  
    
    
    % Build classifier
    options.ker = 'linear';  
    options.arg = 1;  
    options.C = 10; 
    
    model = svmquadprog(trn,options)
    ypred = svmclass(tst.X,model)
    disp('SIZES:');
    tst.size
    disp('VIEWS');
    tst.view
    disp( ['Classification error = ', num2str(cerror(ypred,tst.y)) ]);
    
    
elseif strcmp(RunMode, 'classify with noise')
    
    load([PathName,'TrainingAndTestingData.mat']);
    disp(['load ', PathName,'TrainingAndTestingData.mat']);  
    
    % Options classifier
    options.ker = 'linear';  
    options.arg = 1;  
    options.C = 10; 
    
    
    % ======== Build and test classifier over DIFFERENT stimulus conditions (and with different noise) =========
    % Expand the data matrixes
    Nrep = 10;
    curr_trn = trn;
    curr_trn2 = trn;
    curr_tst = tst;
    
    curr_trn.X = repmat(curr_trn.X, 1, Nrep);
    curr_trn.y = repmat(curr_trn.y, 1, Nrep);
    curr_trn.size = repmat(curr_trn.size, 1, Nrep);
    curr_trn.view = repmat(curr_trn.view, 1, Nrep);
    curr_trn.num_data = curr_trn.num_data * Nrep;
    
    curr_trn2.X = repmat(curr_trn2.X, 1, Nrep);
    curr_trn2.y = repmat(curr_trn2.y, 1, Nrep);
    curr_trn2.size = repmat(curr_trn2.size, 1, Nrep);
    curr_trn2.view = repmat(curr_trn2.view, 1, Nrep);
    curr_trn2.num_data = curr_trn2.num_data * Nrep;

    curr_tst.X = repmat(curr_tst.X, 1, Nrep);
    curr_tst.y = repmat(curr_tst.y, 1, Nrep);
    curr_tst.size = repmat(curr_tst.size, 1, Nrep);
    curr_tst.view = repmat(curr_tst.view, 1, Nrep);
    curr_tst.num_data = curr_tst.num_data * Nrep;
    
    
    % Add Gaussian noise (loop on sigma of the noise)
    Idx = 1;
    sigma_start = 0;
    sigma_step = 10;
    sigma_end = 1500;
    sigma_range = [sigma_start:sigma_step:sigma_end];

    for sigma = sigma_range
        curr_trn_noise = curr_trn;
        curr_trn2_noise = curr_trn2;
        curr_tst_noise = curr_tst;
        
        curr_trn_noise.X = curr_trn_noise.X + random('norm', 0, sigma, [curr_trn_noise.dim, curr_trn_noise.num_data]);
        curr_trn2_noise.X = curr_trn2_noise.X + random('norm', 0, sigma, [curr_trn2_noise.dim, curr_trn2_noise.num_data]);
        curr_tst_noise.X = curr_tst_noise.X + random('norm', 0, sigma, [curr_tst_noise.dim, curr_tst_noise.num_data]);
        
        FlagPlotSomeImage = 0;
        if FlagPlotSomeImage
            figure;
            for im = 1:28
                Img = reshape(curr_trn_noise.X(:,im), 80, 140); 
                Img = uint8(Img);
                subplot(4,7,im);
                imshow(Img);
                colormap(gray(256));
            end;
        end;
        
        % Classifier
        model = svmquadprog(curr_trn_noise,options);
        ypred_trn2 = svmclass(curr_trn2_noise.X,model);
        ypred_tst = svmclass(curr_tst_noise.X,model);
        Err_trn2(Idx) = cerror(ypred_trn2, curr_trn2_noise.y);
        Err_tst(Idx) = cerror(ypred_tst, curr_tst_noise.y);
        
        % --------- Build a stack of performance matrixes --------
        % Loop on the views
        is = 1;
        for s = RangeSize
            ird = 1;
            % Loop on sizes
            for v = ViewRange
                
                % Performance matrix TESTING data
                Iok = find( curr_tst_noise.view == v & curr_tst_noise.size == s );
                if ~isempty(Iok)                             
                    Perc_correct_tst(Idx,is,ird) = 1 - cerror(ypred_tst(Iok), curr_tst_noise.y(Iok));
                    N_tot_tst(Idx,is,ird) = length(Iok);
                else
                    Perc_correct_tst(Idx,is,ird) = NaN;
                    N_tot_tst(Idx,is,ird) = 0;
                end; %if
                % Performance matrix TRAINING data
                Iok = find( curr_trn2_noise.view == v & curr_trn2_noise.size == s );
                if ~isempty(Iok)                             
                    Perc_correct_trn2(Idx,is,ird) = 1 - cerror(ypred_trn2(Iok), curr_trn2_noise.y(Iok));
                    N_tot_trn2(Idx,is,ird) = length(Iok);
                else
                    Perc_correct_trn2(Idx,is,ird) = NaN;
                    N_tot_trn2(Idx,is,ird) = length(Iok);
                end; %if
                
                ird = ird+1;
            end; %for ird
            is = is+1;
        end; %for is
                                
        disp(' ');
        disp( ['sigma noise = ', num2str(sigma), '; Classification error on TRAINING data = ', num2str(Err_trn2(Idx)), ...
            ' and on TESTING data = ', num2str(Err_tst(Idx))]);       
        Idx = Idx+1;
    end; %for sigma
    
    figure;
    plot( sigma_range, (1-Err_trn2)*100, 'o-' );
    hold on;
    plot( sigma_range, (1-Err_tst)*100, 'sr-' );
    set(gca, 'ylim', [50 100]);
    xlabel('\sigma (Gaussian noise)');
    ylabel('% Correct)');
    title(['# training samples = ', num2str(curr_trn_noise.num_data), '; # testing samples = ', num2str(curr_tst_noise.num_data)]);
    title(['Performance on training data (b) and testing data (r); Nrep = ', num2str(Nrep)]);
    
    
    FlagSavePerformances = 1;
    if FlagSavePerformances
        save( [PathName,'PerfTrainTest_sigma_start', num2str(sigma_start), '_step', num2str(sigma_step), ...
            '_end', num2str(sigma_end), '_N', num2str(Nrep) ,'.mat'], ...
            'sigma_range', 'Err_trn2', 'Err_tst', 'Perc_correct_trn2', 'Perc_correct_tst', 'N_tot_trn2', 'N_tot_tst', 'Nrep', ...
            'curr_trn', 'curr_trn2', 'curr_tst');
    else
        disp( 'WARNING: the data structure WAS NOT SAVED! Set FlagSaveDataStruct to 1 to save it!' );
    end;

    
    
    
elseif strcmp(RunMode, 'plot perf matrix')
    
    load([PathName,Perf2load]);
    disp(['load ', PathName,Perf2load]);  
    
    Isigma = find( sigma_range == sigma2plot );
    if isempty(Isigma)
        disp('ERROR: the used-entered noise level (sigma) was not tested!');
        return;
    end;
    
    % ============ Performance as a function of sigma ============
    figure;
    plot( sigma_range, (1-Err_trn2)*100, 'o-' );
    hold on;
    plot( sigma_range, (1-Err_tst)*100, 'sr-' );
    set(gca, 'ylim', [50 100]);
    xlabel('\sigma (Gaussian noise)');
    ylabel('% Correct)');
    title(['Performance on training data (b) and testing data (r); Nrep = ', num2str(Nrep)]);
    
    
    

    % ============ Noise corrupted training stimuli ============
    figure;
    curr_trn_noise = curr_trn;
    curr_trn2_noise = curr_trn2;
    curr_tst_noise = curr_tst;

    curr_trn_noise.X = curr_trn_noise.X + random('norm', 0, sigma2plot, [curr_trn_noise.dim, curr_trn_noise.num_data]);
    curr_trn2_noise.X = curr_trn2_noise.X + random('norm', 0, sigma2plot, [curr_trn2_noise.dim, curr_trn2_noise.num_data]);
    curr_tst_noise.X = curr_tst_noise.X + random('norm', 0, sigma2plot, [curr_tst_noise.dim, curr_tst_noise.num_data]);

    for im = 1:28
        Img = reshape(curr_trn_noise.X(:,im), 80, 140); 
        Img = uint8(Img);
        subplot(4,7,im);
        imshow(Img);
        colormap(gray(256));
    end;


    
    
    % ========== Perfromance marix of TEST conditions ==============
    
    % Convert performance matrix to a colormap image
    im_Perc_correct = [];
    im_Perc_correct = uint8(Perc_correct_tst * 255);
    
    % Plot a 2d matrix with performances across size and rot in depth
    % NOTE: ird (column) -> X axis; is (row) -> Y axis, therefore size
    % varies on Y axis, while rotation in depth varies on X axis
    figure;
    perf = squeeze(im_Perc_correct(Isigma,:,:));
    image(perf);
    axis('square');
    set(gca, 'ytick', [1:N_size], 'yticklabel', num2str(RangeSize'),'xtick', [1:N_rot_dep], 'xticklabel', num2str(ViewRange'));
    xlabel('Rotation in Depth (\circ)');
    ylabel('Size (\circ)');
    % Set colormap
    ColMapChoice = 2;
    if ColMapChoice == 1
        % Build colormap red --> black --> green
        red_scale = [0:1/127:1]';
        green_scale = red_scale(end:-1:1);
        col_1=[zeros(128,1);red_scale];
        col_2 = [green_scale;zeros(128,1)];
        col_3 = [zeros(256,1)];
        perf_map = [col_1, col_2, col_3];
    elseif ColMapChoice == 2
        % Build colormap hot/gray
        hot_map = hot(128);
        bone_map = bone(128);
        bone_map = bone_map(end:-1:1,:);
        perf_map = [bone_map; hot_map];
    end;
    colormap(perf_map);
    cbar_axes = colorbar;
    tick_lab = [0:0.25:1] * 256;
    set(cbar_axes,'ytick', tick_lab);
    set(cbar_axes,'yticklabel', {'0'; '25'; '50'; '75'; '100' });


    % Write performance values in the matrix
    for is=1:N_size
        for ird=1:N_rot_dep
            % NOTE: ird (column) -> X axis; is (row) -> Y axis
            text( ird, is, num2str(round(Perc_correct_tst(Isigma,is,ird)*100)), 'horizontalalignment', 'center', 'color', [0.6 0.6 0.6] );
            text( ird+0.35, is-0.35, num2str(N_tot_tst(Isigma,is,ird)), 'horizontalalignment', 'center', 'color', [0.5 0.5 0.5], 'FontSize', 9);
        end; %for ir
    end; %for ip

    % Draw a box around transformations overtrained during staircase
    DX = 0.49;
    ird = floor(N_rot_dep/2)+1; 
    is = floor(N_size/2);
    % TRAINED SIZES (column)
    X_patch = [ird-DX, ird+DX, ird+DX, ird-DX];
    Y_patch = [1-DX, 1-DX, N_size+DX, N_size+DX];
    patch( X_patch, Y_patch, 'k', 'EdgeColor', 'k', 'FaceColor', 'none', 'LineStyle', '--', 'Linewidth', 1 );        
    % TRAINED 3D ORIENTATIONS (row)
    X_patch = [1-DX, N_rot_dep+DX, N_rot_dep+DX, 1-DX];
    Y_patch = [is-DX, is-DX, is+DX, is+DX];
    patch( X_patch, Y_patch, 'k', 'EdgeColor', 'k', 'FaceColor', 'none', 'LineStyle', '--', 'Linewidth', 1 );
    axis('square');


    
    % ========== Perfromance marix of TRAINING conditions ==============
    
    % Convert performance matrix to a colormap image
    im_Perc_correct = [];
    im_Perc_correct = uint8(Perc_correct_trn2 * 255);
    
    % Plot a 2d matrix with performances across size and rot in depth
    % NOTE: ird (column) -> X axis; is (row) -> Y axis, therefore size
    % varies on Y axis, while rotation in depth varies on X axis
    figure;
    perf = squeeze(im_Perc_correct(Isigma,:,:));
    image(perf);
    axis('square');
    set(gca, 'ytick', [1:N_size], 'yticklabel', num2str(RangeSize'),'xtick', [1:N_rot_dep], 'xticklabel', num2str(ViewRange'));
    xlabel('Rotation in Depth (\circ)');
    ylabel('Size (\circ)');
    % Set colormap
    colormap(perf_map);
    cbar_axes = colorbar;
    tick_lab = [0:0.25:1] * 256;
    set(cbar_axes,'ytick', tick_lab);
    set(cbar_axes,'yticklabel', {'0'; '25'; '50'; '75'; '100' });


    % Write performance values in the matrix
    for is=1:N_size
        for ird=1:N_rot_dep
            % NOTE: ird (column) -> X axis; is (row) -> Y axis
            text( ird, is, num2str(round(Perc_correct_trn2(Isigma,is,ird)*100)), 'horizontalalignment', 'center', 'color', [0.6 0.6 0.6] );
            text( ird+0.35, is-0.35, num2str(N_tot_trn2(Isigma,is,ird)), 'horizontalalignment', 'center', 'color', [0.5 0.5 0.5], 'FontSize', 9);
        end; %for ir
    end; %for ip

    % Draw a box around transformations overtrained during staircase
    DX = 0.49;
    ird = floor(N_rot_dep/2)+1; 
    is = floor(N_size/2);
    % TRAINED SIZES (column)
    X_patch = [ird-DX, ird+DX, ird+DX, ird-DX];
    Y_patch = [1-DX, 1-DX, N_size+DX, N_size+DX];
    patch( X_patch, Y_patch, 'k', 'EdgeColor', 'k', 'FaceColor', 'none', 'LineStyle', '--', 'Linewidth', 1 );        
    % TRAINED 3D ORIENTATIONS (row)
    X_patch = [1-DX, N_rot_dep+DX, N_rot_dep+DX, 1-DX];
    Y_patch = [is-DX, is-DX, is+DX, is+DX];
    patch( X_patch, Y_patch, 'k', 'EdgeColor', 'k', 'FaceColor', 'none', 'LineStyle', '--', 'Linewidth', 1 );
    axis('square');

    
end; %if strcmp















