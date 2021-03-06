function  OneWheelAccel()



      %rho = 1.225;
     %[CfdragT, CfdownT] = AeroMap(AP);
     %Fdrag1 = 1/2*rho*CfdragT*Drag_Var;   %Calculates Fdrag prime which is simply the collection of constants such that Drag Force = Fdrag1*Velocity^2 
     %Fdown1 = 1/2*rho*CfdownT*Down_Var;

    CarMass = 270*0.25;
    TireCf = 1.2;
    Rtire = 0.2286;
    
       dt = 0.01;
     Distance_Max = 75; %m
     PowerLim = 30000;
    
     i = 1;
     t(i) = 0;
     Fz = CarMass*9.81;
     Fx(i) = 0;
     %T(i) = 0;
     
     %Ffz(i) = 0;
     %Frz(i) = 0;
     %Ffx(i) = 0;
     %Frx(i) = 0;
     %Tr(i) = 0;
     %Tf(i) = 0;
      
     %Fdrag(i) = 0;
     %Fdown(i) = 0;
     
     pos(i) = 0;
     vel(i) = 0;
     accel(i) = 0;
     
     TracLimFx(i) = 0;   %Traction limit front wheel
     %TracLimFrx(i) = 0;   %Traction limit rear wheel
   
%
    
%          A = [ 2 2 CP.CarMass*9.81+vel(i)^2*Fdrag1; (2*(CP.WheelBase-CP.CG(1))+2*CP.TireCf*CP.CG(2)) (-2*CP.CG(1)+2*CP.TireCf*CP.CG(2)) -Fdown1*vel(i)^2*(CP.CG(1)-AP.CP(1)) - Fdrag1*vel(i)^2*(AP.CP(2) - CP.CG(2))];
%          B = rref(A)
%          Ffz(i) = B(1,3)
%          Frz(i) = B(2,3)
%          Ffx(i) = CP.TireCf*Ffz(i)
%          Frx(i) = CP.TireCf*Frz(i)

     
      while pos(i) < Distance_Max
          
         %A = [ 2 2 CP.CarMass*9.81+vel(i)^2*Fdrag1; (2*(CP.WheelBase-CP.CG(1))+2*CP.TireCf*CP.CG(2)) (-2*CP.CG(1)+2*CP.TireCf*CP.CG(2)) -Fdown1*vel(i)^2*(CP.CG(1)-AP.CP(1)) - Fdrag1*vel(i)^2*(AP.CP(2) - CP.CG(2))];
         %B = rref(A);
         
         %Ffz(i) = B(1,3);
         %Frz(i) = B(2,3);
         %Ffx(i) = CP.TireCf*Ffz(i); 
         %Frx(i) = CP.TireCf*Frz(i);
         
         %TracLimFfx(i) = Ffx(i);
         %TracLimFrx(i) = Frx(i);
         
         Fx(i) = Fz*TireCf;
         
         if vel(i)*Fx(i) > PowerLim
             Fx(i) = PowerLim/vel(i);
         end
         
         %OutputPower(i) = (Ffx(i)+Frx(i))*vel(i)
         
         %accel(i) = (-Fdrag1*vel(i)^2 + 2*Ffx(i) + 2*Frx(i))/CP.CarMass;
         accel(i) = Fx(i)/CarMass; 
         vel(i+1) = vel(i)+accel(i)*dt;
         
         pos(i+1) = pos(i)+vel(i)*dt + 1/2*accel(i)*dt^2;
         t(i+1) = t(i) + dt;
         i = i+1;
         
      end
      
      Fx(i) = Fx(i-1);
      accel(i) = accel(i-1);
%        Ffz(i) = Ffz(i-1);
%        Frz(i) = Frz(i-1);
%        Ffx(i) = Ffx(i-1);
%        Frx(i) = Frx(i-1);
%        TracLimFfx(i) = TracLimFfx(i-1);
%        TracLimFrx(i) = TracLimFrx(i-1);
%        
       T = Fx*Rtire;
       P = Fx.*vel; 
       
       %        Tf = Ffx*CP.Rtire;
       
%        TracLimTr = TracLimFrx*CP.Rtire;
%        TracLimTf = TracLimFfx*CP.Rtire;
       
%        Pf = Ffx.*vel;
%        Pr = Frx.*vel;
       
       
%        AccelPowerResults = [max(Pf), max(Pr)];
       
       AccelSimResults(:,1) = Fx;
       AccelSimResults(:,2) = T;
       AccelSimResults(:,3) = P;
       AccelSimResults(:,4) = pos;
       AccelSimResults(:,5) = vel;
       AccelSimResults(:,6) = accel;
       AccelSimResults(:,7) = t;
       
       yyaxis left 
       plot(pos(:),T(:),'r')
       hold on
       yyaxis right
       plot(pos(:),P,'g')
       hold off
       
%        AccelSimResults(:,1) = Ffz(:);  % Ffz
%        AccelSimResults(:,2) = Frz(:);  % Frz
%        AccelSimResults(:,3) = Ffx(:);  % Ffx
%        AccelSimResults(:,4) = Frx(:);  % Frx
%        AccelSimResults(:,5) = TracLimFfx(:);
%        AccelSimResults(:,6) = TracLimFrx(:);
%        AccelSimResults(:,7) = Tr(:);
%        AccelSimResults(:,8) = Tf(:);
%        AccelSimResults(:,9) = Pf(:);
%        AccelSimResults(:,10) = Pr(:);
%        AccelSimResults(:,11) = vel(:);
%        AccelSimResults(:,12) = pos(:);
%        AccelSimResults(:,13) = t(:);
%        


end