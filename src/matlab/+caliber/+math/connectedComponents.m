function ccs = connectedComponents( adjacency )
% connectedComponents: finds connected components given an adjacency matrix
% result is in the form {{node, node, node...}, {node, node, node...}, ...}
    n = size(adjacency, 1);
    
    prevconn = eye(n);
    conn = 1 * (adjacency + eye(n) > 0);
    while any(conn ~= prevconn)
       prevconn = conn;
       conn = 1 * (conn + conn*conn > 0);
    end
    
    ccs = {};
    seen = zeros(n, 1);
    for root = 1:n
        if seen(root)
            continue
        end
        
        cc = {};
        for node = root:n
            if conn(root, node)
                seen(node) = 1;
                cc{length(cc) + 1} = node;
            end
        end
        
        ccs{length(ccs) + 1} = cc;
    end
end