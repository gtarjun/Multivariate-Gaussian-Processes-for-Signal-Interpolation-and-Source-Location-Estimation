function [positions_x_nu,positions_x_u] = sensor_locations(d,deviation,L)

        positions_x_nu = abs(d*((0:L-1)+(rand(1,L)-0.6)*deviation));    %Non-uniform distribution in X
        positions_x_nu = sort(positions_x_nu);
        positions_x_nu([1,L])=d*[0 L-1];% Sorted non-uniform position
        positions_x_u = (d*[0:length(positions_x_nu)-1]);% Uniform distribution in X
        
end 