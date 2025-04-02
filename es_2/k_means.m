data = [ 3 4
        2 8
        1 7
        4 8
        3 6.5
        4.8 8
        4.0 6.7
        3.7 5.1
        3.5 7.8
        4 5.7
        1.8 6.5
        2.4 6.2
        2.6 7.2
        6 8
        5 7
        7.5 7
        8 4
        6.5 7.5
        ];

l = size(data,1); % number of patterns
k=3;

%CENTROIDI
% InitialCentroids=[1,1;2,2;3,3];

InitialCentroids=[3,4;2,5;4,1];
[x,cluster,v] = kmeans(data,k,InitialCentroids)


%% multistart approch 
% N=10;
% best_x=[];
% best_cluster=[];
% best_v=Inf;
% best_InitialCentroids=[];
% 
% for iter = 1:N
%     InitialCentroids=data(randperm(l,k),:);
%     [x,cluster,v]=kmeans(data,k,InitialCentroids);
% 
%     if v<best_v
%         best_InitialCentroids=InitialCentroids;
%         best_v=v;
%         best_x=x;
%         best_cluster=cluster;
%     end
% end
% 
% best_InitialCentroids
% best_x
% best_v
% best_cluster


function [x,cluster,v] = kmeans(data,k,InitialCentroids)
    l = size(data,1); 
    x = InitialCentroids;

    cluster = zeros(l,1); 
    for i = 1 : l
        d = inf;
        for j = 1 : k
            if norm(data(i,:)-x(j,:)) < d
                d = norm(data(i,:)-x(j,:));
                cluster(i) = j;
            end
        end
    end
    vold = 0; % compute the objective function value
    for i = 1 : l
        vold = vold + norm(data(i,:)-x(cluster(i),:))^2 ;
    end
    
    while true
        for j = 1 : k 
            ind = find(cluster == j);
            if isempty(ind)==0
                x(j,:) = mean(data(ind,:),1);
            end
        end
        
        for i = 1 : l % update clusters
            d = inf;
            for j = 1 : k
                if norm(data(i,:)-x(j,:)) < d
                    d = norm(data(i,:)-x(j,:));
                    cluster(i) = j;
                end
            end
        end
        v = 0; % update objective function
        for i = 1 : l
            v = v + norm(data(i,:)-x(cluster(i),:))^2 ;
        end
        if vold - v < 1e-5
            break
        else
            vold = v;
        end
    end
end

