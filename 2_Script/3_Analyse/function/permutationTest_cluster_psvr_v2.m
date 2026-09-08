function [cluster_above_chance_5,cluster_above_chance_1] = permutationTest_cluster_psvr_v2(M)

    rng(abs(round(M(1,1,1)*M(1,2,1))+1))

    timeDim = size(M,1);

    % M_shuffle = zeros(timeDim,timeDim,1000);
    % numSubs = 1:size(M,3);

    % PlusMin = [-1 1];
    

    % parfor perm=1:1000    
    % 
    %     matrixPerm = zeros(timeDim,timeDim);
    % 
    %     for aa=1:timeDim
    %         for bb=1:timeDim
    %             matrixPerm(aa,bb) = M(aa,bb,randsample(numSubs,1))*randsample(PlusMin,1);
    %         end
    %     end
    % 
    % 
    %     M_shuffle(:,:,perm) = matrixPerm;
    % end


    % M: 250x250x20  (real subjects)
    nFake = 1000;
    nSub  = size(M,3);     % 20
    [n1,n2,~] = size(M);   % 250,250
    
    % 1) 为每个(i,j,k)生成一个被试索引(1..20)
    idx = randi(nSub, [n1, n2, nFake]);   % 250x250x1000
    
    % 2) 把A reshape成 (n1*n2) x nSub，方便线性索引
    M2 = reshape(M, [], nSub);            % 62500 x 20
    
    % 3) 构造线性索引，从A2里一次性取出所有点
    rows = repmat((1:n1*n2).', nFake, 1); % 62500*1000 x 1
    lin  = sub2ind([n1*n2, nSub], rows, idx(:));
    
    % 4) 取值并reshape回 250x250x1000
    M_shuffle = reshape(M2(lin), n1, n2, nFake);

    % 5) 生成随机 ±1 的符号矩阵
    signMat = sign(randn(n1, n2, nFake)); % 250*250*1000

    % 6) 随机翻转符号
    M_shuffle = M_shuffle .* signMat;


    % 用来验证的代码
    % Mij = squeeze(M(10,20,:));     % 这 20 个真实被试在该点的值
    % b   = M_shuffle(10,20,1:50);           % 随便看 50 个假被试在该点的值
    % 
    % all(ismember(b(:), Mij))

    M_shuffle = single(M_shuffle);

    [clusters_sup, p_values_sup, ~, ~] = permutest_v2(M, M_shuffle, 0, 0.05, 1000, 0);

    cluster_above_chance_5 = zeros(timeDim,timeDim);
    for c=1:length(clusters_sup)
        if p_values_sup(c)<0.05
            cluster_above_chance_5(clusters_sup{c})=1;
        end
    end
    cluster_above_chance_5 = reshape(logical(cluster_above_chance_5),[timeDim,timeDim]);


    cluster_above_chance_1 = zeros(timeDim,timeDim);
    for c=1:length(clusters_sup)
        if p_values_sup(c)<0.01
            cluster_above_chance_1(clusters_sup{c})=1;
        end
    end
    cluster_above_chance_1 = reshape(logical(cluster_above_chance_1),[timeDim,timeDim]);
    
end