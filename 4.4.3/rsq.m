function r2=rsq(t,a)
%Finds the rˆ2 statistic and correlation coefficient for
%a: sxq activation matrix
%t: sxq target matrix
%name: name of title as a string (eg: 'mygraph')
%r2: r-squared statistic
%arrange t, a with s rows (features) and q columns (observations)
[s,q]=size(t);
if s>q
t=t';
a=a';
end
%calculating r2:
%means of the feature rows
mt=repmat(mean(t,2),1,size(t,2));
%sum of squares error between activations and targets
ss=sum((a-t).^2,2);
%sum of squares error between mean of targets and targets
ssm=sum((mt-t).^2,2);
%row vector of the r2 stats of the columns
r2=1-ss./ssm;
end