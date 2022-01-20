from paraview.simple import *
import os
import math

x = 100
y = x
z = x
d = 3
N = 10
filename = "3d{0}x_{1}y_{2}z_{3}d_10N".format(x, x, x, d)

LoadPlugin("D:/project_magnetosomes/magnetosomes_allcodes/MERRILL-plugins.xml", ns=globals())



view = CreateRenderView()
#view.ViewSize = [1600, 1000]
view.OrientationAxesVisibility = 0
view.Background = [0, 0, 0]
cam = view.GetActiveCamera()
cam.SetFocalPoint((x+d)*N/2e3,-y/1e3,-z/1e3)
cam.Dolly(5)
cam.Azimuth(-50)
cam.Elevation(20)

iszoomed = False



B = list(range(10,80,10))

for b in B:
    tecfile = "D:/project_magnetosomes/plots/Mrtec/{0}_{1}b_1r_0_mT_1a_mult.tec".format(filename,b)

    print(tecfile)
    mydata = OpenDataFile(tecfile)
    Show()
    Hide()
    hel = Helicity(mydata)
    helDis = Show(hel)
    helDis.Opacity = 0.3
    gly = Glyph(hel)
    Show(gly)
    gly.ScaleFactor = 0.04 * y/100
    Render()
    SaveScreenshot("D:/project_magnetosomes/plots/MR/{0}_{1}b.png".format(filename,b), view, ImageResolution=[2400, 2200], TransparentBackground=1)
    Delete(gly)
    Delete(helDis)
    Delete(hel)

