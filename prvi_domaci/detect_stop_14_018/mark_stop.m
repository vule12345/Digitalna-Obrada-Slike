function mark_stop(I, map)

    [ys, xs] = find(map);

    y_center_box = mean(ys);
    x_center_box = mean(xs);

    height_box = 5*std(ys);
    width_box = 5*std(xs);
    
    iptsetpref('ImshowBorder','tight');

    figure; imshow(I); hold on;

    rectangle('Position', [round(x_center_box - width_box/2) round(y_center_box - height_box/2) width_box height_box], 'LineWidth', 3, 'EdgeColor', 'g' );
    
end