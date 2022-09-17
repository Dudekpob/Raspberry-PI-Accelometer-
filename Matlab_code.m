%otwarcie pliku scieżka do pliku pan swoją musi wkleic
fid = fopen('C:\accdata.txt');
%iterator do pętli
i = 1; 

%pętla pobiera dane do ostatniej liniki pliku  
while ~feof(fid)
%pakuje kazdą linikę do tablicy
    tline{i} = fgetl(fid);
    i = i + 1
end
%zamknięcie opliku
fclose(fid);

%pętla  mieli dane kilka godzin 
    for j = 1:length(tline)
% konwertowanie danych do tablic zmiana ze strigu na char tworzenie tablicy 5x1 [data,czas,x,y,z]
       str{j} = convertCharsToStrings(tline{j}+ " ");
       str{j} = extractBetween(str{j},""," ");
       date{j} = str{j}(~any(cellfun('isempty',str{j}),2),:)
    end

%iterator do petli
k = 1;
for k=1:length(date)
	%pakowanie w tablice wyniki z tablicy 5x1 [data,czas,x,y,z]
     time{k} = date{k}(2);
	 %x
	x{k} = date{k}(3);
	 %y
	y{k} = date{k}(4);
	 %z
	z{k} = date{k}(5);
end

%konwertowanie stringa na double dla x,y,z
x =  cellfun(@(x)str2double(x), x);
y =  cellfun(@(y)str2double(y), y);
z =  cellfun(@(z)str2double(z), z);

i = 1

for i=1:length(time)
 %vector t czas format taki jak z pliku godzina minuty sekundy 
 t{i} = datetime(time{i},'Format', 'HH:mm:ss');
end

%czas w sekundach od 1 do konca vectora t do wykresów
tt = 1:1:length(t);

% Wariancja dla osi x,y,z oraz xyz
var_x = var(x)
var_y = var(y)
var_z = var(z)
var_xyz = sqrt(power(var_x,2)+power(var_y,2)+power(var_x,2))

%czcionka rozmiar
FontSize = 20;
g = 9.81;
a = sqrt(x.^2 + y.^2 + z.^2);

%filtr HighPass1 
%stworzony w filterDesigner 
%parametry highpass fsample 10 fstop 0.707 fpass 1  IIR filtr Butterworth

%filtr LowPass1 
%stworzony w filterDesigner 
%parametry fsample  10 fpass 1.2 fstop 1.5        IIR filtr Butterworth

%filtrowanie danych HP
x_filtered = filter(HighPass1,x);
%filtrowanie danych LP
x_filtered = filter(LowPass1,x_filtered);

%filtrowanie danych HP
y_filtered = filter(HighPass1,y);
%filtrowanie danych LP
y_filtered = filter(LowPass1,y_filtered);

%filtrowanie danych HP
z_filtered = filter(HighPass1,z);
%filtrowanie danych LP
z_filtered = filter(LowPass1,z_filtered);

%figury
%otwarcie pliku scieżka do pliku pan swoją musi wkleic
fid = fopen('C:\\accdata.txt');
%iterator do pętli
i = 1; 

%pętla pobiera dane do ostatniej liniki pliku  
while ~feof(fid)
%pakuje kazdą linikę do tablicy
    tline{i} = fgetl(fid);
    i = i + 1
end
%zamknięcie opliku
fclose(fid);

%pętla 
    for j = 1:length(tline)
% konwertowanie danych do tablic zmiana ze strigu na char tworzenie tablicy 5x1 [data,czas,x,y,z]
       str{j} = convertCharsToStrings(tline{j}+ " ");
       str{j} = extractBetween(str{j},""," ");
       date{j} = str{j}(~any(cellfun('isempty',str{j}),2),:)
    end

%iterator do petli
k = 1;
for k=1:length(date)
	%pakowanie w tablice wyniki z tablicy 5x1 [data,czas,x,y,z]
     time{k} = date{k}(2);
	 %x
	x{k} = date{k}(3);
	 %y
	y{k} = date{k}(4);
	 %z
	z{k} = date{k}(5);
end

%konwertowanie stringa na double dla x,y,z
x =  cellfun(@(x)str2double(x), x);
y =  cellfun(@(y)str2double(y), y);
z =  cellfun(@(z)str2double(z), z);

i = 1

for i=1:length(time)
 %vector t czas format taki jak z pliku godzina minuty sekundy 
 t{i} = datetime(time{i},'Format', 'HH:mm:ss');
end

%czas w sekundach od 1 do konca vectora t do wykresów
tt = 1:1:length(t);

% Wariancja dla osi x,y,z oraz xyz
var_x = var(x)
var_y = var(y)
var_z = var(z)
var_xyz = sqrt(power(var_x,2)+power(var_y,2)+power(var_x,2))

%czcionka rozmiar
FontSize = 20;
g = 9.81;
a = sqrt(x.^2 + y.^2 + z.^2);

%filtr HighPass1 
%stworzony w filterDesigner 
%parametry highpass fsample 10 fstop 0.707 fpass 1  IIR filtr Butterworth

%filtr LowPass1 
%stworzony w filterDesigner 
%parametry fsample  10 fpass 1.2 fstop 1.5        IIR filtr Butterworth

%filtrowanie danych HP
x_filtered = filter(HighPass1,x);
%filtrowanie danych LP
x_filtered = filter(LowPass1,x_filtered);

%filtrowanie danych HP
y_filtered = filter(HighPass1,y);
%filtrowanie danych LP
y_filtered = filter(LowPass1,y_filtered);

%filtrowanie danych HP
z_filtered = filter(HighPass1,z);
%filtrowanie danych LP
z_filtered = filter(LowPass1,z_filtered);

%wykres x
plot(tt,x_filtered,tt,x+var_x);
hx = xlabel("t [s]");
hy = ylabel("a_x [m/s^2]");
ht = title("Accelerometer raw & filtered data");
hz = legend("X-axes raw data + Variance_X", "X-axes filtered data");
xlim([0 length(tt)])
set (hx, "fontsize", FontSize);
set (hy, "fontsize", FontSize);
set (ht, "fontsize", FontSize);
set (hz, "fontsize", FontSize);
clf

%wykres y
plot(tt,y_filtered,tt,y+var_y);
hx = xlabel("t [s]");
hy = ylabel("a_y [m/s^2]");
ht = title("Accelerometer raw & filtered data");
hz = legend("Y-axes raw data + Variance-Y", "Y-axes filtered data");
xlim([0 length(tt)])
set (hx, "fontsize", FontSize);
set (hy, "fontsize", FontSize);
set (ht, "fontsize", FontSize);
set (hz, "fontsize", FontSize);
clf


%wykres z
plot(tt,z_filtered,tt,z+var_z);
hx = xlabel("t [s]");
hy = ylabel("a_z [m/s^2]");
ht = title("Accelerometer raw & filtered data");
hz = legend("Z-axes raw data + Variance-Z", "Z-axes filtered data");
xlim([0 length(tt)])
set (hx, "fontsize", FontSize);
set (hy, "fontsize", FontSize);
set (ht, "fontsize", FontSize);
set (hz, "fontsize", FontSize);
clf










 








 