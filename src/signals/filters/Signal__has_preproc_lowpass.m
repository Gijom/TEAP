%> @brief Has the signal been low-passed ?
%> @param  Signal
%> @retval Boolean: 1: yes
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Boolean = Signal__has_preproc_lowpass(Signal)

Boolean = Signal__has_preproc(Signal, 'lowpass');
