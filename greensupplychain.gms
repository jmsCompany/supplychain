$title  绿色供应链模型

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
  
   i 'product type'          / product1,  product2,  product3 /
   r 'raw material'          / r1, r2, r3 /
   n 'supplier'              / Queensland, South_Australia, Western_Australia /
   m 'plant'                 / New_South_Wales,  Victoria,  Queensland, South_Australia, Western_Australia /
   h 'technology'            / green, semi_green, pollutant /
   u 'plant capacity'        / small, medium, large /
   w 'warehouse'             / New_South_Wales,  Victoria,  Queensland, South_Australia, Western_Australia /
   v 'warehouse capacity'    / small, large /
   k 'transport mode'        / water_carriage, train, airplane /
   j 'customer'              / New_South_Wales,  Victoria,  Queensland, South_Australia, Western_Australia /
   s 'scenario'              / s1*s24 /;


Scalar b   'total budget'                                            / 30000000 /
       cap 'Maximum overall allowed carbon emissions (ton)'          / 10000    /;

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

 f(m,h,u) 'Fixed costs of establishing  plant m with technology h and capacity u'
 /
$ondelim
$include data_f.csv
$offdelim
/

  ff(w,v) 'Fixed costs of establishing  warehouse with capacity u'
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
/;

display pai;
display d;
display f;
display ff;
display fff;
display cm;
display cs;
display ct;
display ctt;
display cttt;

display p;
display pp;
display alpha;
display c;
display cc;
display ccc;