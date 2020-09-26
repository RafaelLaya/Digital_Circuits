from PIL import Image
import re

def img2array_color(name) :
    img = Image.open(name, 'r');
    width, height = img.size;
    pixelCount = width*height;
    data = list(img.getdata());
        
    for i in range(pixelCount):  
        if(i % width == 0) :
            if(i != 0) :
                print("};");
            print("assign spikes_sprite[%d] = " % (i/width), end =" "),; 
            print("{", end =" "),;
        

        if(i % width == width-1) :
            print("24'd" + str( (int(data[i][0]) << 16) | (data[i][1] << 8) | (data[i][2])), end =" "),;
        else :
            print("24'd" + str( (int(data[i][0]) << 16) | (data[i][1] << 8) | (data[i][2]))+ ",", end =" "),;
    print("};");