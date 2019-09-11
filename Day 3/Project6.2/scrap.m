%% Run function and plot
figure;
hold on;

finalA_I1 = [];

for Ktot = 10.^[-3:0.1:2]

    finalA_I1 = [finalA_I1,ode_out(Ktot,1)];
    
end

finalA_I100 = [];

for Ktot = 10.^[-3:0.1:2]

    finalA_I100 = [finalA_I100,ode_out(Ktot,100)];
    
end

finalA_I1_norm = finalA_I1./max(finalA_I1);
finalA_I100_norm = finalA_I100./max(finalA_I100);

plot([-3:0.1:2],[finalA_I1_norm;finalA_I100_norm],'x')

legend('I = 1 uM','I = 100 uM')
ylabel('Normalized active protein')
xlabel('Log of Ktot')

%% function section
function finalA = ode_out(Ktot,Itot)

    konA = 10;
    koffA = 10;
    konI = 10;
    koffI = 10;
    kcatI = 10;
    kcatA = 100;
    
    Ptot = 1;

    eqns = @(A,AP,I,IK) ...
    [koffA*AP - konA*(Ptot - AP)*A + kcatA*IK;... %dAdt
    - koffA*AP + konA*(Ptot - AP)*A - kcatI*AP;... %dAPdt
    koffI*IK - konI*(Ktot - IK)*I + kcatI*AP;... %dIdt
    - koffI*IK - kcatA*IK + konI*(Ktot - IK)*I]; %dIKdt

    x_0 = [0,0,Itot,0];

    [T, X] = ode45(@(t,x) eqns(x(1),x(2),x(3),x(4)), [0 10], x_0 );
    finalA = X(end,1);
end