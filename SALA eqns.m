clear
%Jmax and Vmax as function leaf N
syms N kv kj N_alloc;
V = N*N_alloc*kv;
J = N*(1-N_alloc)*kj;

%Rubsico limited and Electron limited photosynthesis
syms ci T Kc oi Ko ri Km;
Av= V*(ci-T)/(ci+Km) -ri*N; %Kc*(1+oi/Ko));
Aj = J*(ci-T)/4/(ci+2*T)- ri*N;

%solve for A/ci given stomatal conductance
syms gc ca ci_i
fv = Av - gc*(ca-ci);
fj = Aj-  gc*(ca-ci);
    %Intersection with Av curve
    solve(fv, ci);
    ci_v=ans(1)
    A_v = subs(Av, ci, ci_v);
    d_A_v =diff(A_v, N_alloc);
    %Intersection with Aj curve
    solve(fj, ci);
    ci_j=ans(1)
    A_j = subs(Aj, ci, ci_j);
    d_A_j =diff(A_j, N_alloc);
    %solve intersection of Aj & Av
    solve(Av-Aj,ci);
    ci_i =ans(2);   %take root ci !=T
    pretty(simple(ci_i))
   
    %Solve for N_alloc which gives joint intersection between stomatal
    %conductance, Aj and Av
    solve(subs(fj, ci, ci_i), N_alloc);
    N_alloc_i=ans(1); % Use positive root only
    pretty(simple(N_alloc_i))
    %check solution
      %subs(fj, ci, ci_i); subs(ans, N_alloc, N_alloc_i); simple(ans)
      %subs(fv, ci, ci_i); subs(ans, N_alloc, N_alloc_i); simple(ans)
    %joint solution
    ci_b = subs(ci_i, N_alloc, N_alloc_i)
    A_b=subs(Aj, ci, ci_i); A_b=subs(A_b, N_alloc, N_alloc_i)
    %make simpler function for R with given parameter values
    T = 32.6; kv = 2.0*33.6; kj = 2.0*44.3;     Ko=216000; Kc=223; oi=210000; Km = Kc*(1+oi/Ko);
    simple(subs(N_alloc_i)) simple(subs(ci_b))
    
