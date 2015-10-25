function scatterChar( X, Y, markerText, c )
%SCATTERCHAR
    if nargin < 4
        c = [0 0 0];
    end
    
    select = ~isnan(X) & ~isnan(Y) & ~isinf(X) & ~isinf(Y);
    if nnz(select) < 3
        return;
    end
    X = X(select);
    Y = Y(select);
    
    scatter(X, Y, 4, c, '.');
    
    k = convhull(X, Y);
    plot(X(k), Y(k), 'Color', c);
    text(mean(X), mean(Y), markerText, 'HorizontalAlignment', 'center', 'FontName', 'FixedWidth', 'EdgeColor', [0 0 0], 'Color', c);
end
