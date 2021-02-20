%GA
%guess 5-digit number
%isid92654

%generate random digits <0,9> using these variables 
digit_min = 0;
digit_max = 8;    %+1
num_of_digits = 5;  %select size of numbers

%genetic algorithm variables
pop_size = 8; %size of population
num_of_best_ones = 2; %take X best numbers into next generations

%set random number as searched number
searched_number = set_searched_vec(digit_max, digit_min, num_of_digits);

%create population
population_matrix = set_population(digit_max, digit_min, num_of_digits, pop_size);

%evaluate
score_vector = evaluation(num_of_digits, pop_size, searched_number, population_matrix);

%get positions of best
best_pos_vec = get_best_positions(num_of_best_ones, score_vector);

%create new generation
new_generation = evolve_new_generation(num_of_digits, num_of_best_ones, population_matrix, best_pos_vec);


function new_gen_matrix = evolve_new_generation(digits, num_of_best_ones, population, best_pos)
    new_gen_matrix = zeros(num_of_best_ones, digits);
    
    %new_gen_matrix = get_individual(population, digits, best_pos(1));
    
    for i=1:num_of_best_ones
        new_gen_matrix(i,:) = get_individual(digits, population, best_pos(i));
    end
end

function individ = get_individual(digits, population, position)
    individ = zeros(1,digits);
    for digit = 1:digits
        individ(digit) = population(position,digit);
    end
end

function best_ones_pos_vec = get_best_positions(num_of_best_ones, score_vector)
    if sum(score_vector) == 0
        %return 2 random
    end
    
    best_ones_pos_vec = zeros(1,num_of_best_ones);
    
    for i=1:num_of_best_ones
        [m,max_index] = max(score_vector);
        best_ones_pos_vec(i) = max_index;
        score_vector(max_index) = 0; %after saving the position, change score to 0
    end
end

function score_vector = evaluation(digits, pop_size, searched_num, generation)
%calls function evaluate on each individual in current generation
%scores are returned as vector
    score_vector = zeros(1, pop_size);
    
    for individual = 1:pop_size
        score_vector(individual) = evaluate(digits, searched_num, generation(individual,:));
    end
end

function score = evaluate(digits, searched_num, individual)
%if digits match, give 1 score point
    score = 0;
    
    for gene = 1:digits
        if individual(gene) == searched_num(gene)
            score = score + 1;
        end
    end
end

function searched = set_searched_vec(smax, smin, digits)
%returns random number which will be searched for
    searched = zeros(1,digits);
    
    for i = 1:digits
        searched(i) = get_random_digit(smax, smin);
    end
    
    while searched(1) == 0
        searched(1) = get_random_digit(smax, smin);
    end
end

function pop_matrix = set_population(smax, smin, digits, pop_size)
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
%returns random digit belonging to interval <0,9>
    digit = round(rand() * (smax - smin + 1) + smin);
end