function drawFrame(frameM, scale, label)
    t = frameM(1:3, 4);

    frameColors = {'r', 'g', 'b'};
    for i = 1:3
        r = frameM(1:3, i) * scale;
        line(t(1) + [0 r(1)], t(2) + [0 r(2)], t(3) + [0 r(3)], 'Color', frameColors{i});
    end

    scatter3(t(1), t(2), t(3), 36, 'k', 'o');
    if nargin >= 3
        text(t(1), t(2), t(3), label, 'VerticalAlignment', 'Bottom', 'FontSize', 8, 'Interpreter', 'none');
    end
end
