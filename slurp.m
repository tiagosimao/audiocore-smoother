#! octave -qf
# a sample Octave program
printf ("Boot\n");

# read stereo file
stereo_in = audioread("piano2.wav");

# to mono
mono_in = stereo_in(:,[1]) + stereo_in(:,[2]);

mono_vector = mono_in';

mono_out = [];

max_speed = 1/48000;

last_value = 0;
for sample = mono_vector,
    delta = abs(sample - last_value);
    compressed_value = sample;
    if delta > max_speed,
        if sample > last_value,
            compressed_value = last_value + max_speed;
        else
            compressed_value = last_value - max_speed;
        endif
    endif
    mono_out = [mono_out compressed_value];        
    last_value = compressed_value;
endfor


# output
audiowrite("p.wav",mono_vector,48000);
audiowrite("p.wav",mono_out,48000);
