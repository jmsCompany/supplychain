$title  green supply chain, from the paper Green supply chain network design with stochastic demand and carbon price.
$onText

绿色供应链模型：
1）五个最终消费者（customer）：New South Wales, Victoria, Queensland, South Australia and Western Australia
2）五个可能创建的工厂 (plant)：New South Wales, Victoria, Queensland, South Australia and Western Australia
3）五个可能的仓库 (warehouse)：New South Wales, Victoria, Queensland, South Australia and Western Australia
4）三个供应商 (supplier)：Queensland, South Australia and Western Australia
5) 三个产品类型 (products type)：product1,product2,product3 
6）工厂容量类别（capacity）：small, medium , large 
7) 仓库(capacity)类别： small , large
8) 三类生产技术：greener technology：  low, medium, high
9) 预算( budget constraint ): $30 000 000
10) 24种场景(scenarios) : 对三类不同产品的需求估计（乐观、悲观 “optimistic” or “pessimistic”) 2*2*2=8,
                        碳价（carbon price： low, medium and high.） 3*8=24
                        *s1   代表product1乐观，product2乐观，product3乐观， 碳价高
                        *s2   代表product1乐观，product2乐观，product3乐观， 碳价正常
                        *s3   代表product1乐观，product2乐观，product3乐观， 碳价底
                        *s4   代表product1乐观，product2乐观，product3悲观， 碳价高 
                        *s5   代表product1乐观，product2乐观，product3悲观， 碳价正常 
                        *s6   代表product1乐观，product2乐观，product3悲观， 碳价底 
                        *s7   代表product1乐观，product2悲观，product3乐观， 碳价高
                        *s8   代表product1乐观，product2悲观，product3乐观， 碳价正常
                        *s9   代表product1乐观，product2悲观，product3乐观， 碳价底 
                        *s10  代表product1乐观，product2悲观，product3悲观， 碳价高
                        *s11  代表product1乐观，product2悲观，product3悲观， 碳价正常
                        *s12  代表product1乐观，product2悲观，product3悲观， 碳价底 
                        *s13  代表product1悲观，product2乐观，product3乐观， 碳价高
                        *s14  代表product1悲观，product2乐观，product3乐观， 碳价正常
                        *s15  代表product1悲观，product2乐观，product3乐观， 碳价底 
                        *s16  代表product1悲观，product2乐观，product3悲观， 碳价高 
                        *s17  代表product1悲观，product2乐观，product3悲观， 碳价正常 
                        *s18  代表product1悲观，product2乐观，product3悲观， 碳价底 
                        *s19  代表product1悲观，product2悲观，product3乐观， 碳价高
                        *s20  代表product1悲观，product2悲观，product3乐观， 碳价正常
                        *s21  代表product1悲观，product2悲观，product3乐观， 碳价底 
                        *s22  代表product1悲观，product2悲观，product3悲观， 碳价高
                        *s23  代表product1悲观，product2悲观，product3悲观， 碳价正常
                        *s24  代表product1悲观，product2悲观，product3悲观， 碳价底
11) 三种运输方案（transport mode）      
12) 原材料 raw material r                   
$offText

Set
  
   i 'product type'          / product1,  product2 /
   r 'raw material'          / r1, r2 /
   n 'supplier'              / Queensland, South_Australia /
   m 'plant'                 / New_South_Wales,  Victoria /
   h 'technology'            / green, pollutant /
   u 'plant capacity'        / small, large /
   w 'warehouse'             / Victoria,  Western_Australia /
   v 'warehouse capacity'    / small, large /
   k 'transport mode'        / train, airplane /
   j 'customer'              / Victoria,  Queensland /
   s 'scenario'              / s1*s3 /;


Scalar b   'total budget'                                            / 300000 /
       cap 'Maximum overall allowed carbon emissions (ton)'          / 10000  /;

Parameter
   pai(s) 'Market price of carbon credit in scenario s'
/
$ondelim
$include data_pai.csv
$offdelim
/

  d(i,j,s) 'Forecasted demand for product i in end-user j in scenario s'
