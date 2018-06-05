$title  'pvc model for ANOR journal'

$onText

PVC供应链模型：
1）两个供应商 一个是用油制作原材料， 一个是用煤做原材料
2）原材料一种
3）工厂3个 (第三个工厂规模是第二个的一半)
4）产品3种
5) 运输模式3种
6）仓库2个
7) 客户2个                
$offText

Set
  
   s 'supplier'              / PVC-oil,  PVC-calcium /
   f 'plant'                 / plant_1, plant_2, plant_3 /
   w 'warehouse'             / warehouse_1, warehouse_2 /
   c 'customer'              / customer_1, customer_2 /
   t 'transport mode'        / road,  rail, barge /
   p 'product'               / p_50, p_75, p_110 /
   ;

 
Scalar cp       'carbon price (yuan),stohastic parameter, uniform distribution'   / 30 /
       lostper  '原材料生产成成品损耗系数，0.7代表 1吨原材能加工0.7吨成品'              / 0.7 /
    ;

Parameter
   sem(s) 'CO2 emissions(ton) for puducting one ton raw material in supplier s'
   /
      PVC-oil      1.9
      PVC-calcium  7.5
   /
   scap(s) 'capacity (ton) of supplier s'
   /
      PVC-oil      90000
      PVC-calcium  120000
   /
   sprc(s) 'price (yuan) of one ton raw material for supplier s'
   /
      PVC-oil      7100
      PVC-calcium  6900
   /

   fcap(f) 'total capacity (ton) in plant f'
   /
      plant_1      67800
      plant_2      85000
      plant_3      42500
   /
  fce(f) 'annual fixed costs (yuan) of establishing plant f'
  /
      plant_1     7550000
      plant_2     9475000
      plant_3     4737500
  / 

  pcep(p) 'Fixed costs(yuan) of producing one ton of product p'
  /
      p_50        700
      p_75        700
      p_110       700
  /

 wcap(w) 'total capacity (ton) in warehouse w'
   /
      warehouse_1      60000
      warehouse_2      80000
   /
 wce(w) 'annual fixed costs (yuan) of establishing warehouse w'
  /
      warehouse_1     2100000
      warehouse_2     2400000
  /
  wcep(w) 'Fixed costs(yuan) of producing one ton of any product'
  /
      warehouse_1        700
      warehouse_2        600
  /


