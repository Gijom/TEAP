%function [bpm, delta_t, t, listePic] = PLETtoBPM(data, fe, methodPeak, SizeWindow, verbose)
% calcul le heart rate bpm a partir du fichier des données data
% le signal a une frequence d'echantillonage fe. Search for the upper peak,
% if systolic upstroke is desired, simply negate the signal
%IN:
% data: the pletysmograph data
% fe: sampling frequency
% methodPeak: detection method for choice in case of many peak (default 'max')
%   'sharp': the shapest peak
%   'max: the highest peak
%   'first': the first peak of the two
% SizeWindow: for mean filtering, 0-> no fitlering (default fe/50) 
% verbose: display a graph of the result if 1 (default 0)
%OUT:
% bpm : Heart rate in bpm
% delta : Heart rate in time
% t : vecteur contenant les samples central des deux pics ayant servi a
% calculer le bpm
% listePic : liste des echantillon ou il y a eu des pics detecté
% Ver 2 : n'utilise pas les wavlet mais seulement la dérivée du signal
% Ver 3 : plus de gros filtrage et choix des pics suivant differetes
% methodes
%
%Copyright Guillaume Chanel 2015

function [bpm, delta_t, t, listePic] = PLETtoBPM(data, fe, methodPeak, SizeWindow, verbose)

if(nargin < 3)
    methodPeak = 'max';    
end
if(nargin < 4)
   SizeWindow = round(fe/50);   
end
if(nargin < 5)
    verbose = 0;
end

data = data - mean(data);
if(SizeWindow ~= 0)
 dataS = filtfilt(ones(1, SizeWindow)/SizeWindow, 1, [repmat(data(1),SizeWindow,1);data]);
 dataS = dataS(SizeWindow+1:end);
% dataS = medfilt1(data,SizeWindow);
else
    dataS = data;
end

diffS = diff(dataS);

%recherche des pics postif : deriv decroissante = 0
listePic = [];
for(iSpl = 1:length(diffS)-1)
    if((diffS(iSpl) > 0) & (diffS(iSpl+1) < 0)) %si il y a une derive == 0 sur le dernier sample elle n'est pas prise en compte
        listePic = [listePic iSpl+(diffS(iSpl) / (diffS(iSpl) - diffS(iSpl+1)))];
    elseif ((diffS(iSpl)==0) & (diffS(iSpl+1) < 0))
        listePic = [listePic iSpl];
    end
end
%Sure to keep that ?
listePic = round(listePic);


%Procedure to keep only peaks that are separated by at least 0.5 seconds
%other are considered as the same peak and one of the two is selected
%according to the choosen method. Also peaks that are lie alone in the
%first 0.5 seconds are removed (cannot dentermine wich peak it is...)
limit = round(0.5*fe);

%Remove too early first peak
if((listePic(1) < limit) && (listePic(2) - listePic(1) >= limit))
    listePic = listePic(2:end);
end

%remove other peaks
iPic = 1;
while(iPic<=length(listePic)-1)
    %If two peaks are too close keep the one depending on the method
    if( (listePic(iPic+1) - listePic(iPic)) < limit)
        switch(methodPeak)
            case 'sharp'
                nbSplFwd = round(0.05*fe);
                if(listePic(iPic+1)+nbSplFwd > length(dataS))
                    nbSplFwd = length(dataS) - listePic(iPic+1);
                    warning(['Not enough signal to look 0.05s ahead, looking at ' num2str(nbSplFwd/fe) 's ahead'])
                end
                sharp2 = dataS(listePic(iPic+1)) - dataS(listePic(iPic+1)+nbSplFwd);
                sharp1 = dataS(listePic(iPic)) - dataS(listePic(iPic)+nbSplFwd);
                if(sharp1 < sharp2)
                    choice = 2;
                else
                    choice = 1;
                end                    
            case 'max'
                [dummy, choice] = max([data(listePic(iPic)) data(listePic(iPic+1))]);
            case 'first'
                choice = 1;
            otherwise
                error([methodPeak ' method is unknown']);
        end
        if(choice==1)
            listePic(iPic+1) = [];
        else
            listePic(iPic) = [];
        end
    else
        iPic = iPic + 1;
    end

end


if (length(listePic) < 2)
    error('There should be at least 2 peaks to detect');
end

%Compute bpm from the pic list
[bpm delta_t t] = PICtoBPM(listePic, fe);

if(verbose)
    figure; hold on;
    plot(data);
    plot(dataS,'r');
    plot(diffS,'g');
    plot(listePic,data(round(listePic)),'+')
    plot(listePic,dataS(round(listePic)),'+r')
    plot(listePic,diffS(round(listePic)),'+g')
    plot(t,bpm,'c*-')
end
