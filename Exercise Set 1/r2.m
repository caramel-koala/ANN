function r = r2(y,z)


SSR = sum((y-z).^2);

y_bar = sum(y)/length(y);

SSY = sum((y-y_bar).^2);

r = 1 - (SSR/SSY);

end

