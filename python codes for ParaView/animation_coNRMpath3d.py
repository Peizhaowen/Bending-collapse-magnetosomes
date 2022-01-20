from paraview.simple import *
import os
import math

x = 40
y = x
z = x
d = 8
N = 10
b = 70
r = 1
filename = "3dco_{0}x_{1}y_{2}z_{3}d_10N_{4}b_{5}r".format(x, x, x, d, b, r)

LoadPlugin("D:/project_magnetosomes/magnetosomes_allcodes/MERRILL-plugins.xml", ns=globals())



view = CreateRenderView()
# view.ViewSize = [2400, 2200]
view.OrientationAxesVisibility = 0
view.Background = [1, 1, 1]
cam = view.GetActiveCamera()
cam.SetFocalPoint((x+d)*N/2e3,-y/1e3,-z/1e3)
cam.Dolly(5)
cam.Azimuth(80)
cam.Elevation(80)

iszoomed = False


try: 
	os.makedirs("D:/project_magnetosomes/plots/path_{0}".format(filename))
except OSError:
	if not os.path.isdir("D:/project_magnetosomes/plots/path_{0}".format(filename)):
		raise

for num in list(range(1,51)):
    tecfile = "D:/magnetosomes_thermal/pathstates_bent3d/{0}/{1}_20T_{2}path_mult.tec".format(filename,filename,num)
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
    SaveScreenshot("D:/project_magnetosomes/plots/path_{0}/{1}_20T_{2}path.png".format(filename,filename,num), view, ImageResolution=[3000, 2400], TransparentBackground=1)
    Delete(gly)
    Delete(helDis)
    Delete(hel)