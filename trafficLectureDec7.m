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
        
        onroad(nc) = 1; % indicator function; on road = 1, off road = 0
        insertnewcar % new script to place car
        choosedestination % another script
        
        nextb(nc) = b; % (?)
        
        tenter(nc) = t; % t = clock*dt 
        
        benter(nc) = b;
        penter(nc) = p(nc);
        
    end
end

% insertnewcar.m
% "this is where we get to the harder things, where the program gets interesting is what I'm trying to say"
c = firstcar(b);
if (c == 0) || p(nc) > p(c)) % only possible with arrays; 'or' condition syntax avoids a bug (ends issue if the first condition is true
    nextcar(nc) = c; % if the position of the new car is greater than the position of the first car then the new car becomes the first car
    firstcar(b) = nc;
    
    if (c == 0) %if the block is empty it is also the last car
        lastcar(b) = nc;
    end
    
elseif p(nc) >= p(lastcar(b))
    nextcar(lastcar(b)) = nc;
    lastcar(b) = nc;
    
else
    ca = c;
    c = nextcar(c);
    
    while (p(nc) <= p(c))
        ca = c;
        c = nextcar(c);
    end
    
    nextcar(ca) = nc;
    nextcar(nc) = c; % the car behind
    
end

% movecars.m

for b = 1:nb
    c = firstcar(b);
    while  (c > 0)
        if (c == firstcar(b))
            
            if (bd(c) == b) && (pd(c) > p(c)) % if your destination is not ahead of you, or on the same block
                d = dmax;
            elseif (s(b) == 0)
                d = L(b) - p(c); 
            else % then, we need to decide the next block
                decidenextblock % another script 
                
                if (lastcar(nextb(c)) > 0)
                    d = L(b) - p(c) + p(lastcar(nextb(c)));
                else 
                    d = dmax;
                    
                end
            end
            
        else % what if we are not talking about the first car?
             % then d is simply the position of the car ahead minus the position of the car
            d = p(ca) - p(c);
        end
        pz = p(c); % old position
        nextc = nextcar(c); 
        p(c) = p(c) + dt* v(d);
        
        % if the block we're on is the destination block and the old position
        % is less than the 
        if (b == bd(c) && (pz < pd(c)) && (pd(c) <= p(c)))
            removecar
            
                
        elseif (L(b) <= p(c))
            p(c) = p(c) - L(b);
            if (nextb(c) == bd(c) && pd(c) <= p(c))
                removecar
            else 
                cartonextblock
            end
            
        else
            x(c) = xi(i1(b)) + p(c)*ux(b);
            y(c) = yi(i1(b)) + p(c)*uy(b);
            
            ca = c;
        end
        c = nextc;
    end
end

        
        
        
        

        
        

