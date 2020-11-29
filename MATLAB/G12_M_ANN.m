function [G12, G12HT] = G12_M_ANN(Vf, Gf, Gm)
%This Function Calculate G12 from an composite laminae
%
% Na entrada, Vf é a fracao volumetrica, Gf o módulo de cisalhamento
% da fibra (GPa) e Gm o módulo de cisalhamento da matriz (GPa)
% e a saída G12 representa modulo de cisalhamento 12 da lâmina
% obtida pela RNA mista (GPa) e G12HT representa modulo de
% cisalhamento 12 da lamina obtido pelo modelo de Halpin-Tsai (GPa) 

if Gf>35
    warndlg('O valor de Gf deve ser inferior a 35','Erro em Gf');
end
if Gm>5
    warndlg('O valor de Gm deve ser inferior a 5','Erro no Gm');
end
if Vf>1
    warndlg('O valor de Vf deve ser inferior a 1','Erro em Vf');
    return;
end

%% Data Normalization
Gf_nor = Gf/35;
Gm_nor = Gm/5;

%% Halpin-Tsai Value
N = (((Gf./Gm)-1)./((Gf./Gm)+1));
G12HT = ((1+(1.*N.*Vf))./(1-(N.*Vf))).*Gm; % Show Halpin-Tsai G12 value

