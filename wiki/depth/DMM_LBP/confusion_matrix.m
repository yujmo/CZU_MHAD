function [confusion, accuracy, CR, FR] = confusion_matrix(class, c)
%
% class is the result of test data after classification
%          (1 x n)
%
% c is the number of testing samples (the same order as the label)
%          (1 x length(test_classes))
%

% confusion matrix
%   w1 w2 w3 . . . wn  (true class label)
% w1
% w2
% w3
% .
% .
% .
% wn
% (algorithm classified label)

class = class.';
c = c.';

n = length(class);
c_len = length(c);

if n ~= sum(c)
    disp('ERROR: wrong input!');
    return;
end

% confusion matrix
confusion = zeros(c_len, c_len);
a = 0;
for i = 1: c_len
    for j = (a + 1): (a + c(i))
        confusion(i, class(j)) = confusion(i, class(j)) + 1;
    end
    a = a + c(i);
end
confusion = confusion';

% Correct_classification_rate + False_alarm_rate + Overall_accuracy
CR = zeros(1, c_len);
FR = zeros(1, c_len);
for i = 1: c_len
  CR(i) = confusion(i, i)/sum(confusion(:, i));
  FR(i) = (sum(confusion(i,:)) - confusion(i, i))/sum(confusion(i, :));
end
accuracy = sum(diag(confusion))/sum(c);

