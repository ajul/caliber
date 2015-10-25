classdef Label < handle
    %LABEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected)
        graphInit;
        
        name;   % name of this label
        index;  % index of this label
        
        edges;
        
        M;
    end
    
    methods
        function obj = Label(graphInit, name, index)
            obj.graphInit = graphInit;
            obj.name = name;
            obj.index = index;
            
            obj.edges = logical(sparse(graphInit.n, graphInit.n));
            
            obj.M = [];
        end
        
        function addEdge(obj, nodeFromIndex, nodeToIndex)
            obj.edges(nodeFromIndex, nodeToIndex) = 1;
        end
        
        function result = isSolved(obj)
            result = ~isempty(obj.M);
        end
        
        function solvedM = computeMDirect(obj)
            if isempty(obj.M)
                Ms = obj.graphInit.getCellMs(obj.edges);
                Ms = cell2mat(Ms');
                Ms = reshape(Ms, 16, []);
                solvedM = sum(Ms, 2);
                solvedM = reshape(solvedM, 4, 4);
                if ~solvedM(4, 4)
                    solvedM = [];
                end
            else
                solvedM = [];
            end
        end
        
        function [solvedM, dof] = computeMAX_XB(obj)
            if ~isempty(obj.M) 
                solvedM = obj.M;
                dof = NaN;
                return;
            end
            
            [Xfrom, Xto] = find(obj.edges);
            
            n = numel(Xfrom);
            nn = n * (n - 1) / 2;
            
            As = cell(1, nn);
            Bs = cell(1, nn);
            nonEmpty = true(1, nn);
            
            idx = 1;
            
            for i = 1:(n-1)
                from1 = Xfrom(i);
                to1 = Xto(i);
                for j = (i+1):n
                    from2 = Xfrom(j);
                    to2 = Xto(j);
                    
                    A = obj.graphInit.getCellM(from1, from2);
                    B = obj.graphInit.getCellM(to1, to2);
                    Ah = A(4, 4);
                    Bh = B(4, 4);
                    if ~Ah || ~Bh
                        A = [];
                        B = [];
                        nonEmpty(idx) = 0;
                    else
                        A = A / Ah;
                        B = B / Bh;
                    end
                    As{idx} = A;
                    Bs{idx} = B;
                    idx = idx + 1;
                end
            end
            
            As = As(nonEmpty);
            Bs = Bs(nonEmpty);
            
            [solvedM, dof] = caliber.math.ax_xb.solve(As, Bs, obj.graphInit.tolR, obj.graphInit.tolT);
            
        end
        
        function setM(obj, M)
            obj.M = M;
            obj.graphInit.setCellMsToSingle(obj.edges, M);
        end
    end
end

