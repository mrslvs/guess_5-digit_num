%GA
%guess 5-digit number
%isid92654

NUM_OF_DIGITS = 5;
pop_size = 8;

num_min = 0;
num_max = 8; %+1

%set random number as searched number
searched_number = set_searched_vec(NUM_OF_DIGITS, num_max, num_min);

%create population
generation_matrix = set_population(NUM_OF_DIGITS, num_max, num_min, pop_size);

function score_matrix = evaluation(generation, searched, digits, pop_size)
    for individual = 1:pop_size
        score_matrix(individual) = evaluate(generation(individual), searched, digits);
    end
end

function score = evaluate(individual, searched, digits)
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