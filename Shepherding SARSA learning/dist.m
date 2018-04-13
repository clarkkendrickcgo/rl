function z2 = dist(w, p)
% dist function similar to neural network toolbox
S = size(w,1);
Q = size(p,2);
z2 = zeros(S,Q);
if (Q<S)
  p = p';
  copies = zeros(1,S);
  for q=1:Q
    z2(:,q) = sum((w-p(q+copies,:)).^2,2);
  end
else
  w = w';
  copies = zeros(1,Q);
  for i=1:S
    z2(i,:) = sum((w(:,i+copies)-p).^2,1);
  end
end
z2 = sqrt(z2);