%show maximum by evaluating derivatives of dA_dN_alloc
F1 = subs(d_A_v, N_alloc, N_alloc_i); % should be greater than zero 
F2 = subs(d_A_j, N_alloc, N_alloc_i); % should be less than zero 
    %plot across range of stomatal conductances
    Ko=216000; Kc=223; oi=210000; Km = Kc*(1+oi/Ko);
    N=2; T = 32.6; ca = 380; ri = 0.066/(24*3600)/(12*10^(-6));	kv = 2.0*33.6; kj = 2.0*44.3;
    F1 = simple(subs(F1));
    F2 = simple(subs(F2)); 
    %ezplot(subs(F1), 0.01, 100); hold all; ezplot(subs(F2), 0.01, 100);
    FN1=@(gc)(252./5.*(37890174246381924.*gc-4275735039439909-33984216.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+(24789204636666781559429928634176528.*gc.^2-362357202241044426906391480019160.*gc-2575335731733361047423168.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+20923795644647393992350600977305+290615006278188772952688.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)).^(1./2)).*(201982847628195516.*(24789204636666781559429928634176528.*gc.^2-362357202241044426906391480019160.*gc-2575335731733361047423168.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+20923795644647393992350600977305+290615006278188772952688.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)).^(1./2).*gc-4275735039439909.*(24789204636666781559429928634176528.*gc.^2-362357202241044426906391480019160.*gc-2575335731733361047423168.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+20923795644647393992350600977305+290615006278188772952688.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)).^(1./2)-33984216.*(24789204636666781559429928634176528.*gc.^2-362357202241044426906391480019160.*gc-2575335731733361047423168.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+20923795644647393992350600977305+290615006278188772952688.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)).^(1./2).*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+34569268858727338652034797099604240.*gc.^2-1067602371920690115750223607720088.*gc-8151896587958364629687040.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+20923795644647393992350600977305+290615006278188772952688.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2))./(201982847628195516.*gc-4275735039439909-33984216.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+(24789204636666781559429928634176528.*gc.^2-362357202241044426906391480019160.*gc-2575335731733361047423168.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+20923795644647393992350600977305+290615006278188772952688.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)).^(1./2)).^2./(24789204636666781559429928634176528.*gc.^2-362357202241044426906391480019160.*gc-2575335731733361047423168.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+20923795644647393992350600977305+290615006278188772952688.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)).^(1./2));
    FN2=@(gc)(-443./20.*(-3872030187445585+34312673057679060.*gc+29871047.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+(17033699400638501387928754580786-294937850750938941352176395088192.*gc+20319262505448448114803691792609056.*gc.^2+2049910939203129824351640.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)-231323191429211758954990.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)).^(1./2)).*(-3872030187445585.*(17033699400638501387928754580786-294937850750938941352176395088192.*gc+20319262505448448114803691792609056.*gc.^2+2049910939203129824351640.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)-231323191429211758954990.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)).^(1./2)+102255411105576852.*(17033699400638501387928754580786-294937850750938941352176395088192.*gc+20319262505448448114803691792609056.*gc.^2+2049910939203129824351640.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)-231323191429211758954990.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)).^(1./2).*gc+29871047.*(17033699400638501387928754580786-294937850750938941352176395088192.*gc+20319262505448448114803691792609056.*gc.^2+2049910939203129824351640.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)-231323191429211758954990.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)).^(1./2).*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+17033699400638501387928754580786-561018849344215458995826595562112.*gc+16759928444836160950157168273067552.*gc.^2+4079431660740573020379864.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)-231323191429211758954990.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2))./(-3872030187445585+102255411105576852.*gc+29871047.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)+(17033699400638501387928754580786-294937850750938941352176395088192.*gc+20319262505448448114803691792609056.*gc.^2+2049910939203129824351640.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)-231323191429211758954990.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)).^(1./2)).^2./(17033699400638501387928754580786-294937850750938941352176395088192.*gc+20319262505448448114803691792609056.*gc.^2+2049910939203129824351640.*gc.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)-231323191429211758954990.*(2287491469986529+3075746378906115216.*gc.^2-39480647818299288.*gc).^(1./2)).^(1./2));
    X = 0:0.001:380; plot(X, FN1(X)); hold all; plot(X, FN2(X)); 

%plot optimal N_alloc as function gc
Ko=216000; Kc=223; oi=210000; Km = Kc*(1+oi/Ko);
N=2;  T = 32.6;  ca = 380;	kv = 2.0*33.6; kj = 2.0*44.3; ri = 0.066/(24*3600)/(12*10^(-6));
F3 = simple(subs(N_alloc_i));
% ezplot(F3, 0.001, 500);
FN=@(gc)(-11670212072891./3945442639140.*gc+20375522429483./47345311669680+67429./47345311669680.*(16413004056883009+4313467702324546704.*gc.^2-153566130632583192.*gc).^(1./2));
X = 0:0.001:380; 
plot(X, FN(X))




    
%plot Av/Aj as function N alloc
Ko=216000; Kc=223; T = 32.6; oi=210000; ca = 380;	kv = 0.75*33.6; kj = 1.0*44.3; N= 2;

Av2= subs(Av); Av2 = subs(Av2); Aj2 = subs(Aj); Aj2 = subs(Aj2);
N_alloc = 0.5;
ezplot(subs(Av2), 0, 380) 
hold all; ezplot(subs(Aj2), 0, 380) 


syms psi_s psi_l pw grav sala H r_sr Ks ca D
g = 1/1.6/D*(psi_s-psi_l-pw/10^6*grav*H)/(r_sr+H/Ks/sala);

%Show opitmal allocation of SALA

syms M f pw h pr dw Rwd Rrt
SALA = M*f/pw/h
RALA = M*(1-f)/pr/dw

Rpl = Rwd/SALA + Rrt/RALA
dR = diff(Rpl,f)
solve(dR, f)
pretty(simple(ans))

