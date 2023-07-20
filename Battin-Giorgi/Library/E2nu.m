function anu = AE2anu(e, AE)

    anu = 2*atan2(sqrt((1+e)/(1-e))*tan(AE/2),1);

end