
% PROGRAMA DE MATLAB PARA LEER DATOS DEL PUERTO SERIE/UART PROVENIENTES
% DE UN MICROCONTROLADOR 


instrreset % reinicia todos los puertos serie de la PC
clear all
close all
clc

s = serial('COM6'); % cambiar este por el puerto COM en el que se encuentre el microcontrolador
set(s,'BaudRate',115200); % baud rate - debe coincidir con el baud rate seleccionado al iniciiar la comunicacion Serial en el dispositivo se sugiere 115200
fopen(s); % abre la comunicación entre Arduino y MATLAB
plot_len = 500; % tamaño de la ventana de datos en la gráfica
x_vals = linspace(0,plot_len,plot_len); % valores del eje -x
plot_var = zeros(plot_len,1); % inicializa con ceros

% configuración de figura
f1 = figure();
xlabel('Muestra')
ylabel('Amplitud')

grid('on')
hold on
loop_break = true; % 
dialogBox = uicontrol('Style', 'PushButton', 'String', 'Break Loop','Callback', 'loop_break = false;');
% plot zeros 
p1 = plot(x_vals,plot_var,'linewidth',1.1); 

while loop_break 
    out = fscanf(s);
    plot_var(1:end-1) = plot_var(2:end);
    plot_var(end) = str2double(out);
    set(p1,'Ydata',plot_var)
    %pause(0.05)
end
fclose(s)
delete(s)