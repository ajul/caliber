function plotTree( obj )
%PLOTTREE Generates a plot with a pictoral representation of the tree.
    root = obj.root;
    n = numel(obj.nodeList);
    
    figure;
    
    hold on;
    set(gca,'YDir','reverse');
    
    allDimensions = zeros(n, 2);
    allDimensions = computePlotDimensions(root, allDimensions);

    allPositions = zeros(n, 2);
    allPositions = drawSubtree(root, allDimensions, allPositions);
    
    obsEdges = zeros(n);
    for i = 1:numel(obj.observations)
        obs = obj.observations{i};
        Qs = obs.estimatedTransformations();
        for j = 1:size(Qs, 1)
            obsEdges(Qs{j, 1}.index, Qs{j, 2}.index) = obsEdges(Qs{j, 1}.index, Qs{j, 2}.index) + 1;
        end
    end
    
    [cameraNodeIndices, pointNodeIndices, count] = find(obsEdges);
    for i = 1:numel(count)
        cameraPosition = allPositions(cameraNodeIndices(i), :);
        pointPosition = allPositions(pointNodeIndices(i), :);
        midpoint = (cameraPosition + pointPosition) / 2;
        line([cameraPosition(1) pointPosition(1)], [cameraPosition(2) pointPosition(2)], ...
            'Color', [0.875 0.875 0.875], 'LineStyle', '--');
        s = sprintf('%u', count(i));
        text(midpoint(1), midpoint(2), s, ...
            'BackgroundColor', [1 1 1], ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
            'FontSize', 8, 'Interpreter', 'none');
    end
        
    % set dimensions
    halfwidth = allDimensions(root.index, 1) / 2;
    xlim([-halfwidth, halfwidth]);
    ylim([-0.5, allDimensions(root.index, 2) - 0.5]);
    
    set(gca,'XTick',[]);
    set(gca,'YTick',0:allDimensions(root.index, 2));
    
    hold off;
end

function [ allDimensions ] = computePlotDimensions(node, allDimensions)
    n = length(node.children);
    if n == 0
        d = [1 1];
    else
        w = 0;
        h = 0;
        for i = 1:n
            child = node.children{i};
            allDimensions = computePlotDimensions(child, allDimensions);
            childDimensions = allDimensions(child.index, :);
            w = w + childDimensions(1);
            if childDimensions(2) > h
                h = childDimensions(2);
            end
        end
        d = [w h+1];
    end
    allDimensions(node.index, :) = d;
end

function [ allPositions ] = drawSubtree( node, allDimensions, allPositions )
%DRAWSUBTREE Summary of this function goes here
%   Detailed explanation goes here
    position = allPositions(node.index, :);
    scatter3(position(1), position(2), 36, 'k', 'o');
    text(position(1), position(2), node.name, 'VerticalAlignment', 'Bottom', 'FontSize', 8, 'Interpreter', 'none');
    
    leftOffset = -allDimensions(node.index, 1) / 2;
    for i = 1:numel(node.children)
        child = node.children{i};
        childWidth = allDimensions(child.index, 1);
        childOffset = leftOffset + childWidth / 2;
        childPosition = position + [childOffset 1];
        allPositions(child.index, :) = childPosition;
        allPositions = drawSubtree(child, allDimensions, allPositions);
        
        hasKnown = 0;
        hasUnknown = 0;
        for j = 1:child.numberOfStates()
            if child.isKnown(j)
                hasKnown = 1;
            else
                hasUnknown = 1;
            end
        end
        
        if hasUnknown
            if hasKnown
                lineStyle = '-.';
            else
                lineStyle = ':';
            end
        else
            lineStyle = '-';
        end
        
        line([position(1) childPosition(1)], [position(2) childPosition(2)], 'Color', 'k', 'LineStyle', lineStyle);
        
        midpoint = (position + childPosition) / 2;
        s = sprintf('%u', child.numberOfStates());
        text(midpoint(1), midpoint(2), s, ...
            'BackgroundColor', [1 1 1], ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
            'FontSize', 8, 'Interpreter', 'none');
        
        leftOffset = leftOffset + childWidth;
    end
end