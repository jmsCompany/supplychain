* gams emp_newsboy.gms emp=lindo
variable z;

positive variable x, i, l, s;

scalar
   c 'purchase costs' /30/
   p 'penalty'        /5/
   h 'holding cost'   /10/
   v 'revence per unit' /60/
   d 'demand, random'   /45/
   ;

equation profit, row1, row2;

profit .. z =e= v*s -c*x -h*i-p*l;
row1 ..   d =e= s+l;
row2 ..   i =e= x-s;

model nb / all /;   

file emp / '%emp.info%'/; put emp '* problem %gams.i%' /;
$onput
randvar d discrete 0.7 45
                   0.3 40 
stage 2 i l s d
stage 2 row1 row2
$offput
putclose emp;


Set scen        scenarios / s1*s10 /;
Parameter
    s_d(scen)   demand realization by scenario
    s_x(scen)
    s_s(scen)
    s_o(scen,*)  scenario probability /#scen.prob 0 /;

Set dict / scen .scenario.''
           d    .randvar .s_d
           s    .level   .s_s
           x    .level   .s_x 
           ''   .opt     .s_o /;

solve nb max z use emp scenario dict;

display s_d, s_s, s_x;