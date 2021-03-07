function [Xt, Xt_th] = Xt_M_ANN(Tf, Vf, Ef, Em)
% This function compute Xt of a unidirectional composite
%
% The entries are: 
%    - Tensile strength of the fiber (Tf)
%    - Volumetric fraction of fiber (Vf)
%    - Longitudinal elasticity modulus of the fiber (Ef), in GPa
%    - Elasticity modulus of the matrix (Em), in GPa

% The outputs are:  
%    - Ultimate longitudinal tensile strength of the laminae (Xt), in GPa, from Mix-ANN
%    - Ultimate longitudinal tensile strength of the laminae (Xt_th), in GPa, from the Rule of Mixture

% Mix-ANN - Mixed artificial neural network

% For more information see this webpage:
% https://github.com/giobrol/ANN_functions

if Tf>7.5
    warndlg('The value of Tf must be less than 7.5','Warning!');
end
if Ef>600
    warndlg('The value of Ef must be less than 600','Warning!');
end
if Em>6
    warndlg('The value of Em must be less than 6','Warning!');
end
if Vf>0.75
    warndlg('The value of Vf must be less than 0.75','Warning!');
    return;
end


%%%%% Function Xt = f(Tf, Vf, Ef, Em)
%% Data Normalization
Tf_nor = Tf/7.5;
Ef_nor = Ef/600;
Em_nor = Em/6;


%% Theoric Equation Value
EmEf = Em/Ef;
Xt_th = Tf*(Vf*(1-EmEf)+EmEf);  % Show Theoric Equation Xt value


%% ANN Mixed Weights
W = [1.34019285822923 -2.11343330293025 0.417252051585717 -0.764900920750982 -1.33571487197654;...
2.72260226496353 -0.927222419505371 -0.0880107001918007 -0.811513740548181 2.93612167952129;...
0.379478599967711 -1.96168741988126 -2.33565113116648 0.811595822707385 -0.782017105411170;...
3.24796309915303 -3.74103930519307 7.84414235983405 -2.60314268070818 -5.49874113698663;...
1.27389398530372 -1.57859446546770 -1.79257129312802 0.968596712769823 -2.55634856471968;...
1.83677124687788 -1.46818608487740 -0.144894903980239 -0.885509026541172 -0.231474763388013;...
1.72751479075310 -1.89156576903032 0.0702981884559323 -0.349076695414470 0.225382343101496;...
0.897093726972504 -2.09887870584155 -1.29845668267756 0.482967043703571 0.0636027920238218;...
1.45089549364526 -1.51956865915285 -0.600403562698813 0.186807705639405 -2.30072163014559;...
-0.752518191452454 -5.22511994626289 0.854115917345125 -2.82502162073348 0.0652058531145139;...
0.825524441046246 -1.35207488742083 -1.76978794583902 -0.689436155751321 -0.438192812008462;...
0.833073322878087 -1.81769615199839 -0.493791470987422 -1.54395639238971 -1.61610266863414;...
1.10657797011660 -2.02236983153938 -0.527445673816599 -0.467557473024818 -1.23763057406387;...
1.64837896841028 -1.97483345715793 0.823073970455252 -0.814112305427054 -1.26353639147088;...
2.96629479616987 0.0102013204622492 1.29566311952975 -2.46881194602745 1.80717968166378;...
1.67656130387999 -1.68264726848635 -0.631235755430325 0.0593071100588183 0.518508321833755;...
1.89278055615394 -0.892763688190095 -1.14872784553233 -0.178211245941217 0.364975606659829;...
2.86580162119844 0.0372661321330567 0.473607315852324 -0.480418805100687 -0.652241952148936;...
1.32392223101399 -0.417278037400191 -1.10933754947659 -1.52312897956906 -0.798899255127533;...
0.839262815296784 -1.70018773042894 -0.0997672163672453 -2.08759833336317 -1.32206534563066;...
1.86109420452992 -1.85519431304869 0.883865216516133 -0.570333218441022 -1.36634588380539;...
0.943286563825789 -1.52272451560380 -0.963700032554851 -0.840190894656926 -1.21761522748037;...
1.58354363667313 -0.425931362362542 0.574930313923716 -1.55977605232268 -1.60606741265084;...
1.48176848571483 -1.50236105677924 -0.552229284874098 -0.888303496156937 -0.409595065820771;...
-0.0119920372507423 -4.16985003076743 0.347878337066231 -2.17828928989646 -0.698276429920145;...
0.0391498994318534 1.22485868986750 1.87149635758735 -4.13361560198273 -2.57292490467313;...
2.19827388500424 -0.471371160340051 -0.492136702842137 -0.682930293783469 -0.360430152549797;...
2.17011924025026 -0.0953179809956217 -1.54040218404179 0.486197757202396 -2.55154544143053;...
-0.145803214479873 -2.19702859726123 -2.43280443579576 1.27075986722417 -0.392336458508803;...
2.09588889953843 -1.38053042151021 0.314378977696358 -0.0971920223158860 -1.19791335702190;...
1.32420806547757 -0.954085237871785 -1.56760256889031 -1.19173721635296 1.23165324640124;...
0.963157854908094 -0.218761682860164 -0.0705487296427969 -2.59153640950192 -1.47206270512556;...
1.18269102900694 -1.65973795545967 -1.72828693728739 -0.0162523654993505 -1.86028334338426;...
0.831542431325961 -4.85568420959024 -0.525949457331845 0.849254680097159 -0.442275554094500;...
1.67773526667922 -0.762204593301718 -1.32649022804012 -0.779111421584440 0.279474944354910;...
1.92327710735247 -0.0667717024687865 -1.10668000411666 -0.322328214100736 -1.36123226621192;...
3.01443659753654 5.69925479696972 -4.84697320221329 -0.324326565424522 0.799563671145032;...
1.66336030054518 -0.985095890907601 -1.76279317689563 0.744622343050410 -0.609833705191350;...
1.25855783525110 -0.600608563020496 -1.51117617149283 -3.20587469921220 -0.0168691923435576;...
3.10393423486862 -1.53914629065242 1.67089674514601 -2.04907011593499 -0.386403284080640;...
0.817550519026753 -2.04694886561303 -1.25377798046748 0.132235847560302 0.941328856284426;...
2.43253612505622 -1.75605673834674 0.111473081214842 0.699046100680434 0.628821169081931;...
2.30596381510612 -0.305266220543868 -0.827199301685886 -0.461067890142392 -0.215319364933641;...
0.227838094433799 -2.20291473622359 -1.28802712711499 -2.59023457510776 -0.131522578097758;...
0.985066885293068 -2.04406867365196 -1.17610551118393 0.334631389392840 -1.66444452363433;...
1.98242850202751 -0.875307221690210 0.0280658401480496 -0.120410257270204 -1.84173157958926;...
-0.0909892232201022 0.775463646697556 -8.26042332991428 1.41054386305960 4.42668630050835;...
2.22451295349527 -1.96916960261310 -0.225754098876128 0.843306668975150 0.162644904854796;...
1.92721652059707 -0.646828344278690 -0.254224168299212 -0.165649086421215 -1.77927111695052;...
2.35713440622368 0.303152301805646 -1.13388786623917 -0.869049044489746 -0.225904935454173;...
0.107724763349079 -1.18753081383283 -2.69113602102049 1.62063673461122 -1.19703635831682;...
1.36556909149532 -0.261072701678030 0.297250086850287 -2.25206799066290 -1.42519617528072;...
3.74145769827370 -0.382763474078880 2.99592137976147 2.10815247859000 -2.83400207728565;...
0.882492526522437 -1.74161402664948 -0.00846326013186843 -2.61955942253353 -0.507281963474176;...
0.798420996656115 -1.85203913967624 -1.77548711480143 0.387534797110244 0.919134064582246;...
2.02523760331245 -0.510322630049235 -0.285084668507705 -0.871505505651731 -0.617320601318072;...
2.06372468326118 -0.165224521530107 0.168848762786929 -0.0936770380454754 -2.10239141245841;...
1.51534515582340 -0.868682129817647 -0.514447872579834 -1.53629450318483 0.284652418084153;...
1.30044818253735 -1.81629203796698 -0.0789318205981245 -1.16072957845461 -0.428178693477834;...
1.71677322124745 -0.412125821846505 -0.837609382915830 -1.74632075585396 -0.559237486567672;...
2.77181741678290 -0.630941080433327 1.00557413134205 0.141513837861974 -1.13339617455444;...
0.182002754133724 -3.61645897357664 0.477832971932483 -0.854817156981506 -1.38412622109032;...
2.71442595666991 -0.299522570357597 -0.944601354128085 0.240132699035496 -0.0136693851396481;...
1.33250910106590 -2.88142953479437 1.63036574598911 -1.15352134944799 -0.183333907433818];

