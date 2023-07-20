function COE = rvECI2coe(rVect, vVect)      % COE=(a, e, i, Omega, omega, nu)'

    global mu

    energy = dot(vVect,vVect)/2 - mu/norm(rVect);
    h = cross(rVect, vVect);
    k = h/norm(h);
    n = cross([0;0;1], h)/norm(cross([0;0;1], h));
    e = (cross(vVect, h))/mu - rVect/norm(rVect);
    
     COE(1,1) = -mu/(2*energy);                 % semiasse maggiore [unità di misura di rVect, probabilmente km]
     COE(2,1) = norm(e);                        % eccentricità
     COE(3,1) = acos(k(3));                     % inclinazione [rad]
     
     O = acos (n(1));                           % prodotto scalare tra versore i e versore n (seleziona la prima componente di n)
     if n(2) > 0 
        COE(4,1) = O;
                                                    % imposizioni delle condizioni per far sì che Omega (londitudine del nodo ascendente) sia compreso tra 0 e 2pi;
     elseif n(2) < 0                                % la seconda componente di n corrisponde al prodotto scalare tra versore j e versore n
        COE(4,1) = 2*pi - O;
        
     elseif n(2)==0
         if n(1)>0
            COE(4,1)= 0;
         else
            COE(4,1)= pi;
         end
     end
     
     O= acos(dot(n,e/norm(e)));
     if e(3) > 0 
        COE(5,1) = O;
                                                    % imposizioni delle condizioni per far sì che omega (argomento del pericentro) sia compreso tra 0 e 2pi;
     elseif e(3) < 0                                % la terza componente di e corrisponde al prodotto scalare tra versore k e vettore e
        COE(5,1) = 2*pi - O;
        
     elseif e(3) == 0
         if dot(n,e/norm(e))>0
            COE(5,1)=0;
         else
            COE(5,1)= pi;
         end
     end
     
     O=acos(dot(e/norm(e), rVect/norm(rVect)));
     rv= dot(rVect,vVect);
     if rv > 0 
        COE(6,1) = abs(O);                    % PORCATA: non bisogna mettere abs(o)!!! lo faccio solo per avere un'anomalia vera reale forzatamente,
                                                         %anche se dovrebbe venire reale per conto suo (ma non lo fa)
                                              % imposizioni delle condizioni per far sì che nu (anomalia vera) sia compreso tra 0 e 2pi;
     elseif rv < 0                            % la seconda componente di n corrisponde al prodotto scalare tra versore j e versore n
        COE(6,1) = 2*pi - abs(O); 
     elseif rv == 0
        if dot(rVect,e)>0
            COE(6,1) = 0;
        else
            COE(6,1) = pi;
        end
     end    
end
     