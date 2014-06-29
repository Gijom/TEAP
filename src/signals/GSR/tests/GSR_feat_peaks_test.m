%Tests the GSR peak feature.

%!test
%! %Before all, load TEAPhysio
%! addpath(genpath('../../../'))
%! %First, we load some data:
%! data = csvread('GSR_example.csv');
%! data = data'; %put in horizontal form
%!
%!
%! %Create the signal, the sampling freq of the signal we have is 1024Hz
%! signal = GSR_aqn_variable(data, 1024);
%!
%! %Clean the signal a bit
%! signal = GSR_filter_basic(signal);
%!
%! %And compute the features:
%! [nbPeaks ampPeaks riseTime posPeaks] = GSR_feat_peaks(signal);
%!
%! assert(nbPeaks, 14)
%! assert(ampPeaks, [465 819 697 450 565 846 490 963 359 341 1508 999 308 421], 2)
%! assert(riseTime, [2.99 2.69 2.55 3.91  2.62 2.67 3.39 4.87 1.94 2.41 5.69 3.21 2.49 2.57], 0.5)
%! assert(posPeaks, [31594 36591 43458 52418 60798 68388 78432 87726 93780 98686 126104 131732 144591 149817], 1)
%!

