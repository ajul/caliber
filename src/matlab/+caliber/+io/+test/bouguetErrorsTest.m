[ imagePoints_error, f_error, pp_error, kc_error, r_error, t_error ] = caliber.io.bouguetErrors( 'caliber_data/stereo_display_00/c_results.mat', 1:5 );

ipenorm = 0;
for i = 1:5
    ipenorm = ipenorm + norm(imagePoints_error{i}, 'fro');
end
ipenorm
f_error
pp_error
kc_error
for i = 1:5
    r_error{i}
    t_error{i}
end

[ imagePoints_error, f_error, pp_error, kc_error, r_error, t_error ] = caliber.io.bouguetErrors( 'caliber_data/stereo_display_00/m_results.mat', 1:5 );

ipenorm = 0;
for i = 1:5
    ipenorm = ipenorm + norm(imagePoints_error{i}, 'fro');
end
ipenorm
f_error
pp_error
kc_error
for i = 1:5
    r_error{i}
    t_error{i}
end