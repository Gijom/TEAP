function [bpm delta_t t] = PICtoBPM(listePic, fe)

bpm =[];
t = [];
deltaSamp = [];
for(j=2:length(listePic))
    deltaSamp(j-1) = listePic(j)-listePic(j-1);
    if(deltaSamp(j-1) <= 0)
        error('L''ecart entre deux pic doit etre de 1 minimum');
    end
    bpm(j-1) = 60/(deltaSamp(j-1)*(1/fe));
    t(j-1) = mean([listePic(j-1) listePic(j)]);
end
delta_t = deltaSamp / fe;