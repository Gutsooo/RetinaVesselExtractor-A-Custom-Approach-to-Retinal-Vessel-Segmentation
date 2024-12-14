function labeled_image = MY_BWlabel(BW)

    [rows, cols] = size(BW);
    
    visited_pixels = false(rows, cols);
    visited_pixels(BW == 0) = true;
    
    labeled_image = zeros(rows, cols);
    label = 1;
    
    
    for r = 1:rows    % for number of rows of the image
        for c = 1:cols    % for number of columns of the image
            if BW(r,c) == 1 && visited_pixels(r, c) == false
                stack = [r c];
                while ~isempty(stack)
                    location = stack(1, :);
                    x = location(1);
                    y = location(2);
                    stack(1,:) = [];
    
                    if visited_pixels(x, y) == false
                        visited_pixels(x, y) = true;
                        labeled_image(x, y) = label;
    
                        neighbors_x = [];
                        neighbors_y = [];
                        for ii = (x - 1):(x + 1)
                            for jj = (y - 1):(y + 1)
                                neighbors_x = [neighbors_x; ii];
                                neighbors_y = [neighbors_y; jj];
                            end
                        end
    
                        out_of_range = neighbors_x < 1 | neighbors_x > rows | neighbors_y < 1 | neighbors_y > cols;
                        neighbors_x(out_of_range) = [];
                        neighbors_y(out_of_range) = [];
    
                        is_visited = visited_pixels(sub2ind([rows cols], neighbors_x, neighbors_y));
                        neighbors_x(is_visited) = [];
                        neighbors_y(is_visited) = [];
    
                        is_1 = BW(sub2ind([rows cols], neighbors_x, neighbors_y));
                        neighbors_x(~is_1) = [];
                        neighbors_y(~is_1) = [];
    
                        stack = [stack; [neighbors_x neighbors_y]];
                    end
        
                end
                    label = label + 1;
            end
            
        end
    end
end