/
$ondelim
$include data_d.csv
$offdelim
/

 f(m,h,u) 'Fixed costs of establishing plant m with technology h and capacity u'
 /
$ondelim
$include data_f.csv
$offdelim
/

  ff(w,v) 'Fixed costs of establishing  warehouse w with capacity v'
 /
$ondelim
$include data_ff.csv
$offdelim
/ 
  fff(n) 'Fixed costs of selecting supplier n'
 /
$ondelim
$include data_fff.csv
$offdelim
/

  cm(i,m,h) 'cost of manufacturing a unit of product i with technology h in plant m'
 /
$ondelim
$include data_cm.csv
$offdelim
/

  cs(r,n,m) 'cost of purchasing a unit of raw material r from supplier n for processing at plant m'
 /
$ondelim
$include data_cs.csv
$offdelim
/

  ct(i,m,w,k) 'Per unit cost of shipment of product i from plant m to warehouse w through transport mode k' 
/ 
$ondelim 
$include data_ct.csv
$offdelim 
/   

ctt(i,w,j,k) 'Per unit cost of shipment of product i from warehouse w to end-user j through transport mode k'  
/ 
$ondelim 
$include data_ctt.csv 
$offdelim 
/

 cttt(i,m,j,k) 'Per unit cost of shipment of product i from plant m to end-user j through transport mode k'
 /
$ondelim
$include data_cttt.csv
$offdelim
/

 p(i,h) 'processing time of a unit of product i with technology h'
 /
$ondelim
$include data_p.csv
$offdelim
/

 pp(i) 'volume of a unit of product i (m3)'
 /
$ondelim
$include data_pp.csv
$offdelim
/

 alpha(r,i) 'amount of raw material r required in production of a unit of product i (kg)'
 /
$ondelim
$include data_alpha.csv
$offdelim
/

 c(m,h,u) 'production capacity (time) in plant m with technology h and capacity u (h)'
 /
$ondelim
$include data_c.csv
$offdelim
/

 cc(w,v) 'holding capacity in warehouse w with capacity level v (m3)'
 /
$ondelim
$include data_cc.csv
$offdelim
/

 ccc(r,n) 'raw material capacity for raw material r in supplier n (kg)'
 /
$ondelim
$include data_ccc.csv
$offdelim
/

 lb(m,w,k) 'minimium allowed transportation from plant m to warehouse w through mode k (m3)'
 /
$ondelim
$include data_lb.csv
$offdelim
/

 lbb(w,j,k) 'minimium allowed transportation from warehouse w to end-user j through mode k (m3)'
 /
$ondelim
$include data_lbb.csv
$offdelim
/

 lbbb(m,j,k) 'minimium allowed transportation from plant m to end-user j through mode k (m3)'
 /
$ondelim
$include data_lbbb.csv
$offdelim
/



 ub(m,w,k) 'Maximum allowed transportation from plant m to warehouse w through mode k (m3)'
 /
$ondelim
$include data_ub.csv
$offdelim
/

 ubb(w,j,k) 'Maximum allowed transportation from warehouse w to end-user j through mode k (m3)'
 /
$ondelim
$include data_ubb.csv
$offdelim
/

 ubbb(m,j,k) 'Maximum allowed transportation from plant m to end-user j through mode k (m3)'
 /
$ondelim
$include data_ubbb.csv
$offdelim
/

 em(i,m,h) 'estimated carbon emissions to produce a unit of product i with technology h in plant m (ton)'
 /
$ondelim
$include data_em.csv
$offdelim
/

 et(i,m,w,k) 'estimated carbon emissions for shipping a unit of product i from plant m to warehouse w through mode k (ton)'
 /
$ondelim
$include data_et.csv
$offdelim
/


 ett(i,w,j,k) 'estimated carbon emissions for shipping a unit of product i from warehouse w  to end-user j through mode k (ton)'
 /
$ondelim
$include data_ett.csv
$offdelim
/



 ettt(i,m,j,k) 'estimated carbon emissions for shipping a unit of product i from plant m to end-user j through mode k (ton)'
 /
