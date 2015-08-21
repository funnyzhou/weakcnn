function net = cnn_weakly_label_init(varargin)
% CNN_MNIST_LENET Initialize a CNN similar for MNIST
opts.useBnorm = true ;
opts = vl_argparse(opts, varargin) ;

rng('default');
rng(0) ;

f=1/100 ;
net.layers = {} ;
net.layers{end+1} = struct('type', 'conv', ...
                           'filters',f*randn(11,11,3,96,'single'),...
                           'biases',zeros(1,96,'single'),...
                           'stride', 4, ...
                           'pad', 0) ;
net.layers{end+1}=struct('type','relu');
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [3 3], ...
                           'stride', 2, ...
                           'pad', 0) ;                       
                       
net.layers{end+1} = struct('type', 'conv', ...
                           'filters',f*randn(5,5,48,256,'single'),...
                           'biases',zeros(1,256,'single'),...
                           'stride', 1, ...
                           'pad', 2) ;
net.layers{end+1}=struct('type','relu');
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [3 3], ...
                           'stride', 2, ...
                           'pad', 0) ;

net.layers{end+1} = struct('type', 'conv', ...
                           'filters',f*randn(3,3,256,384,'single'),...
                           'biases',zeros(1,384,'single'),...
                           'stride', 1, ...
                           'pad', 1) ;
net.layers{end+1} = struct('type', 'relu') ;

net.layers{end+1} = struct('type', 'conv', ...
                           'filters',f*randn(3,3,192,384,'single'),...
                           'biases',zeros(1,384,'single'),...
                           'stride', 1, ...
                           'pad', 1) ;
net.layers{end+1}=struct('type','relu');

net.layers{end+1}=struct('type','conv',...
                         'filters',f*randn(3,3,192,256,'single'),...
                         'biases',zeros(1,256,'single'),...
                         'stride',1,...
                         'pad',1);
net.layers{end+1}=struct('type','relu');
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [3 3], ...
                           'stride', 2, ...
                           'pad', 0) ;

net.layers{end+1}=struct('type','conv',...
                         'filters',f*randn(6,6,256,4096,'single'),...
                         'biases',zeros(1,4096,'single'),...
                         'stride',1,...
                         'pad',0);
net.layers{end+1}=struct('type','relu');

net.layers{end+1}=struct('type','conv',...
                         'filters',f*randn(1,1,4096,4096,'single'),...
                         'biases',zeros(1,4096,'single'),...
                         'stride',1,...
                         'pad',0);
net.layers{end+1}=struct('type','relu');

net.layers{end+1}=struct('type','conv',...
                         'filters',f*randn(1,1,4096,2048,'single'),...
                         'biases',zeros(1,2048,'single'),...
                         'stride',1,...
                         'pad',0);
net.layers{end+1}=struct('type','relu');

net.layers{end+1}=struct('type','conv',...
                         'filters',f*randn(1,1,2048,20,'single'),...
                         'biases',zeros(1,20,'single'),...
                         'stride',1,...
                         'pad',0);
%global maxpool
net.layers{end+1}=struct('type','globalmaxpool','method','max','stride',1,'pad',0);

net.layers{end+1}=struct('type','softmax');

%loss
net.layers{end+1}=struct('type','softmaxforweaklabel');
%net.layers{end+1}=struct('type','softmaxloss');
