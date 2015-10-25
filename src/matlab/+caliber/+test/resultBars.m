close all;

uselog = 0;
useintonly = 1;

opt = [9.448238e-002 1.728306e+000 3.813352e-001 1.859486e-001 1.437088e-001 7.649260e-002 6.784958e-002];
intonly = [0.0893 0.7588 0.1573 0.0522 0.1350 0.0496 0.0705 ]; % 0.0710 ladybug with overlap
loocv = [0.141 1.927068e+000 4.911 2.288134e-001 2.622 1.546 8.115622e-002 ]; % 0.496 ladybug with overlap (bad distortion?)
% separate camera joints for gantry: 7.605729e-001, 1.927068e+000
% seaprate camera joints for two-arm: 5.192682e-002, 2.288134e-001
optsyn = [0.098 0.099 0.098 0.099 0.099 0.101 0.097];
loocvsyn = [0.127 0.100 0.982 0.099 0.634 0.333 0.107];

normOptSyn = [9.025295e-002 7.509325e-001    1.504833e-001  5.260194e-002 1.317553e-001 4.838171e-002 6.9e-2 ]; % 1.573302e+001 ladybug with overlap
normLoocvSyn = [1.172854e-001  7.605729e-001 2.035121e+000  5.192682e-002 1.053518e+000 1.623621e-001 7.965424e-002 ]; % 7.662483e-002 ladybug with overlap
colors = [1 0.5 0.5; 0.5 0.5 1; 0.5 1 0.5];

experimentNames = {'Stereo', 'Gantry', 'Tablet', 'Two-arm', 'Facing', 'Ad-hoc', 'Ladybug'};
fontSize = 24;
if useintonly
    ratio = loocv ./ intonly;
else
    ratio = loocv ./ opt;
end
ratiosyn = loocvsyn ./ optsyn;

%% absolute pixel error plot
figure;

%bar([intonly; normLoocvSyn - intonly; loocv - normLoocvSyn]', 'stacked');
bar([intonly; normOptSyn; opt; normLoocvSyn; loocv]', 1);
ylabel('RMS pixels');
legend('Zhang residual', 'Synthetic solution', 'Experimental solution', 'Synthetic LOOCV', 'Experimental LOOCV');
set(gca,'XTickLabel',experimentNames);
set(gca,'FontSize',fontSize);
set(get(gca,'YLabel'),'FontSize',fontSize);
colormap(caliber.plot.hcy2rgb([-144 * (0:4)', ones(5, 1), ones(5, 1) * 0.75]));

figure;

%bar([intonly; normLoocvSyn - intonly; loocv - normLoocvSyn]', 'stacked');
bar([intonly ./ intonly; normOptSyn ./ intonly; opt ./ intonly; normLoocvSyn ./ intonly; loocv ./ intonly]' , 1);
ylabel('RMS error / Zhang residual');
legend('Zhang/Zhang = 1', 'Synthetic solution', 'Experimental solution', 'Synthetic LOOCV/Zhang', 'Experimental LOOCV/Zhang', 'Location', 'NorthWest');
set(gca,'XTickLabel',experimentNames);
set(gca,'FontSize',fontSize);
set(get(gca,'YLabel'),'FontSize',fontSize);
colormap(caliber.plot.hcy2rgb([-144 * (0:4)', ones(5, 1), ones(5, 1) * 0.75]));

%% old plot

% figure;
% 
% bar([opt; loocv]');
% ylabel('Pixels');
% legend('RMS optimization residual', 'RMS LOOCV prediction error');
% set(gca,'XTickLabel',experimentNames);
% set(gca,'FontSize',fontSize);
% set(get(gca,'YLabel'),'FontSize',fontSize);
% 
% figure;
% if uselog
%     bar(10*log10([ratio; ratiosyn])');
%     ylabel('dB(RMS LOOCV prediction error / RMS optimization residual)');
% else
%     bar([ratio; ratiosyn]');
%     ylabel('RMS pred. error / RMS opt. residual');
% end
% set(gca,'XTickLabel',experimentNames);
% set(gca,'FontSize',fontSize);
% set(get(gca,'YLabel'),'FontSize',fontSize);
% 
% legend('Experimental', 'Synthetic');

%% timing plot
figure;

initTime = [0.58 1.096017 0.38 3.324151 0.57 0.64 1.1];
optTime = [2 3.970673 4.7 4.308837 1.3 4.9 7.2];

bar([initTime; optTime]', 'stack');
set(gca,'XTickLabel',experimentNames);
set(gca,'FontSize',fontSize);
set(get(gca,'YLabel'),'FontSize',fontSize);
legend('Kinematic estimation', 'Optimization', 'Location', 'NorthWest');
ylabel('Time (s)');
colormap(colors(1:2, :));
