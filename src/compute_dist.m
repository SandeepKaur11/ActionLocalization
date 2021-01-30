function D = compute_dist(X,B)
nframe=size(X,1);
nbase=size(B,1);
XX = sum(X.*X, 2);
BB = sum(B.*B, 2);
D  = repmat(XX, 1, nbase)-2*X*B'+repmat(BB', nframe, 1);
D = D';