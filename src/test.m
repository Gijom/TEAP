init;
pkg load signal;
data=csvread('signals/GSR/examples/GSR_example.csv')';
GSR = GSR_aqn_variable(data, 32);
GSR_feat_extr(GSR);
