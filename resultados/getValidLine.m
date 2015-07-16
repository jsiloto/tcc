function [tline, valid ] = getValidLine(fid )

    valid = true;
    tline = fgetl(fid);
    if isempty(tline)
        valid = false;
    end
    if tline == -1
        valid = false;
    end
end

