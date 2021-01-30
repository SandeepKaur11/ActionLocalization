function hough_array = houghvoting(patches,position,spa_scale,tem_scale,frame_num,flag_mat,struct_cb)
% hough_array           : is a matrix with 7 rows, each column indicating the
%                       : predicted(votes) spatial location, predicted (voted) start and end frames,
%                       : the votes, bounding box values(scale compensated). Example: Let a descriptor matched with
%                       : the codeword (with one offset) cast votes at the spatial location [x,y],
%                       : temporal location [s,e] (predictions for start and end frames), bounding box values [b1 b2] (stored during training)
%                       : with value(weight) 'v', then corresponding column in the
%                       : matrix hough_array will be [x y s e v b1 b2]'.
% patches               : i/p descriptors
% position              : spatial location of the detected STIP                   
% spa_scale             : spatial scale                      
% tem_scale             : temporal scale
% frame_num             : frame number at which STIP was detected
% flag_mat              : refer to ism_test_voting.m
  
%-----------------------------------------------------------------------------------------------------
% Write your code here to compute the matrix hough_array
%-----------------------------------------------------------------------------------------------------
  
cob_sz = size(flag_mat, 1);
[th_x, th_y, th_s, th_e, v, b1, b2] = deal([]);
for i=1:cob_sz
    is_act_cw = sum(flag_mat(i,:));
    if is_act_cw ~= 0
        act_cw_s = position(:, flag_mat(i,:));
        act_cw_t = frame_num(:, flag_mat(i,:));
        edge_num = struct_cb.offset(i).tot_cnt;
        vs = [];
        for l=1:edge_num
            th_x = [th_x act_cw_s(1,:) - spa_scale(1, flag_mat(i,:))  * struct_cb.offset(i).spa_offset(1, l)];
            th_y = [th_y act_cw_s(2,:) - spa_scale(1, flag_mat(i,:))  * struct_cb.offset(i).spa_offset(2, l)];       
            th_s = [th_s act_cw_t - tem_scale(1, flag_mat(i,:))  * struct_cb.offset(i).st_end_offset(1, l)];
            th_e = [th_e act_cw_t - tem_scale(1, flag_mat(i,:))  * struct_cb.offset(i).st_end_offset(2, l)];
            vs = [vs repmat(1/(edge_num), is_act_cw, 1)'];
            b1 = [b1 struct_cb.offset(i).hei_wid_bb(1, l) * spa_scale(1, flag_mat(i,:)) ];
            b2 = [b2 struct_cb.offset(i).hei_wid_bb(2, l) * spa_scale(1, flag_mat(i,:)) ];
        
        end
        v = [v vs];
    end
end
hough_array = [th_x; th_y; th_s; th_e; v; b1; b2];
