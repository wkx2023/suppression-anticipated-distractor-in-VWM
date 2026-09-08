function output = dynamicism_v2(inputM)

timeDim = size(inputM,1);

output_Time = zeros(timeDim,1);

output = zeros(timeDim,1);
for t1=1:timeDim
    for t2=1:timeDim

        if inputM(t1,t1)==1 && inputM(t2,t2)==1
            output_Time(t1,t2) = 2-inputM(t1,t2)-inputM(t2,t1);
        else
            output_Time(t1,t2)=0;
        end

    end
end


for t=1:timeDim
    output(t) = (1/(2*timeDim))*(sum(output_Time(t,:)));
end

end
