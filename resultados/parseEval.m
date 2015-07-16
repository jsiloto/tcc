function [ eval bw midAtt maxAtt phase ] = parseEval( filename )


eval  = [];
bw   = [];
midAtt   = [];
maxAtt   = [];
phase  = [];

fid = fopen(filename);
baseline = fgetl(fid);
baseline = strread(baseline);

while 1
    [evalStr, valid] = getValidLine(fid);
    if ~valid
        break;
    end
    C = strsplit(evalStr);
    
    eval = [eval; strread(C{3})];
    bw = [bw; strread(C{5})];
    midAtt = [midAtt; strread(C{6})];
    maxAtt = [maxAtt; strread(C{7})];
    phase = [phase; strread(C{8})];
end



end

