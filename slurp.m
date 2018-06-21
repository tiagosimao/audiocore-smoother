#! octave -qf
# a sample Octave program
printf ("Boot\n");
#setenv("GNUTERM","qt");
#graphics_toolkit("fltk");
#setenv ("GNUTERM", "X11");

# read stereo file
printf ("Reading input\n");
stereo_in = audioread("input.wav");

# to mono
printf ("Converting to mono\n");
mono_in = stereo_in(:,[1]) + stereo_in(:,[2]);

mono_vector = mono_in';

printf ("Creating output\n");
vector_size = length(mono_vector);
mono_out = zeros(1,length(mono_vector));

max_speed = 1/200;

printf ("Processing in to out\n");
last_value = 0;
for i = 1:length(mono_vector),
    sample = mono_vector(i);
    delta = abs(sample - last_value);
    compressed_value = sample;
    if delta > max_speed,
        if sample > last_value,
            compressed_value = last_value + max_speed;
        else
            compressed_value = last_value - max_speed;
        endif
    endif
    mono_out(i) = compressed_value;        
    last_value = compressed_value;
endfor

#plot(mono_out);

printf ("Saving output\n");
# output
audiowrite("output.wav",mono_out,48000);
