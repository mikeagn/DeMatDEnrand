%********************************************************************
% Script file for the initialization and run of the differential 
% evolution optimizer.
%********************************************************************

% F_VTR		"Value To Reach" (stop when ofunc < F_VTR)
		F_VTR = -30000; 

% I_D		number of parameters of the objective function 
		I_D = 2; 

% FVr_minbound,FVr_maxbound   vector of lower and bounds of initial population
%    		the algorithm seems to work especially well if [FVr_minbound,FVr_maxbound] 
%    		covers the region where the global minimum is expected
%               *** note: these are no bound constraints!! ***
      FVr_minbound = -500*ones(1,I_D); 
      FVr_maxbound = 500*ones(1,I_D); 
      I_bnd_constr = 0;  %1: use bounds as bound constraints, 0: no bound constraints
            
% I_NP            number of population members
		I_NP = 20;  %pretty high number - needed for demo purposes only

% I_itermax       maximum number of iterations (generations)
		I_itermax = 50; 
       
% F_weight        DE-stepsize F_weight ex [0, 2]
		F_weight = 0.8; 

% F_CR            crossover probabililty constant ex [0, 1]
		F_CR = 1.0; 

% I_strategy     1 --> DE/rand/1:
%                      the classical version of DE.
%                2 --> DE/local-to-best/1:
%                      a version which has been used by quite a number
%                      of scientists. Attempts a balance between robustness
%                      and fast convergence.
%                3 --> DE/best/1 with jitter:
%                      taylored for small population sizes and fast convergence.
%                      Dimensionality should not be too high.
%                4 --> DE/rand/1 with per-vector-dither:
%                      Classical DE with dither to become even more robust.
%                5 --> DE/rand/1 with per-generation-dither:
%                      Classical DE with dither to become even more robust.
%                      Choosing F_weight = 0.3 is a good start here.
%                6 --> DE/rand/1 either-or-algorithm:
%                      Alternates between differential mutation and three-point-
%                      recombination.           

		I_strategy = 1

% I_refresh     intermediate output will be produced after "I_refresh"
%               iterations. No intermediate output will be produced
%               if I_refresh is < 1
      I_refresh = 1; 
      
% I_plotting    Will use plotting if set to 1. Will skip plotting otherwise.
      I_plotting = 1;
      
%-----Problem dependent constant values for plotting----------------
if (I_plotting == 1)      
   FVc_xx = [-1000:50:1000]';
   FVc_yy = [-1000:50:1000]';

   [FVr_x,FM_y]=meshgrid(FVc_xx',FVc_yy') ;
   FM_meshd = -FVr_x.*sin(sqrt(abs(FVr_x-FM_y-47)))-...
           (FM_y+47).*sin(sqrt(abs(0.5*FVr_x+FM_y+47)));
      
   S_struct.FVc_xx    = FVc_xx;
   S_struct.FVc_yy    = FVc_yy;
   S_struct.FM_meshd  = FM_meshd; 
end

S_struct.I_NP         = I_NP;
S_struct.F_weight     = F_weight;
S_struct.F_CR         = F_CR;
S_struct.I_D          = I_D;
S_struct.FVr_minbound = FVr_minbound;
S_struct.FVr_maxbound = FVr_maxbound;
S_struct.I_bnd_constr = I_bnd_constr;
S_struct.I_itermax    = I_itermax;
S_struct.F_VTR        = F_VTR;
S_struct.I_strategy   = I_strategy;
S_struct.I_refresh    = I_refresh;
S_struct.I_plotting   = I_plotting;

%********************************************************************
% Start of optimization
%********************************************************************

[FVr_x,S_y,I_nf] = deopt('objfun',S_struct)

