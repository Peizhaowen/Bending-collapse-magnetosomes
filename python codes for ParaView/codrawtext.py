import PIL
from PIL import ImageFont
from PIL import Image
from PIL import ImageDraw
import os
import math

#设置字体，如果没有，也可以不设置
ft = ImageFont.truetype("C:\\WINDOWS\\Fonts\\SIMYOU.TTF", 120)


x = 100
d = 3
b = 180
a = 3
filename = "Cuboctahedron_{0}x_{1}y_{2}z_{3}d_10N_{4}b".format(x, x, x, d, b)

#打开底版图片
H =[-300,-280,-260,-240,-220,-200,-180,-160,-140,-120,-100,-90,-80,-70,-60,-50,-40,-30,-20,-10,0,1,2,3,4,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,120,140,160,180,200,220,240,260,280,300] 
for h in H:
    imageFile = "D:/project_magnetosomes/plots/{0}/{1}_{2}_mT_{3}a.png".format(filename, filename, h, a)
    im1=Image.open(imageFile)
    # 在图片上添加文字 1
    draw = ImageDraw.Draw(im1)
    f = "Field: {0}mT".format(h)
    draw.text((400,400), f,font = ft, fill = 'red')
    draw = ImageDraw.Draw(im1)
    # 保存
    savename="D:\\project_magnetosomes\\plots\\{0}text\\{1}.jpg".format(filename, h)
    bg = Image.new("RGB", im1.size, (255, 255, 255))
    bg.paste(im1, im1)
    bg.save(savename)
    # im1.save(savename)