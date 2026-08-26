function f = sorensenDice(X,Y)
a=X*Y';
sumX=sum(X,2);
sumY=sum(Y,2);
e=sumX+sumY'-2*a;
oszto=2*a+e;
hasonlosag=zeros(size(oszto));
valid = (oszto > 0);
hasonlosag(valid) = (2 * a(valid)) ./ oszto(valid);
hasonlosag(~valid) = 1;
f = 1 - hasonlosag;
end