function printCell( c )
%PRINTCELL Nice formatting for cell table output.
    n = length(c);
    s1 = c{1};
    colnames = fieldnames(s1);
    m = length(colnames);
    colwidths = zeros(m, 1);
    for j = 1:m
        colname = colnames{j};
        v = s1.(colname);
        switch(class(v))
            case 'char'
                colwidth = length(colname);
                for i = 1:n
                    colwidth = max(colwidth, length(c{i}.(colname)));
                end
            case 'double'
                colwidth = max(12, length(colname));
            otherwise
                colwidth = max(4, length(colname));
        end
        fprintf(1, '%*s  ', colwidth, colname);
        colwidths(j) = colwidth;
    end
    fprintf('\n');
    for j = 1:m
        colwidth = colwidths(j);
        for k = 1:colwidth
            fprintf(1, '-');
        end
        fprintf(1, '--');
    end
    fprintf('\n');

    for i = 1:n
        s = c{i};
        for j = 1:m
            colname = colnames{j};
            v = s.(colname);
            colwidth = colwidths(j);
            switch(class(v))
            case 'char'
                fprintf(1, '%*s  ', colwidth, v);
            case 'double'
                fprintf(1, '%*f  ', colwidth, v);
            otherwise
                fprintf(1, '%*d  ', colwidth, v);
            end
        end
        fprintf('\n');
    end

end

