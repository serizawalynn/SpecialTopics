L = 595; % length of road, hard-coded
% Set # of cars
N = 10;

xc = -10*rand(N, 1); % sets up cars in random locations around the road
xc = sort(xc);

CarInFront = [2 : N 1]; % 

allds = [];
allvs = [];

d = zeros(N , 1); % distance at each timestep
dt = 5;
Tf = 10800;
stopcount = Tf/dt;

%Intersections
Intsct=[275 1725 2275 4275 4550];                                                                                                                                                                                                                                              

vels = zeros(N,1); % velocities of the cars

% Define dmin, dmax, vmax for case 2: dmax > L/N > dmin
dmin = 0.9*(10/N); % hard-code this 
dmax = 5*(10/N); % hard-code this also
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
%         if (d(iCar) < 0)
%             d(iCar) = d(iCar) + L;
%         end
        
        % Update the car velocities
        for i=1:length(Intsct)
            if (xc(iCar)>(Intsct(i)-10)) || (xc(iCar)<Intsct(i)+10)
                vels(iCar)=min(vels(iCar),1);
            else
                continue
            end
        end
        vels(iCar) = v(d(iCar), dmin, dmax, vmax);
    end 
    
    % new position = old position + time*(distance/time) (in array-style)
    xc = xc + dt*vels;
    
    % Plot them in the route
    A1 = [0,0];
    B1 = [0, -200];

    A2 = [80, 80];
    B2 = [-200, -490];

    A3 = [0, 80];
    B3 = [-200, -200];

    A4 = [55, 80];
    B4 = [-490, -490];

    plot(A1,B1)
    hold on
    plot(A2,B2)
    plot(A3, B3)
    plot(A4, B4)
    ylim([-600, 200])
    axis([-10 10 -10 10])
    
    %Plot vehicles
    
    plot(xc,0,'.',MarkerSize=50)
    hold on
    
    %Visuals
  
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