%% ANN Mixed Weights
W = [0.904501495169897 -0.732962542506221 -1.10031623912822 -0.0169106537228290;...
1.65152831087905 -0.0898149343348349 0.0601854327475415 -1.01666324790509;...
0.429143194247627 1.01441013120780 -1.17938739117491 -0.262950845379462;...
1.18190358134663 0.295282541598956 -0.354590778830437 -0.926796633957698;...
1.77647895100643 0.621924755792254 -0.356569140071153 -0.621993401356600;...
1.99057788831043 0.340445868623530 0.219040120466058 0.304206824451166;...
0.426463162631718 -1.29838357867685 -0.392367604875972 -1.37005383632878;...
1.81909575549882 -1.17981079213042 0.487700726319012 -0.872555656989080;...
1.28026619051781 -1.58680893291405 -0.932605582738139 -0.905490646087118;...
1.49549234930748 -0.136700409456310 0.0816765595944273 -0.673936596159084;...
2.21120916196665 0.729339628443358 -0.208265993960689 0.808377422893991;...
1.74949598840430 0.786124674048392 -0.589346533521733 0.503010811249733;...
1.36390487462475 -0.0482527123861492 -0.791449576127624 0.752869890803265;...
1.99328067185958 1.77470995827467 -1.06689484378075 0.834093847266677;...
1.68638391407995 1.34098708889705 -0.812186712155029 -1.31138492635243;...
1.39353947932850 2.28403640810104 1.03194512127867 -0.876252927272612;...
-0.374899125646311 0.834190974211124 1.48401777510450 -0.0170292489938654;...
1.09169764983753 -0.262545773645599 -1.46339451545501 -1.11660777416223;...
-0.557620188217007 -1.47678352057030 -1.91509615773542 -1.73046679252324;...
1.52996350374241 -0.695899602380577 0.449315613824118 -0.587239391912163;...
2.36145018693409 -0.159519150723702 1.18529046464206 -0.0829869492691572;...
1.49645576062267 0.532058138788893 -0.792807338239917 -1.57786916489971;...
1.73624552647652 -0.0205883473701250 0.710416687341606 -0.733977027944323;...
1.18216921187375 0.738197439256189 -0.573172873222823 -1.14081333132149;...
1.61838752188081 0.118572802921070 0.187583064294777 -0.409669849621191;...
0.707053701903568 -0.291895323605036 -2.04086024395948 0.0698239075513976;...
1.16188273481555 0.278420859649787 -0.775537790153550 -0.794849379860682;...
0.421299408593181 -1.43197076465836 -1.31814795725475 -1.38091587460490;...
0.579119264106171 0.426878963981852 -2.89173490937931 -0.433485817786692;...
1.22220599250140 0.550984677851230 -0.585911866034365 -0.961288042117110;...
-0.0118490355006459 0.131773648486132 1.95065438880745 -1.25374329771622;...
1.34457482325423 -0.932503759907987 0.142379962738293 -0.266602720617376;...
0.739660468403564 -0.667138610654808 -0.546805389630012 -1.09985236357455;...
1.89263710431715 -0.275401963583968 0.0347328609551545 -0.940491934271736;...
1.49777456505060 1.88565274472418 -1.49433564271601 -0.394760284452966;...
1.61211415954334 -0.518910082323899 -0.486849520613947 0.775342510296288;...
1.60629925963877 0.217926080507593 -0.757688072393170 -0.812199257237172;...
2.22822235283843 0.856120993733906 0.832671363608230 -0.227352950738476;...
0.568059442062223 -0.504300101084840 -0.957243930024090 -0.552300675796784;...
2.04142291663240 1.11647957802227 0.489801860004290 -0.588302424998387;...
1.79547699593793 -0.392763874241252 -0.0495479396196319 0.404642751551086;...
0.939570182887044 -1.82811261350908 -0.406919068940795 1.39002898109866;...
0.884449809272167 -0.392471761083481 0.730652061901107 -0.607853271574349;...
1.43219936767236 -2.10963386784855 1.21859767228708 -0.869775862852181;...
1.01114175422323 -0.767768474734039 0.506053943839077 -1.45008259601502;...
0.424453162396071 -0.706862305068901 -1.10592643080077 -1.60889995964271;...
1.09289333876722 -1.04478971635006 -0.542874632029530 0.765785086570659;...
1.70310746756417 2.69171567579954 -1.39559941704547 -1.72225160054352;...
1.44233009465335 -0.644584505308127 -1.60078026702794 -0.130680003886270;...
1.36202389130448 0.564311652505377 -0.645453247698263 0.345578289999754;...
1.31375360144599 -1.88939415774181 -0.215110945632627 0.963742209732285;...
2.03489837365392 -0.0208444963066911 -0.450218184388636 -0.560594040843390;...
0.936063374298192 0.0189789391183887 -1.66025843705256 0.394876607967784;...
1.29970124595642 -1.00904220052088 -0.0251765056359150 0.871315515341747;...
0.476064193256058 0.0727987659870648 -2.35261153389355 -0.849924910150844;...
1.08739968098390 0.422052722344416 -0.430233963154267 0.232810824274279;...
0.902769861373102 -0.985468409724746 0.211069410741752 -1.73278102640837;...
2.04172551541740 1.57242271976285 0.204932046194688 -0.624387390763449];
V = [0.337850195018696;0.574212824773231;-0.178390222150637;0.138473034045021;0.242864560120400;...
0.314189936604417;0.191579704626609;0.132856420163119;-0.616084410268262;-0.0568300535349858;...
0.124215541245348;0.0175650222463690;0.0330421473146608;-0.138328465820544;0.0497702316123693;...
-0.0455050800468878;-0.110401020349824;-0.994490030122524;-0.0652071599230732;-0.118256345093328;...
-0.0525451887119390;0.645125892304228;-0.288482187006619;0.329533135919518;0.277176334798089;...
0.297535136258053;-0.749918967762962;0.240423731598040;0.0230501352645603;-0.997783420052780;...
0.234742949977235;0.0197640527559389;0.178525796850271;0.232893222140962;-0.440153257670801;...
0.108405461664142;0.350038217254457;0.478146790356998;0.687010236885726;0.135189303023827;...
0.615766349200259;0.0167991464764703;0.223397071900884;0.618766790595930;-0.536310090356655;...
0.189333612637342;-0.194885498596088;-0.140069297891083;0.0961079912284528;0.975032655878019;...
0.265317492146779;-0.0229930229174382;-0.565994159669389;-0.0431044911912636;0.285628440707198;...
0.0176703594690304;0.543907075621024;0.179605905459880;0.857715779267907];

%% Final Calculation
v = W*[-1; Vf; Gf_nor; Gm_nor];
y = 1./(1+exp(-v));
G12_nor = V'*[-1;y];
G12 = G12_nor*4+G12HT;