V = [0.341616671648335;0.0272851688983607;1.83005537183057;0.933877191726344;4.44457372502786;0.418958262198201;...
0.212113213810804;0.435982672475981;0.771386939414562;0.0955543523039889;-2.32339236002260;0.499598495863970;...
-0.0687477456187209;0.188860240985719;0.151395530475438;1.13345260134648;0.616414463136169;0.517178636721356;...
-0.396629263714755;-0.100159563598360;-0.155030949085958;0.0878001182025523;0.316306606917552;-0.504302237953206;...
0.567410645416215;-1.35835035669416;-1.00778917938523;0.0221461343887007;-0.124915040544048;0.808185569147544;...
-0.155228786981586;0.535166593570149;-0.549710890430966;1.65289448220342;-2.07084243184811;0.330122034449183;...
-0.191215277630493;1.19690310518745;0.562632993497994;0.568662780500606;1.64359128689675;0.981368838242317;...
0.557029306696276;0.107480956253141;-0.419072662824765;0.363319955396898;-0.254811133340071;-1.51976706100983;...
0.336959855873681;-0.312975502228976;-0.0343297916281229;0.733390121969355;-0.824592022307131;-1.76044731578926;...
-0.380231989163237;0.976069180807491;-0.000527244057719816;-0.654056383639375;0.384647666525199;0.118536715455082;...
-0.580940193015198;-0.621969842879823;-0.0759425137040226;0.412472421450740;0.114047228332707];


%% Final Calculation
v = W*[-1; Vf; Tf_nor; Em_nor; Ef_nor];
y = 1./(1+exp(-v)); 
Xt_nor = V'*[-1;y];
Xt = 7.5*Xt_nor + Xt_th;

