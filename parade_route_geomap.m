latFirstStreet = 40.779492; % 40.779480,-73.973611
lonFirstStreet = -73.973591;

latSecondStreet = 40.768049; % 40.768074,-73.981890
lonSecondStreet = -73.981832;

latThirdStreet = 40.765680; % 40.765680,-73.976246
lonThirdStreet = -73.976246;

latFourthStreet = 40.749785; % 40.749785,-73.987760
lonFourthStreet = -73.987760;

latFinalStop = 40.751002; % 40.751002,-73.990624
lonFinalStop = -73.990624;

geolimits([40 41],[-73 -74])
geoplot([latFirstStreet latSecondStreet],[lonFirstStreet lonSecondStreet],'g-*')
hold on
geoplot([latSecondStreet latThirdStreet],[lonSecondStreet lonThirdStreet],'g-*')
geoplot([latThirdStreet latFourthStreet],[lonThirdStreet lonFourthStreet],'g-*')
geoplot([latFourthStreet latFinalStop],[lonFourthStreet lonFinalStop],'g-*')
% geobasemap colorterrain
drawnow
hold off