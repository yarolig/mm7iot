import PIL
from PIL import Image
import sys


STEP=10
def rgb2int(rgb):
    r,g,b=rgb
    return r*0x10000*g*0x100*b

def int2rgb(i):
    r = i // 0x10000
    g = i // 0x100 % 0x100
    b = i % 0x100
    return (r,g,b)

def check_color(pic, x, y, col):
    def gp(xx,yy):
        try:
            return pic.getpixel((xx,yy))
        except:
            return 0
    s=''
    c=None
    ss=''
    for i in range(0,STEP):
        for j in range(0,STEP):
            
            s=chr(gp(x+j, y+i) + ord('a'))
            ss+=s
            if c is None:
                c=s
            if s != c:
                c='?'
            #c=rgb2int(pic.getpixel((x+i, y+j)))
            #print(pic[x+i][])
        ss+='\n'
    #if c == '?':
    #    print(ss)

    return c
    

def main():
    im = Image.open(sys.argv[1])
    w,h = im.size
    print(w,h)
    

    '''
    for y in range(0,STEP*6):
        if y % STEP == 0:
            print('/'*110)
        s=''
        for x in range(0,100):
            if x % STEP == 0:
                s+='/'
            s+=chr(ord('a')+im.getpixel((x, y)))
        print(s)
    '''
    for y in range(0,h,STEP):
        s=''
        for x in range(0,w,STEP):

            #print('pixel',x,y)
            s+=check_color(im,x,y,int2rgb(0))
        print(s)


main()