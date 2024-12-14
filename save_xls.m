function save_xls(path, orginal_image, bw_image)

row = {'Cell number', 'Area', 'Average brightness'};
xlswrite(path, row);

label_image = MY_BWlabel(bw_image);
for i = 1:max(label_image(:))
    cell_i = (label_image == i);

    S = sum(cell_i(:));
    AB = (sum(sum(orginal_image .* cell_i)) / S) * 255;

    row = {['Cell_' num2str(i)], S, AB};
    xlswrite(path, row, 1, ['A' num2str(i + 1)]);
end

end