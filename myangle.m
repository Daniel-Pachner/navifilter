function a = myangle(x, y)
  if x > 0
    a = atan(y/x);
  elseif x < 0 && y >= 0
    a = atan(y/x) + pi;
  elseif x < 0 && y < 0
    a = atan(y/x) - pi;
  elseif x == 0 && y >= 0
    a = pi/2;
  elseif x == 0 && y < 0
    a = -pi/2;
  else
    a = 0;
  end
end