* (22/1.97)*1000
  pup(p) 'price (yuan) per ton of product p'
  /
      p_50         11168
      p_75         9726
      p_110        10134
  /
  pemp(p) 'CO2 emissions(ton) for producing one ton of product p'
  /
      p_50         0.00025
      p_75         0.00022
      p_110        0.00019 
  /
  
  sfcost(s,f,t) 'shipping cost (yuan per km per ton) from supplier s to plant f in transport mode t'
  /
      PVC-oil          .plant_1    .road      .53
      PVC-oil          .plant_1    .rail      .15
      PVC-oil          .plant_1    .barge     .17
      PVC-oil          .plant_2    .road      .53
      PVC-oil          .plant_2    .rail      .15
      PVC-oil          .plant_2    .barge     .17
      PVC-oil          .plant_3    .road      .53
      PVC-oil          .plant_3    .rail      .15
      PVC-oil          .plant_3    .barge     .17
      PVC-calcium      .plant_1    .road      .53
      PVC-calcium      .plant_1    .rail      .15
      PVC-calcium      .plant_1    .barge     .17
      PVC-calcium      .plant_2    .road      .53
      PVC-calcium      .plant_2    .rail      .15
      PVC-calcium      .plant_2    .barge     .17
      PVC-calcium      .plant_3    .road      .53
      PVC-calcium      .plant_3    .rail      .15
      PVC-calcium      .plant_3    .barge     .17
  /

  fwcost(f,w,t) 'shipping cost (yuan per km per ton) from  plant f  to warehouse w in transport mode t'
  /   
      plant_1    .warehouse_1      .road      .65
      plant_1    .warehouse_1      .rail      .32
      plant_1    .warehouse_1      .barge     .15
      plant_1    .warehouse_2      .road      .65
      plant_1    .warehouse_2      .rail      .32
      plant_1    .warehouse_2      .barge     .15
      plant_2    .warehouse_1      .road      .65
      plant_2    .warehouse_1      .rail      .32
      plant_2    .warehouse_1      .barge     .15
      plant_2    .warehouse_2      .road      .65
      plant_2    .warehouse_2      .rail      .32
      plant_2    .warehouse_2      .barge     .15
      plant_3    .warehouse_1      .road      .65
      plant_3    .warehouse_1      .rail      .32
      plant_3    .warehouse_1      .barge     .15
      plant_3    .warehouse_2      .road      .65
      plant_3    .warehouse_2      .rail      .32
      plant_3    .warehouse_2      .barge     .15
     
  /

  wccost(w,c,t) 'shipping cost (yuan per km per ton) from warehouse w to customer c in transport mode t'
  /   
      warehouse_1  .customer_1    .road      .71
      warehouse_1  .customer_1    .rail      .33
      warehouse_1  .customer_1    .barge     .21
      warehouse_1  .customer_2    .road      .71
      warehouse_1  .customer_2    .rail      .33
      warehouse_1  .customer_2    .barge     .21
      warehouse_2  .customer_1    .road      .71
      warehouse_2  .customer_1    .rail      .33
      warehouse_2  .customer_1    .barge     .21
      warehouse_2  .customer_2    .road      .71
      warehouse_2  .customer_2    .rail      .33
      warehouse_2  .customer_2    .barge     .21

  /

  sfdis(s,f,t)    'distance (km) from supplier s to plant f in transport mode t'
  /
      PVC-oil          .plant_1    .road      300
      PVC-oil          .plant_1    .rail      600
      PVC-oil          .plant_1    .barge     900
      PVC-oil          .plant_2    .road      400
      PVC-oil          .plant_2    .rail      800
      PVC-oil          .plant_2    .barge     1200
      PVC-oil          .plant_3    .road      500
      PVC-oil          .plant_3    .rail      1000
      PVC-oil          .plant_3    .barge     1500
      PVC-calcium      .plant_1    .road      400
      PVC-calcium      .plant_1    .rail      800
      PVC-calcium      .plant_1    .barge     1200
      PVC-calcium      .plant_2    .road      500
      PVC-calcium      .plant_2    .rail      1000
      PVC-calcium      .plant_2    .barge     1500
      PVC-calcium      .plant_3    .road      600
      PVC-calcium      .plant_3    .rail      1200
      PVC-calcium      .plant_3    .barge     1800
  /

  fwdis(f,w,t) 'distance (km)  from  plant f  to warehouse w in transport mode t'
  /   
      plant_1    .warehouse_1      .road      200
      plant_1    .warehouse_1      .rail      300
      plant_1    .warehouse_1      .barge     500
      plant_1    .warehouse_2      .road      300
      plant_1    .warehouse_2      .rail      400
      plant_1    .warehouse_2      .barge     600
      plant_2    .warehouse_1      .road      210
      plant_2    .warehouse_1      .rail      310
      plant_2    .warehouse_1      .barge     510
      plant_2    .warehouse_2      .road      310
      plant_2    .warehouse_2      .rail      410
      plant_2    .warehouse_2      .barge     610
      plant_3    .warehouse_1      .road      220
      plant_3    .warehouse_1      .rail      340
      plant_3    .warehouse_1      .barge     540
      plant_3    .warehouse_2      .road      240
      plant_3    .warehouse_2      .rail      360
      plant_3    .warehouse_2      .barge     560 
  /


  wcdis(w,c,t) 'distance (km) from warehouse w to customer c in transport mode t'
  /   
      warehouse_1  .customer_1    .road      100
      warehouse_1  .customer_1    .rail      300
      warehouse_1  .customer_1    .barge     600
      warehouse_1  .customer_2    .road      150
      warehouse_1  .customer_2    .rail      450
      warehouse_1  .customer_2    .barge     900
      warehouse_2  .customer_1    .road      110
      warehouse_2  .customer_1    .rail      330
      warehouse_2  .customer_1    .barge     660
      warehouse_2  .customer_2    .road      160
      warehouse_2  .customer_2    .rail      500
      warehouse_2  .customer_2    .barge     1000
  /

  tem(t) 'CO2 emissions(ton/(ton,km) in transport mode t'
  /
    road   .00007
    rail   .000035
    barge  .00004
  /

  dmcp(c,p) 'demand (tons) of product p of customer c'
  /
   customer_1  .p_50  19680
   customer_1  .p_75  34524
   customer_1  .p_110 14095
   customer_2  .p_50  25584
   customer_2  .p_75  25318
   customer_2  .p_110 10086
  /
;

positive variable


VRP(s,f) 'amount of raw material (tons) purchased from supplier s in plant f'

VRSF(s,f,t) 'amount of raw material (tons) shipped from supplier s to  plant f with transport mode t'

VPFW(p,f,w,t) 'amount of product p (tons) shipped from plant f to warehouse w with transport mode t'

VPWC(p,w,c,t) 'amount of product p (tons) shipped from warehouse w  to customer c with transport mode t'

VPS(p,f) 'amount of product p (tons) produced from plant f'

;


*binary variable

*VSB(s) '1 if supplier s is established, 0 otherwise'

*VFB(f) '1 if plant f is established 0 otherwise'

*VWB(w) '1 if warehouse w is established, 0 otherwise'

*;

variable

z 'overall costs'
sc 'cost of suppliers'
pc 'cost of plants'
pf 'profit of plants'
icm 'income'

;



