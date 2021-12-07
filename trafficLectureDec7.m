initialize % this should be a script 
for clock = 1:clockmax
    jgreen = ones(1, ni); % one row with length = number of intersections
    tlcstep = 5; % hardcoded, dictates how long the light stays at its state
    tlc = tlcstep;
    t = clock*dt;
    setlights;
    createcars;
    movecars;
    plotcars;
end

% setlights.m 
if (t > tlc) % all lights are synchronous in the sense that all lights change at the same time
    for i = 1: ni % for all numbers of intersections, update who gets the green light
        jgreen(i) = jgreen(i) + 1;
        % its a circle so we need to set it to 1 if we've reached the end
        if (jgreen(i) > nbin(i))
            jgreen(i) = 1;
        end
    end
    
    tlc = tlc + tlcstep; % tlcstep is how often the lights take to change
    s = zeros(1, nb);
    for i = 1:ni
        b = bin(i, jgreen(i)); % tells us what's the block for a given intersection
        s(b) = 1; % every block has 2 names: the number it is coming into an intersection, and a global name b
    end
   
end

% createcars.m
for b = 1:ni
    if (rand < dt*R*L(b)) % make a random decision about whether we're making a car or not
    % R is the probability per unit time per unit length 
    % L(b) is the length of the block
        nc = nc + 1; % is also the index of the new car
        p(nc) = rand*L(b); % put the car here
        x(nc) = xi(i1(b)) + p(nc)*ux(b); % now give it coordinates for plotting purposes
        % ux is the bth component of a unit vector
        y(nc) = yi(i1(b)) + p(nc)*uy(b);
        
        

