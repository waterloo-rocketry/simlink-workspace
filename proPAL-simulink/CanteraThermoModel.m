function CanteraThermoModel(block)
% Level-2 MATLAB file S-Function for times two demo.

%   Copyright 1990-2009 The MathWorks, Inc.

  setup(block);
%endfunction

function setup(block)

  persistent model;

  %% Register number of input port and output port
  block.NumInputPorts  = 3;
  block.NumOutputPorts = 3;
  
  %% Setup functional port properties
%   block.SetPreCompInpPortInfoToDynamic;
%   block.SetPreCompOutPortInfoToDynamic;

  block.InputPort(1).DatatypeID    = 0;
  block.InputPort(1).Complexity    = 0;
  block.InputPort(1).Dimensions    = 1;
  block.InputPort(1).SamplingMode  = 0;

  block.InputPort(2).DatatypeID    = 0;
  block.InputPort(2).Complexity    = 0;
  block.InputPort(2).Dimensions    = 1;
  block.InputPort(2).SamplingMode  = 0;

  block.InputPort(3).DatatypeID    = 0;
  block.InputPort(3).Complexity    = 0;
  block.InputPort(3).Dimensions    = 1;
  block.InputPort(3).SamplingMode  = 0;
  
  block.OutputPort(1).DatatypeID   = 0;
  block.OutputPort(1).Complexity   = 0;
  block.OutputPort(1).Dimensions   = 1;
  block.OutputPort(1).SamplingMode = 0;

  block.OutputPort(2).DatatypeID   = 0;
  block.OutputPort(2).Complexity   = 0;
  block.OutputPort(2).Dimensions   = 1;
  block.OutputPort(2).SamplingMode = 0;
  
  block.OutputPort(3).DatatypeID   = 0;
  block.OutputPort(3).Complexity   = 0;
  block.OutputPort(3).Dimensions   = 1;
  block.OutputPort(3).SamplingMode = 0;
  
%   block.InputPort(1).SampleTime  = [-1 0];
%   block.InputPort(2).SampleTime  = [-1 0];
%   block.InputPort(3).SampleTime  = [-1 0];
% 
%   block.OutputPort(1).SampleTime = [-1 0];
%   block.OutputPort(2).SampleTime = [-1 0];
%   block.OutputPort(3).SampleTime = [-1 0];

  
  %% Set the block simStateCompliance to default (i.e., same as a built-in block)
  block.SimStateCompliance = 'DefaultSimState';

  block.SetAccelRunOnTLC(true);
  
  %% Reg methods
%   block.RegBlockMethod('SetInputPortSampleTime',  @SetInpPortST);
%   block.RegBlockMethod('SetOutputPortSampleTime', @SetOutPortST);
  block.RegBlockMethod('Outputs',                 @Output);  
  block.RegBlockMethod('Start',                 @Start);  
  
%endfunction

% % Set input port sample time
% function SetInpPortST(block, idx, st)
%   block.InputPort(1).SampleTime = st;
%   block.OutputPort(1).SampleTime = [st(1)*6, st(2)];
%   block.InputPort(2).SampleTime = st;
%   block.OutputPort(2).SampleTime = [st(1)*6, st(2)];
%   block.InputPort(3).SampleTime = st;
%   block.OutputPort(3).SampleTime = [st(1)*6, st(2)];
% %endfunction
% 
% % Set output port sample time
% function SetOutPortST(block, idx, st)
%   block.OutputPort(1).SampleTime = st;
%   block.InputPort(1).SampleTime = [st(1)/6, st(2)];
% %endfunction

  
  


function Start(block)
    persistent model
    if isempty(model)
      model = Solution('Mevel2015-rocketry_modified.yaml')
    end
    set(model,'Temperature',300.0,'Pressure',101325.0,'MassFractions', 'N2O:6, C4H6:1');
    equilibrate(model, 'HP');
    temperature(model)
    cp_mass(model)
    cv_mass(model)
    meanMolecularWeight(model)

%endfunction

function Output(block)
   persistent model
   if isempty(model)
      model = Solution('Mevel2015-rocketry_modified.yaml');
      disp("MODEL RE-CREATED!")
   end
  disp(block.InputPort(2).Data);
  set(model,'Temperature',block.InputPort(1).Data, ...
      'Pressure',block.InputPort(2).Data, 'MassFractions', ...
      sprintf('N2O:%0.5f, C4H6:1', block.InputPort(3).Data));
  equilibrate(model, 'HP');

  block.OutputPort(1).Data = cp_mass(model)/cv_mass(model);
  block.OutputPort(2).Data = 8314/meanMolecularWeight(model);
  block.OutputPort(3).Data = temperature(model);
  

  disp("iter");
  disp(block.OutputPort(1).Data);
  disp(block.OutputPort(2).Data);
  disp(block.OutputPort(3).Data);
  
%endfunction

