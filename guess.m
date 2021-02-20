%GA
%guess 5-digit number
%isid92654

%generate random numbers <0,9> using these variables 
digit_min = 0;
digit_max = 8;    %+1
num_of_digits = 5;  %select size of numbers

%genetic algorithm variables
pop_size = 8; %size of population
num_of_best_ones = 2; %take X best numbers into next generations

%set random number as searched number
searched_number = set_searched_vec(num_of_digits, digit_max, digit_min);

%create population
population_matrix = set_population(num_of_digits, digit_max, digit_min, pop_size);

%evaluate
score_vector = evaluation(population_matrix, searched_number, num_of_digits, pop_size);

%get positions of best
best_pos_vec = get_best_positions(score_vector, num_of_best_ones);

%create new generation
new_generation = evolve_new_generation(population_matrix, best_pos_vec, num_of_best_ones, num_of_digits);


function new_gen_matrix = evolve_new_generation(population, best_pos, num_of_best_ones, digits)
    new_gen_matrix = zeros(num_of_best_ones, digits);
    
    %new_gen_matrix = get_individual(population, digits, best_pos(1));
    
    for i=1:num_of_best_ones
        new_gen_matrix(i,:) = get_individual(population, digits, best_pos(i));
    end
end

function individ = get_individual(population, digits, position)
    individ = zeros(1,digits);
    for digit = 1:digits
        individ(digit) = population(position,digit);
    end
end

function best_ones_pos_vec = get_best_positions(score_vector, num_of_best_ones)
    if sum(score_vector) == 0
        %return 2 random
    end
    
    best_ones_pos_vec = [];
    
    for i=1:num_of_best_ones
        [m,max_index] = max(score_vector);
        best_ones_pos_vec(i) = max_index;
        score_vector(max_index) = 0; %after saving the position, change score to 0
    end
end

function score_vector = evaluation(generation, searched, digits, pop_size)
%calls function evaluate on each individual in current generation
%scores are returned as vector
    score_vector = zeros(1, pop_size);
    
    for individual = 1:pop_size
        score_vector(individual) = evaluate(generation(individual,:), searched, digits);
    end
end

function score = evaluate(individual, searched, digits)
%if digits match, give 1 score point
    score = 0;
    
    for gene = 1:digits
        if individual(gene) == searched(gene)
            score = score + 1;
        end
    end
end

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
        for gene = 1:digits
            pop_matrix(individ, gene) = get_random_digit(smax, smin);
            
            %if we set the first digit for current individual
            if gene == 1
                %get new random number if the current equals to zero
                while pop_matrix(individ, gene) == 0
                    pop_matrix(individ, gene) = get_random_digit(smax, smin);
                end
            end
        end
    end
end

function digit = get_random_digit(smax, smin)
%returns random digit from interval <0,9>
    digit = round(rand() * (smax - smin + 1) + smin);
end