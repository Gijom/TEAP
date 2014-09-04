#A complete example
##With a single signal

Let's say that you want to analyse a GSR signal. First, you load-it into matlab:

    load sig.mat

then you import-it into teap:

    signal = GSR_aqn_variable(SIG);

You can plot-it:

    Signal_plot(signal)

and calculate some of it's features:

    pks = GSR_feat_peaks(signal)

##With multiple signals
If you want to analyse multiple signals, import-them as a bulk:

    load Participant1.mat

and create the bulk signal:

    b = Bulk_load_eeglab(EEG);

plot all the signals:

    Bulk_plot(b);

and calculate a feature

    epoch1 = b(1);
    GSR_feat_peaks(epoch1);

