function AE = anu2AE(e, anu)

    K = 2*atan2(sqrt((1-e)/(1+e))*tan(anu/2),1);
    
    if K>=0
        AE = K;
    else
        AE = 2*pi + K;
    end
end

%% atan2() restituisce angoli compresi entro [-pi,+pi]. 
% 2*atan2() dà angoli compresi tra [-2pi, +2pi].
% quindi otteniamo che K è compreso tra [-2pi, +2pi].

%%atan(), invece, restituisce angoli compresi entro [-pi/2,+pi/2].
