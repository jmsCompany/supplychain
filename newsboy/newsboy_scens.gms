variable z;

* 两种可能性 1 0.7的可能卖出去45份报纸， 0.3的可能卖出去40份报纸
set sc /s1, s2/;

parameter
    d(sc) /s1 45,  s2 40 /
    w(sc) /s1 0.7, s2 0.3/
    ;

* X 进货数量 I 库存数量 L未卖出数量
positive variable X, I(sc), L(sc),S(sc);

scalar
   c 'purchase costs'       /30/
   p 'penalty'              /5/
   h 'holding cost'         /10/
   v 'revence per unit'     /60/
   ;

equation profit, row1,row2;

profit .. z =e= sum(sc, w(sc)*(S(sc)*v -h*I(sc)-p*L(sc)))-c*X;
row1(sc) ..   d(sc) =e= S(sc)+L(sc);
row2(sc)..    I(sc) =e= X-S(sc);

model nv / all /;   

solve nv using lp max z;