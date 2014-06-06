struct signal {
	byte *raw;
	int sampFreq;
	char *name;
	struct {
		int feature1, …, featureN;
	} feature;
};

