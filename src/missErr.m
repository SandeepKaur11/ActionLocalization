function e = missErr()
load('struct_TP_FP');
count = 0;
miss = 0;
for s = 1:3
    class_size = size(struct_TP_FP.class(s).seq,2);   
    for k = 1:class_size
        % Positive = overlap with ground true should be 1 and the predicted
        % class should be the same class as we look up
        temporary_index_position = ((struct_TP_FP.class(s).seq(k).array(1,:)==1) & ...
            (struct_TP_FP.class(s).seq(k).array(3,:)==s));
        temporary_class = struct_TP_FP.class(s).seq(k).array(3,temporary_index_position);
        % noting found
        if cumsum(temporary_index_position) == 0
            miss = miss + 1;
        % found, but miss the class
        elseif temporary_class(1) ~= s 
            miss = miss + 1;
        end
        count = count + 1;
    end
end
e = miss/count;
fprintf('Missclassification rate = %f\n', e);