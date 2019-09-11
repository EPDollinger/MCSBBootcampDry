params = [10;10;10;10;10;100];

Ktot = 1;
Ptot = 1;

eqns = @(params,IK,I,AP,A) [params(4).*IK - params(3).*(Ktot - IK) + params(5).*AP;...
    params(2).*AP - params(1).*(Ptot - AP).*A + params(6).*IK;...
    - params(2).*AP + params(1).*(Ptot - AP).*A - params(5).*AP;...
    - params(4).*IK - params(6).*IK + params(1).*(Ktot - IK).*I];

dIdt = @(IK,AP,A,I) params(4).*IK - params(3).*(Ktot - IK) + params(5).*AP;
dAdt = @(IK,AP,A,I) params(2).*AP - params(1).*(Ptot - AP).*A + params(6).*IK;
dAPdt = @(IK,AP,A,I) - params(2).*AP + params(1).*(Ptot - AP).*A - params(5).*AP;
dIKdt = @(IK,AP,A,I) - params(4).*IK - params(6).*IK + params(1).*(Ktot - IK).*I;

x_0 = [0,1,0,1];

[T, X] = ode45(@(t,x) [eqns(params,x(1),x(2),x(3),x(4))], [0 1], x_0 );

%[T, X] = ode45(@(t,x) [dIdt(x(1),x(2),x(3),x(4));dAdt(x(1),x(2),x(3),x(4));dAPdt(x(1),x(2),x(3),x(4));dIKdt(x(1),x(2),x(3),x(4))], [0 1], x_0 );

figure;
plot(T,X)