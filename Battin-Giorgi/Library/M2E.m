function AE = XM2AE(e, XM)

%espando l'equazione in serie intorno al punto di primo tentativo ( E0 =M), inverto l'espressione per trovare il nuovo valore di tentativo (E)

    AE0=XM;
        for i=1:50
            AE = AE0 + (XM - (AE0-e*sin(AE0)))/ (1-e*cos(AE0));
            err=AE-AE0;
            if abs(err)<1e-10                                        % criterio di convergenza
            break
            else
                AE0=AE;
            end
        end
end