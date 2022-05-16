%%
%+++++++++++++++++++++++++++++++++++++++++
% SCRIPT TO PLAY THE FEIGENBAUM TREE
% 
% if you want to stop it  
%  >> clear playsnd
% 
% felipeardilac@gmail.com
%+++++++++++++++++++++++++++++++++++++++++
function playFeigenbaum

humanRange=[20 20000];
sampling=16000;
T=1/sampling;


%Logistic map
N=600; %Length of sound
lambda=3.6+rand(1)*.4;%Rand lambda near the chaotic zone [3.6 4]
Y=logistica(lambda,0.2,N);
Y=Y(end-fix(N*.5):end);%Get half of values

% Y=(Y-min(Y))./(max(Y)-min(Y));%Between [0 1]
ytot=0;

%Play every value of Y
    for kk=1:length(Y)
        %Play time of each value of the logistic timeseries
        L=0.1;%seconds    
        t=0:T:L;
         
        %Build sounds of 4 harmonics
        y=0;
        N_Harmonics=4;
            F=(Y(kk)*(humanRange(2)-humanRange(1)))+humanRange(1);
            y=y+sin(((F*(1))*t)/2*pi);
            for a=1:N_Harmonics
             y=y+sin(((F*(a/(a+1)))*t)/2*pi);
            end

        %Scale sound Between [0-1]
        y=y./N_Harmonics;
        ytot=[ytot y];
    end  

%Plot it
    subplot(2,1,1)
    plot(Y,'.-r');
    xlim([0 length(Y)])
    title(['lambda = ',num2str(lambda)])
    subplot(2,1,2)
    periodogram(ytot)
    sound(ytot,sampling)
    getframe;
  
function x=logistica(lambda,x0,niter)
% x=logistica(lambda,x0,niter)

x=zeros(niter,1);
x(1)=x0;
for i=1:niter-1
    x(i+1)=x(i)*lambda*(1-x(i));
end
