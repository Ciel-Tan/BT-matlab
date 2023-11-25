cd('Bai1');
run('Bai1');


N_FFT = 1024;
frame_len = 20;
frame_dis = 10;

cd('../Bai2');
run(sprintf('Bai2(%d, %d, %d).m', N_FFT, frame_len, frame_dis));



N_MFCC = 13;
frame_lem = 20;
frame_shift = 16;
cd('../Bai3');
run(sprintf('Bai3(%d, %d, %d).m', N_MFCC, frame_lem, frame_shift));


cd('..');