*  1 sum((s,f), sprc(s)*VRP(s,f)*VFB(f))                             原材料购买成本
*  2 sum((s,f), cp*sem(s)*VRP(s,f)*VSB(s))                            原材料生产二氧化碳排放成本
*  3 sum((p,f), pcep(p)*VPS(p,f)*VFB(f))                             产品生产成本
*  3a sum((p,f), cp*pemp(p)*VPS(p,f))                                  产品生产二氧化碳成本
*  4 sum(f,fce(f)*VFB(f)）                                           建厂固定成本（已经按年折算）
*  5 sum(w,wce(w)*VWB(w))                                            建仓库固定成本（已按年折算）
*  6 sum((p,f,w,t), wcep(w)*VPFW(p,f,w,t)*VFB(f)*VWB(w))             产品库存成本
*  7 sum((s,f,t),sfdis(s,f,t)*sfcost(s,f,t)* VRSF(s,f,t)*VSB(s))     运输成本: 原材料运输：从供应商到工厂
*  8 sum((p,f,w,t),fwcost(f,w,t)*fwdis(f,w,t)*VPFW(p,f,w,t)*VFB(f)*VWB(w)) 运输成本:  成品运输：从工厂到仓库
*  9 sum((p,w,c,t),wccost(w,c,t)*wcdis(w,c,t)*VPWC(p,w,c,t)*VWB(w))        运输成本:  成品运输：从仓库到客户
*  10 sum((s,f,t),cp*tem(t)*sfdis(s,f,t)*VRSF(s,f,t)*VSB(s))            原材料运输二氧化碳排放：供应商到工厂
*  11 sum((p,f,w,t),cp*tem(t)*fwdis(f,w,t)*VPFW(p,f,w,t)*VFB(f)*VWB(w)) 成品运输二氧化碳排放：从工厂到仓库
*  12 sum((p,w,c,t),cp*tem(t)*wcdis(w,c,t)*VPWC(p,w,c,t)*VWB(w))        成品运输二氧化碳排放：从仓库到客户

equation

cost           'objective function'

suppliercost   '供应商成本由  2 7 10 组成'

plantcost      '工厂成本由   1  3 4 5 6 8 9 11 12 组成'

income         '销售收入'

profit         'profit of plants'

row1(c,p)        '仓库运输到客户的产品量必须等于客户需求量 （假设Just in Time 库存模式）'

row2(p,w)        '入库等于出库'

row3(p)          '产量大于需求量'

row4(f)          '对于所有工厂，原材料满足生产'

row5(s)          '供应商最大产能约束'

row6(f)          '工厂产能约束'

row7(w)          '仓库容量约束'
;


suppliercost .. sc =e= sum((s,f), cp*sem(s)*VRP(s,f)) 
                      +sum((s,f,t),sfdis(s,f,t)*sfcost(s,f,t)*VRSF(s,f,t))
                      +sum((s,f,t),cp*tem(t)*sfdis(s,f,t)*VRSF(s,f,t));

plantcost..     pc =e= sum((s,f), sprc(s)*VRP(s,f))
                      +sum((p,f), pcep(p)*VPS(p,f)) 
                      +sum((p,f), cp*pemp(p)*VPS(p,f))  
                      +sum(f, fce(f)) 
                      +sum(w, wce(w)) 
                      +sum((p,f,w,t), wcep(w)*VPFW(p,f,w,t))
                      +sum((p,f,w,t),fwcost(f,w,t)*fwdis(f,w,t)*VPFW(p,f,w,t))
                      +sum((p,w,c,t),wccost(w,c,t)*wcdis(w,c,t)*VPWC(p,w,c,t))
                      +sum((p,f,w,t),cp*tem(t)*fwdis(f,w,t)*VPFW(p,f,w,t))
                      +sum((p,w,c,t),cp*tem(t)*wcdis(w,c,t)*VPWC(p,w,c,t));

cost ..         z =e=  sc + pc;

income..        icm =e= sum((p,f), pup(p)*VPS(p,f));

profit ..       pf =e=  icm-pc;

row1(c,p)..     dmcp(c,p) =e= sum((w,t),VPWC(p,w,c,t));

row2(p,w)..    sum((c,t),VPWC(p,w,c,t)) =e= sum((f,t),VPFW(p,f,w,t));

row3(p)..       sum(f, VPS(p,f)) =g= sum(c, dmcp(c,p));

row4(f) ..      sum(s,lostper*VRP(s,f)) =g= sum(p,VPS(p,f));

row5(s)..       scap(s) =g= sum(f,VRP(s,f));

row6(f)..       fcap(f) =g= sum((p,w,t), VPFW(p,f,w,t));

row7(w)..       wcap(w) =g= sum((p,f,t), VPFW(p,f,w,t));


Model supplychain / ALL /;


*sample  cp 6 method2
file emp / '%emp.info%'/; put emp '* problem %gams.i%' /;
$onput
randvar cp uniform 0 30
stage 2 cp suppliercost plantcost cost income profit
$offput
* Lindo can handle continuous distributions directly
* For other EMPSP solvers cp need to be sampled aqead of time
$if not '%gams.emp%'==lindo put 'sample cp 6';
putclose emp;


Set scen        scenarios / s1*s36 /;
Parameter
    s_cp(scen)  
    s_z(scen)
    s_pf(scen)
    s_o(scen,*)  scenario probability /#scen.prob 0 /;

Set dict / scen .scenario.''
           cp   .randvar .s_cp
           z    .level   .s_z
           pf   .level   .s_pf
           ''   .opt     .s_o /;

solve supplychain minimizing z use emp scenario dict;

display s_cp, s_z, s_pf, s_o;



