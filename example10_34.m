% Problem Set A - 10.34
clc;
clear;

%Inputing the relevant data given in the question
m_oil = input('Enter the mass flow rate of the hot fluid i.e. oil in kg/min: ');
m_water =input('Enter the mass flow rate of the cold fluid i.e. water in kg/min: ');
c_oil = input('Enter the specific heat in J/kg for oil: ');
c_water = input('Enter the specific heat in J/kg for water: ');
U = input('Enter the value of overall heat transfer coefficient in W/m^2 C: ');
A = input('Enter the area of the heat exchanger in SI units: ');
To_inlet = input('Enter the inlet temperature of oil in celsius: ');
Tw_inlet = input('Enter the inlet temperature of water in celsius: ');

%Calculating the product of mass flow rate and specific heat for each %liquid
C_water = (m_water * c_water)/60; %Conversion to kg/s
C_oil = (m_oil * c_oil)/60;

%Finding out minimum and maximum values of C 
if C_water > C_oil
    C_min = C_oil;
    C_max = C_water;
else
    C_min = C_water;
    C_max = C_oil;
end

%Finding the ratio between the minimum and maximum value and the NTU 
C = C_min/C_max;    
NTU = (U*A)/C_min;
    
%Finding out the effectiveness of the one shell pass and 2 tube pass
%exchanger by dividing the equation to subparts, the equation is obtained
%from Table 10.4 of the textbook

subpart_1 = 1 + exp(-NTU*((1+C^2))^0.5);
subpart_2 = 1 - exp(-NTU*((1+C^2))^0.5);
subpart_3 = subpart_1/subpart_2;
subpart_4 = (1 + C^2)^0.5;

epsilon = 2*((1+C+(subpart_4*subpart_3))^-1);

disp(' '); %Leaving a blank line
disp('Effectiveness of the Heat Exchanger:');
disp(epsilon);

%Finding the outlet temperature using the effecetiveness as a ratio of the
%temperature difference of minimum fluid and the maximum temperature
%difference in the heat exchanger

To_exit = To_inlet - ((To_inlet - Tw_inlet)*epsilon);
disp('Exit temperature of oil in Celsius:');
disp(To_exit);

% We can calculate the heat transfer from C of oil and change in the
% temperature of oil

del_To = To_inlet - To_exit;

q = C_oil * del_To;

disp('Actual Heat Transfer in Watts:');
disp(q);

% We can now obtain the change in temperature of water from the heat
% transfer and C of water

del_Tw = q / ((m_water * c_water)/60); %Converting Mass flow rate into kg/s

Tw_exit = Tw_inlet + del_Tw;

disp('Exit temperature of water in Celsius: ');
disp(Tw_exit);





    
    
