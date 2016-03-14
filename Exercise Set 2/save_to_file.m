%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Numerical Modelling
%Writes to a generic file
%Author: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function save_to_file( x, filename)

[p,n] = size(x);

fid = fopen(filename, 'w+');
for i=1:n
   for j=1:p
      fprintf(fid,'%f \t',x(j,i)); 
   end
   fprintf(fid,'\n'); 
end
fclose(fid);

end