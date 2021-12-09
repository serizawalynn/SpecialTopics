L = 4550; % length of road, hard-coded
% Set # of cars
N = 5;

xc = 200*rand(N, 1); % sets up cars in random locations around the road
xc = sort(xc);

CarInFront = [2 : N 1]; % 

allds = [];
allvs = [];

d = zeros(N , 1); % distance at each timestep
dt = 0.5;
Tf = 5000; %Parade took about three hours (10800 sec)
stopcount = Tf/dt;

%Intersections
Intsct=[275 1725 2275 4275 4550];                                                                                                                                                                                                                                              

vels = zeros(N,1); % velocities of the cars

% Define dmin, dmax, vmax for case 2: dmax > L/N > dmin
dmin = 0.9*(10/N); % hard-code this 
dmax = 5*(10/N); % hard-code this also
vmax = 2; % hard-code this also

% Test plot of v
dtest = linspace(0,2*dmax,100);
vtest = 0*dtest;

for iD=1:length(dtest)
    vtest(iD)=v(dtest(iD),dmin,dmax,vmax);
end


%%Code for movie/visuals
my_figure=figure(1);
vidya=VideoWriter("awesome.mp4");

%video fps
framerate_we_want=60;
duration_we_want=10;
framerate=framerate_we_want*duration_we_want;
vidya.FrameRate=framerate;
open(vidya)

for iT=1:stopcount
    iT
    % Calculate velocity of each car (fill in the array vels)
    for iCar=1:N
        % Update the car positions
        d(iCar) = xc(CarInFront(iCar)) - xc(iCar);
        
         % handle the case for the final car
        if (d(iCar) < 0)
            d(iCar) = d(iCar) + L;
        end
        
        % Update the car velocities
        for i=1:length(Intsct)
            if abs(Intsct(i)-xc(iCar))<5
            %if (xc(iCar)>(Intsct(i)-5)) & (xc(iCar)<(Intsct(i)+5))
                vels(iCar)=min(vels(iCar),1);
                break %we're breaking because we only need to find the one intersection the car is at
            else
                vels(iCar) = v(d(iCar), dmin, dmax, vmax);
            end
        end
        
    end 
    
    % new position = old position + time*(distance/time) (in array-style)
    xc = xc + dt*vels;
    
    % Plot them in the route
    plot([-10,4550],[0 0])
    hold on
    plot(Intsct,0,'*')
    ylim([-600, 200])
    
    
    %Plot vehicles
    
    plot(xc,0,'.',MarkerSize=25)
    
    
    %Visuals
    axis([-10 4550 -10 10])
    drawnow
    hold off
    % Keep track of distance between car and that in front
    allds = [allds d];
    allvs = [allvs vels];
    %xc
    %vels
    
    %Code for visuals
    Mv=getframe(gcf);
    writeVideo(vidya,Mv)
end

close(vidya)

allvs_figure=figure(2);
plot(allvs(1,:))
drawnow

function vv = v(d,dmin,dmax,vmax)
    if (d < dmin)
      vv=0;
    elseif (d < dmax) 
      vv=vmax*log(d/dmin)/log(dmax/dmin);
    else
      vv=vmax;
    end
end