L = 1; % length of road
% Set # of cars
N = 100;

xc = rand(N, 1); % sets up cars in random locations around the road
xc = sort(xc);

CarInFront = [2 : N 1]; % 

allds = [];
allvs = [];

d = zeros(N , 1); % distance at each timestep
dt = 1e-2;
Tf = 50;
stopcount = Tf/dt;

vels = zeros(N,1); % velocities of the cars

% Define dmin, dmax, vmax for case 2: dmax > L/N > dmin
dmin = 0.9*(L/N); % hard-code this 
dmax = 1.1*(L/N); % hard-code this also
vmax = 0.1; % hard-code this also

% Test plot of v
dtest = linspace(0,2*dmax,100);
vtest = 0*dtest;

for iD=1:length(dtest)
    vtest(iD)=v(dtest(iD),dmin,dmax,vmax);
end

for iT=1:stopcount
    % Calculate velocity of each car (fill in the array vels)
    for iCar=1:N
        % Update the car positions
        d(iCar) = xc(CarInFront(iCar)) - xc(iCar);
        
         % handle the case for the final car
        if (d(iCar) < 0)
            d(iCar) = d(iCar) + L;
        end
        
        % Update the car velocities
        vels(iCar) = v(d(iCar), dmin, dmax, vmax);
    end 
    
    % new position = old position + time*(distance/time) (in array-style)
    xc = xc + dt*vels;
    
    % Plot them in circle
    theta = mod(xc,L)/L*2*pi;
    plot(cos(theta),sin(theta),'o')
    hold on
    tpl = linspace(0,2*pi,1000);
    plot(cos(tpl),sin(tpl))
    drawnow
    hold off
    % Keep track of distance between car and that in front
    allds = [allds d];
    allvs = [allvs vels];
    
end
plot(allvs(1,:))

function vv = v(d,dmin,dmax,vmax)
    if (d < dmin)
      vv=0;
    elseif (d < dmax) 
      vv=vmax*log(d/dmin)/log(dmax/dmin);
    else
      vv=vmax;
    end
end