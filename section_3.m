%% ====================== Prepare New Test Set ======================
load('mnist.mat');
num_images = test.count;
new_test_images = shiftdim(test.images, 2);
A_new_test = reshape(new_test_images,num_images,28*28);
A_new_test = [A_new_test, ones(num_images,1)];
true_labels = test.labels;

%% ============================ Predict ==============================
UNCLASSIFIED = -1;
pred = UNCLASSIFIED * ones(num_images, 1);

% predictions:
Xs = [];
for i = 0:9
    Xs = [Xs,[DigitRecognition(i)]];
end
for i = 1:num_images
    pred(i) = getDigit(A_new_test(i,:),Xs);
end

%% =========================== Evaluate ==============================
acc = mean(pred == true_labels)*100;
disp(['Accuracy=',num2str(acc),'% (',num2str((1-acc/100)*num_images),' wrong examples)']);

%% ================= Show the Problematric Images ====================
error = find(pred~=true_labels); 
for k=1:1:5
    figure(2);
    imagesc(reshape(A_new_test(error(k),1:28^2),[28,28]));
    colormap(gray(256))
    axis image; axis off; 
    title(['problematic digit number ',num2str(k),' digit:',num2str(pred(error(k),:))]); 
    pause;  
end


%% =========================== Function ==============================
function digit = getDigit(vector,Xs)
    results = zeros(10,1);
    for d = 1:10
        results(d) = vector * Xs(:,d);
    end
    [maxVal, digit] = max(results);
    occurences = sum(maxVal == results);
    if occurences > 1
        disp("multiple options for the digit");
    end
    digit = digit - 1;
end