$ondelim
$include data_ettt.csv
$offdelim
/


 l_t(m,h) ' Conversion Parameter of fixed costs of establishing plant m with technology h into annual equivalent'
 /
$ondelim
$include data_lt.csv
$offdelim
/

 ltt(w) ' Conversion Parameter of fixed costs of establishing warehouse w into annual equivalent'
 /
$ondelim
$include data_ltt.csv
$offdelim
/

 pc(i,j) 'penalty  cost for shortage of a unit of product i in end-user j'
 /
$ondelim
$include data_pc.csv
$offdelim
/

 ps(s) 'probability of scenario s'
 /
$ondelim
$include data_ps.csv
$offdelim
/
;

variable

VQ(i,m,h,s) 'amount of product i produced in plant m with technology h in scenario s'

VR(r,n,m,s) 'amount of raw material r shipped from supplier n to plant m in scenario s'

VL(i,m,w,k,s) 'amount of product i shipped from plant m to warehouse w through technology k in scenario s'

VLL(i,w,j,k,s) 'amount of product i shipped from warehouse w through technology k in scenario s'

VLLL(i,m,j,k,s) 'amount of product i shipped from plant m to end-user j through technology k in scenario s'

VO(i,j,s) 'amount of shortage for product i in end-user j in scenario s'

VE(s) 'Net number of carbon credits traded in scenario s'

;

positive variable
VQ
VR
VL
VLL
VLLL
VO
;


binary variable

VF(m,h,u) '1 if manufacturing plant m with technology h and capacity u is estimated 0 otherwise'

VFF(w,v) '1 if warehouse w with capacity level v is estimated, 0 otherwise'

VFFF(n) '1 if supplier n is selected, 0 otherwise'

VG(m,w,k,s) '1 if there is a flow between plant m and warehouse w through mode k in scenario s , 0 otherwise'

VGG(w,j,k,s) '1 if there is a flow between warehouse w and end-user j through mode k in scenario s, 0 otherwise'

VGGG(m,j,k,s) '1 if there is a flow between plant m and end-user j through mode k in scenario s, 0 otherwise'

;

variable

z 'overall SCND costs at strategic and tactical level'

;

equation

cost 'objective function'

row1 '(8) enforces the budget limitation for the establishment of manufacturing plants and warehouses'

row2(m) '(9) ensure that no more than one facility can be established in each candidate location'

row3(w) '(10) ensure that no more than one facility can be established in each candidate location'

row4(s) '(11) carbon credit limitation at each scenario by substracting the production and transport emissions from regular cap.'

row5(m,h,s) '(12) enforce the capacity limitation of the manufacturing plants'

*row6(w,s) '(13) enforce the capacity limitation of the warehouse'

row7(r,n,s) '(14) formulates the limitation in raw material provision by suppliers'

row8(r,m,s) '(15) guarantees the fulfillment of raw material requirement in the manufacturing plants'

row9(i,m,s) '(16) enforce the flow balance in manufacturing plant'

row10(i,w,s) '(17) enforce the flow balance in warehouse'

row11(i,j,s) '(18) enforce the flow balance in end-user'

row12(m,w,k,s) '(19)  impose the product flow limitations between different supply chain participants'

row13(m,w,k,s) '(19)  impose the product flow limitations between different supply chain participants1'

row14(w,j,k,s) '(20) mpose the product flow limitations between different supply chain participants'

row15(w,j,k,s) '(20) mpose the product flow limitations between different supply chain participants1'

row16(m,j,k,s) '(21) mpose the product flow limitations between different supply chain participants'

row17(m,j,k,s) '(21) mpose the product flow limitations between different supply chain participants1'

;

