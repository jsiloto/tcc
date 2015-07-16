data = sphereantigo

i = 1;
data = data(5:end,:);
for ele = data'

    
    if ele(1)~=10*i
        print('ops');
    
    end
   
    if mod(i, 50) == 0
        i = 1;
    end;
end