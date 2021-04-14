% Problem Set B - 10.25
clc;
clear;

%To solve 10.25 we first need to solve 10.24
%Inputing the relevant constant data given in the question
m_steam = input('Enter the mass flow rate of the hot fluid i.e. steam in kg/min: ');
Tw_inlet_old = input('Enter the inlet temperature of cooling water initially in celsius: ');
Tw_exit_old = input('Enter the exit temperature of cooling water initially in celsius: ');
T_sat = input('Enter the saturation temperature for the steam in celsius: '); 
hfg = input('Enter the enthalpy of vaporization for the steam in J/kg: ');
c_water = input('Enter the specific heat of the cooling water in J/kg: ');
U = input('Enter the value of overall heat transfer coefficient in W/m^2 C: ');

% Calculating the heat required for the condensation of vapours to take
% place

q = (m_steam * hfg)/60;
disp(' ');
disp('Actual heat transfer in Watts:');
disp(q);

%Calculating the log mean temperature 

numerator = (T_sat - Tw_inlet_old) - (T_sat - Tw_exit_old);
denominator = log((T_sat - Tw_inlet_old)/ (T_sat - Tw_exit_old));

log_mean_T = numerator/denominator;

disp('Log Mean Temperature: ');
disp(log_mean_T);

%Calculating the area of the heat exchanger, here F = 1 since the heat
%exchanger is a double-pipe heat exchanger

area = q / (U*log_mean_T);

disp('Area of the double-pipe heat exchanger: ');
disp(area);

%Solving 10.25 by using the new inlet temperature of cooling water.

Tw_inlet_new = input('Enter the new inlet temperature of cooling water in celsius: ');

%The heat transfer would still be the same in order to maintain the rate of
%condensation

log_mean_Tnew = q / (U*area);

% We need to perform iterations to obtain the value of exit temperature of
% the cooling water by assuming a value for it.

Tw_exit_new = 40; %Assumed value greater than inlet temperature

i = 0;
del_T_1 = T_sat - Tw_inlet_new;

% Use of fixed point iteration to obtain the exit temperature of water in
% the second case
while i < 1000 %Performing 1000 iterations
    del_T_2 = Tw_exit_new - Tw_inlet_new;
    Tw_exit_new = T_sat - (del_T_1 * exp( - del_T_2 / log_mean_Tnew));
    i = i + 1;
end

disp(' ');
disp('Exit temperature of the inlet water in the second case: ');
disp(Tw_exit_new);

% We try to now obtain the new mass flow rate of cooling water and the old
% mass flow rate of water before temperature increase

m_water_new = q / (c_water * (Tw_exit_new - Tw_inlet_new));
disp('The mass flow rate of water for inlet temperature of 30 degree celsius: ');
disp(m_water_new);

m_water_old = q / (c_water * (Tw_exit_old - Tw_inlet_old));
disp('The mass flow rate of water for inlet temperature of 10 degree celsius: ');
disp(m_water_old);

%Calculate the percentage increase in mass flow rate of cooling water

percent_increase = ((m_water_new - m_water_old)*100 ) / m_water_old;

disp('Percentage increase in mass flow rate of cooling water on increasing the temperature: ');
disp(percent_increase);














