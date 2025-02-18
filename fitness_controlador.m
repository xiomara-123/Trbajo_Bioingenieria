function [ FitnessValue ] = fitness_controlador(x_pop)

% Respuesta deseada de lazo cerrado
  Ts = 2.0;
  Xi = sqrt(2)/2;
  Wn = 4 / (Ts * Xi);
  Td = tf(Wn^2,[1 2*Xi*Wn Wn^2]);
  [Yd,t] = step(Td);

% Respuesta de lazo cerrado del controlador
  %K = x_pop(1);
  %Z = x_pop(2);
  %P = x_pop(3);

  x=x_pop(1);
  Wn=x_pop(2);

  s = tf('s');
  G = 1 / (s*(s + 1));
  Gc = K * (s + Z) / (s + P);
  Gcl  = feedback(G * Gc, 1);

% Respuesta del sistema en lazo cerrado ante entrada escalón  
  Y = step(Gcl,t);
  
% Función objetivo. Diferencia al cuadrado de la respuesta deseada y la salida
  error = Yd - Y;
  error_sq = error'*error;
  FitnessValue = error_sq/max(size(error));

