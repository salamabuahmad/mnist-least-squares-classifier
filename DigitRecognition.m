function x = DigitRecognition(digitd)
%% ======================= Parameters ===========================
    N = 4000;
    digits = [0,1,2,3,4,5,6,7,8,9];
    digits(digits == digitd) = [];
%%  ==================== Load MNIST dataset ======================
    load('mnist.mat');
% ----------------------------------------------------------------
    imagesPerDigit = training.images(:,:,training.labels == digitd);
    imagesPerDigits = training.images(:,:,ismember(training.labels, digits));
    
    
    %% ======================= Create A, b ============================
    A_all = zeros(2*N,28^2);
    b_all = zeros(2*N,1);
    for i=1:N
        A_all(2*i-1,:) = reshape(imagesPerDigit(:,:,i),1,28*28);
        A_all(2*i,:)   = reshape(imagesPerDigits(:,:,i),1,28*28);
        b_all(2*i-1)   = +1;
        b_all(2*i)     = -1; 
    end
    A_all = [A_all, ones(2*N,1)];
    
    %% ========================= Solve LS ==============================
    A_train = A_all(1:N,:); 
    b_train = b_all(1:N); 
    
    x=pinv(A_train)*b_train;
    %% ===================== Check Performance ===========================
    
    A_test = A_all(N+1:2*N,:);
    b_test = b_all(N+1:2*N); 

    %----------------------------------------------------------------------
    disp(['performance for digit',num2str(digitd)]);
    predC = sign(A_train*x); 
    trueC = b_train; 
    disp('Train Error:'); 
    acc=mean(predC == trueC)*100;
    disp(['Accuracy=',num2str(acc),'% (',num2str((1-acc/100)*N),' wrong examples)']); 
    
    predC = sign(A_test*x); 
    trueC = b_test; 
    disp('Test Error:'); 
    acc=mean(predC == trueC)*100;
    disp(['Accuracy=',num2str(acc),'% (',num2str((1-acc/100)*N),' wrong examples)']); 
    
    %% ================= Show the Problematric Images ====================
    
    error = find(predC~=trueC); 
    figure(2);
    imagesc(reshape(A_test(error(1),1:28^2),[28,28]));
    colormap(gray(256))
    axis image; axis off; 
    title(['failed picture for the digit ',num2str(digitd),' :',num2str(A_test(error(1),:)*x)]); 
    pause;
end