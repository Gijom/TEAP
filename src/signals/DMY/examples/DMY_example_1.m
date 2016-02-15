%> @file DMY_example_1.m
Sig = DMY_aqn_file();

[feature1 Sig] = DMY_feat_feat1(Sig);

%And once again
[feature Sig] = DMY_feat_feat1(Sig); %Cache used


%Note that with another signal of a different type:
Sig2 = Signal__new_empty();
[feature Sig2] = DMY_feat_feat1(Sig2); %This wont work

