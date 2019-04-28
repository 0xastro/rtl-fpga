clc; close all; clear all;

%% DDFS (Direct Digital Frequency synthesizer)
%  @brief
%  N : length of time domain signal
%      Phase Quantization points. (Number of Rows)
%  M : length of Amplitude (Number of Bits in each Row)
%       hence; each row represent a certain frequency
% %*************************************************

% Starting Phase Quantization
% @N is the Number of bits for phase quantization.
% the higher the N, The lower Resolution
N=12;


% Ideal theta is in range of 0 to 2Pi, We remap the
% interval using N-bit into the [0: 2^N−1] as unsigned
% LSB of the phase = 2*max/2 so we represent 0 to 2pi over 2^12 (4096) points

LSB_theta =2*pi/(2^N);

% phase range of theta [ 0 to 4096 Lutch]
theta= (0 : 2^N-1) * LSB_theta;

h= sin(theta);
%End of frequency Quantization
%*************************************************

% Starting Amplitude Quantization
% (Using a balanced C2 representation)
M=6;
LSB_amp =1/(2^(M-1)-1);
% Quantized sine values using the formula C2 (-31 to +31) for 6 bits (2^6/2)
h_q = round(h/LSB_amp); 
%Debug
    %min(h_q); % get -31
  
% Multiply by LSB_amp (to get to the range)
plot(h_q * LSB_amp);
grid on
hold
% open a file named 'lut.txt' to contain the data.
file = fopen ('lut.txt','w');
%fprintf(file, 'constant ddfs_lut: lut_t := \n');
%fprintf(file, '%d, \n', h_q(1 : end-1));
%fprintf(file, '%d, \n', h_q(end)); % here we print only the last one
%fclose(file);

% convert from integer to binary, problem this function
% @dec2bin()converts only positive values

% so takes away the -ve values 2^M+x if x<0 2's complement
h_q(h_q<0) = h_q(h_q < 0) +2^M; 
% plot to see twos complement
 plot(h_q * LSB_amp, 'r')
%now use dec2bin, M is the number of bits
for i =1 :2^N-1
    fprintf(file, '"%s")\n,',dec2bin(h_q(i),M));
end

fprintf(file, '"%s")\n,',dec2bin(h_q(2^N),M));
fclose(file);
% try frequency word with 1, 2 2048 2050

