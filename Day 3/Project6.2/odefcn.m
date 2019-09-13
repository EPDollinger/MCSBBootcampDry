function dydt = odefcn(y,e,a,b,D,T,I0,tStart,tStop)

I0_vec = zeros(10,1);

I0_vec(4) = I0;

I = @(t) I0_vec*(t>tStart).*(t<tStop);

v = y(1:length(y)/2);

w = y(length(y)/2+1:end);

dydt = zeros(length(y),1);

dydt(1:length(y)/2) = v - 1/3*v.^3 - w + I(T) + D*(v([end,1:end-1]) - 2*v + v([2:end,1]));

dydt(length(y)/2+1:end) = e*(v+a-b*w);

end