function vv = v(d)
global dmin dmax vmax;
if (d < dmin)
  vv=0;
elseif (d < dmax) 
  vv=vmax*log(d/dmin)/log(dmax/dmin);
else
  vv=vmax;
end