cost .. z =e=   
              sum((m,h,u),l_t(m,h)*f(m,h,u)*VF(m,h,u))
              + sum((w,v),ltt(w)*ff(w,v)*VFF(w,v))
              + sum(n,fff(n)*VFFF(n))
              + sum(s,ps(s)*sum((i,m,w,k),ct(i,m,w,k)*VL(i,m,w,k,s)))
               + sum(s,ps(s)*sum((i,w,j,k),ctt(i,w,j,k)*VLL(i,w,j,k,s)))
              + sum(s,ps(s)*sum((i,m,j,k),cttt(i,m,j,k)*VLLL(i,m,j,k,s)))
              + sum(s,ps(s)*sum((i,m,h),cm(i,m,h)*VQ(i,m,h,s)))
              + sum(s,ps(s)*sum((r,n,m),cs(r,n,m)*VR(r,n,m,s)))
             +  sum(s,ps(s)*sum((i,j),pc(i,j)*VO(i,j,s)))
             + sum(s,ps(s)*pai(s)*VE(s))
              ;

row1 .. sum((m,h,u),f(m,h,u)*VF(m,h,u)) + sum((w,v),ff(w,v)*VFF(w,v)) =l= b;

row2(m) .. sum((h,u),VF(m,h,u)) =e= 1;

row3(w) .. sum(v,VFF(w,v)) =e= 1;

row4(s) .. sum((i,m,w,k),et(i,m,w,k)*VL(i,m,w,k,s)) 
           + sum((i,w,j,k),ett(i,w,j,k)*VLL(i,w,j,k,s))
           + sum((i,m,j,k),ettt(i,m,j,k)*VLLL(i,m,j,k,s))
           + sum((i,m,h),em(i,m,h)*VQ(i,m,h,s))
           -cap =e= VE(s);

row5(m,h,s) .. sum(i,p(i,h)*VQ(i,m,h,s)) =l= sum(u,c(m,h,u)*VF(m,h,u));

*row6(w,s) .. sum((i,m,k),pp(i)*VL(i,m,w,k,s)) =l= sum(v,cc(w,v)*VFF(w,v)); 

row7(r,n,s) .. sum(m,VR(r,n,m,s)) =l= ccc(r,n)*VFFF(n);

row8(r,m,s) .. sum((i,h),alpha(r,i)*VQ(i,m,h,s)) =e= sum(n, VR(r,n,m,s));

row9(i,m,s) .. sum(h, VQ(i,m,h,s))  =e= sum((w,k),VL(i,m,w,k,s)) + sum((j,k),VLLL(i,m,j,k,s));

row10(i,w,s) .. sum((m,k),VL(i,m,w,k,s)) =e= sum((j,k),VLL(i,w,j,k,s));

row11(i,j,s) .. sum((w,k),VLL(i,w,j,k,s)) + sum((m,k),VLLL(i,m,j,k,s)) + VO(i,j,s) =e= d(i,j,s);

row12(m,w,k,s) .. lb(m,w,k)*VG(m,w,k,s) =l= sum(i,pp(i)*VL(i,m,w,k,s));

row13(m,w,k,s) ..   sum(i,pp(i)*VL(i,m,w,k,s)) =l= ub(m,w,k) * VG(m,w,k,s);

row14(w,j,k,s) .. lbb(w,j,k)*VGG(w,j,k,s) =l= sum(i,pp(i)*VLL(i,w,j,k,s));

row15(w,j,k,s) ..  sum(i,pp(i)*VLL(i,w,j,k,s)) =l= ubb(w,j,k)*VGG(w,j,k,s);

row16(m,j,k,s) ..  lbbb(m,j,k)*VGGG(m,j,k,s) =l= sum(i,pp(i)*VLLL(i,m,j,k,s));

row17(m,j,k,s) ..  sum(i,pp(i)*VLLL(i,m,j,k,s)) =l= ubbb(m,j,k)*VGGG(m,j,k,s);


Model supplychain / ALL /;

solve supplychain using MIP minimizing z;


display VF.l;

display VFF.l;

display VFFF.l;

display VG.l;

display VGG.l;

display VGGG.l;

display VQ.l;
display VR.l;
display VL.l;
display VLL.l;
display VLLL.l;
display VO.l;
display VE.l;
