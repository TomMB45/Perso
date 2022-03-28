// comm 
// function [return var] = fct_name(arg_fct)

 
function [v] = equations(t,x,para)
    // t = temps; x = état initial ;p=paramètres 
    // X = vecteur variable
    B=x(1);
    D=x(2);
    R=x(3);
    P=x(4);
    
    n = para(1)
    kB=para(2);
    VB=para(3);
    gammaB=para(4);
     
    kD=para(5);
    VD=para(6);
    gammaD=para(7);
    
    kR=para(8);
    VR=para(9);
    gammaR=para(10);
    
    //kP=para(4);
    //VP=para(4);
    //gammaP=para(4);
    
    // Champs de vecteur
    v=[];
    v(1)=VR*kR^n/(R^n+kR^n)-gammaB*B*P; // B
    v(2)=VB*B^n/(B^n+kB^n)-gammaD*D; // D
    v(3)=VD*D^n/(D^n+kD^n)-gammaR*R; // R
    v(4)=VD*D^n/(D^n+kD^n)-gammaB*B*P; // P
endfunction

// Fonction principale
n=4;
kB=0.5;
VB=3.5;
gammaB=3;
kD=4;
VD=60;
gammaD=0.2;
kR=75;
VR=60;
gammaR=0.2;
//kP=para(4);
//VP=para(4);
//gammaP=para(4);
para=[n,kB,VB,gammaB,kD,VD,gammaD,kR,VR,gammaR]; 

// CDNS initiales et temps de solutions 
x0=[5;0;10;0];//nb de variables Ex B=x(1);

t0=0;
tfinal=60;
dt=0.1;
tvec=[t0:dt:tfinal];// équivalent de range(init,fin,pas=dt)

//Solutions 
xsol=ode("stiff",x0,t0,tvec,list(equations,para));//type de méthode de résol,cdns init, tps init, instant t,  
plot(tvec, xsol(1,:),"r-",tvec, xsol(2,:),"b-",tvec, xsol(3,:),"g-",tvec, xsol(4,:),"y-");

//Question 2: 
//Euler 
function x_sol=Euler_resolution(t_euler,x_euler,para_euler,h)
    x_old = x_euler ; 
    x_new = []; //nouvelles valeurs de x 
    x_sol = zeros(length(t_euler)-1,n); // Poits d'équilibre 
    x_sol(1,1:4) = x_euler ;
    //h=0.01;
    for i=1:length(t_euler)-1 
        x_new = x_old + h*equations(0,x_old,para_euler); // calcul de la valeur suivante à partir de la valeur précédente 
        x_sol(i+1,1:4) = x_new; // ajout de la valeur calculée dans l'array de xsol 
        x_old = x_new //L'état suivant devient le nouvel instant 0 
    end 
endfunction

//Euler test 
/*
Euler_h001 = Euler_resolution(tvec,x0,para,0.01)
figure(1);
subplot(211);
plot(tvec,Euler_h001(:,1),'r-',tvec,Euler_h001(:,2),'b-',tvec,Euler_h001(:,3),'g-',tvec, Euler_h001(:,4),'y-');
xtitle("Méthode Euler avec h = 0.01")
Euler_h01 = Euler_resolution(tvec,x0,para,0.1)
figure(2);
subplot(211);
plot(tvec,Euler_h01(:,1),'r-',tvec,Euler_h01(:,2),'b-',tvec,Euler_h01(:,3),'g-',tvec, Euler_h01(:,4),'y-');
xtitle("Méthode Euler avec h = 0.1")
*/
