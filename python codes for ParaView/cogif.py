import imageio
import os
import os.path


def create_gif(gif_name,path,duration):
        frames= []
        pngFiles = os.listdir(path)
        print(pngFiles)
        pngFiles.sort(key=lambda x:int(x[:-4]))
        image_list = [os.path.join(path, f) for f in pngFiles]
        print(image_list)
        for image_name in image_list:# 读取 png 图像文件
                frames.append(imageio.imread(image_name))# 保存为 gif
        imageio.mimsave(gif_name, frames, 'GIF', duration = duration)
        return


def main():
    num = 100
    d = 3
    b = 0
    a = 3
    gif_name = 'co{0}_{1}b_{2}a.gif'.format(num, b, a)
    path = 'D:\\project_magnetosomes\\plots\\Cuboctahedron_{0}x_{1}y_{2}z_{3}d_10N_{4}btext'.format(num,num,num,d,b)
    duration = 0.2
    create_gif(gif_name, path, duration)


if __name__ == "__main__":
    main()
