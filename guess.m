%GA
%guess 5-digit number
%isid92654

NUM_OF_DIGITS = 5;
pop_size = 8;

num_min = 0;
num_max = 9;

%set random number as searched number
searched_number = set_searched_vec(NUM_OF_DIGITS, num_max, num_min);

score_matrix = zeros(1, pop_size);
population_matrix = zeros(pop_size, NUM_OF_DIGITS);

%create population
generation_matrix = set_population(NUM_OF_DIGITS, num_max, num_min, pop_size);

function searched = set_searched_vec(digits, smax, smin)
%returns random number which will be searched for
    searched = zeros(1,digits);
    
    for i = 1:digits
        searched(i) = get_random_digit(smax, smin);
    end
    
    while searched(1) == 0
        searched(1) = get_random_digit(smax, smin);
    end
end

function pop_matrix = set_population(digits, smax, smin, pop_size)
%returns random population in matrix
    pop_matrix = zeros(pop_size, digits);
    
    for individ = 1:pop_size
        for digit = 1:digits
            pop_matrix(individ, digit) = get_random_digit(smax, smin);
            
            if digit == 1
                while pop_matrix(individ, digit) == 0
                    pop_matrix(individ, digit) = get_random_digit(smax, smin);
                end
            end
        end
    end    
    
end

function digit = get_random_digit(smax, smin)
%returns random digit from interval <0,9>
    digit = round(rand() * (smax - smin + 1) + smin);
end