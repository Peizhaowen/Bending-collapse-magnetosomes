import PIL
from PIL import ImageFont
from PIL import Image
from PIL import ImageDraw
import os
import math

#设置字体，如果没有，也可以不设置
ft = ImageFont.truetype("C:\\WINDOWS\\Fonts\\SIMYOU.TTF", 120)


x = 40
d = 8
filename = "NRM_Cuboctahedron_{0}x_{1}y_{2}z_{3}d_10N".format(x, x, x, d)

#打开底版图片
B =list(range(0,310,10))
for b in B:
    imageFile = "D:\\project_magnetosomes\\plots\\{0}\\{1}_{2}b.png".format(filename, filename, b)
    im1=Image.open(imageFile)
    # 在图片上添加文字 1
    draw = ImageDraw.Draw(im1)
    f = "Bent: {0:g}°".format(b)
    draw.text((400,600), f,font = ft, fill = 'red')
    draw = ImageDraw.Draw(im1)
    # 保存
    savename="D:\\project_magnetosomes\\plots\\{0}text\\{1}.jpg".format(filename, b)
    bg = Image.new("RGB", im1.size, (255, 255, 255))
    bg.paste(im1, im1)
    bg.save(savename)
    # im1.save(savename)