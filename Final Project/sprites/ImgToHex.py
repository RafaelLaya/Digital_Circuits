from PIL import Image
import re

COLOR_BYTE_COUNT = 3
BYTE_16 = True

def img2array_color(name, out_file) :
    img = Image.open(name, 'r')
    img = img.convert('RGB')
    width, height = img.size
    pixelCount = width*height
    data = list(img.getdata())
    higher_linear_address = 0

    print("Width: %s, Height: %s\n" % (width, height))
    
    with open(out_file + ".hex", "w+") as f:
        address = 0
        maxr = 0
        for i in range(pixelCount):
            x = i % width
            y = (i - x) / width

            r = data[i][0]
            g = data[i][1]
            b = data[i][2]

            address_low = address % 0x100
            address_high = (address >> 8) % 0x100
            addr_32_mask = address & (~0x0000FFFF)

            if (addr_32_mask != higher_linear_address):
                if (BYTE_16):
                    continue
                # The address gets too high and requires linear address extension
                higher_linear_address = addr_32_mask
                linear_low = higher_linear_address >> 16
                linear_high = (linear_low >> 8) & 0xFF
                linear_low = linear_low & 0xFF
                checksum = (0x100 - ((2 + 2 + linear_high + linear_low) % 0x100)) % 0x100
                f.write(":02000002%0.2X%0.2X%0.2X\n" % (linear_low, linear_high, checksum))

            checksum = (COLOR_BYTE_COUNT + address_low + address_high + r + g + b) % 0x100
            checksum = (0x100 - checksum) % 0x100

            f.write(":%0.2X%0.4X00%0.2X%0.2X%0.2X%0.2X\n" % (COLOR_BYTE_COUNT, address & 0xFFFF, b, g, r, checksum))
            address += 1
        
        f.write(":00000001FF")
        print(maxr)