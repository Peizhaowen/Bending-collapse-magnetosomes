from paraview.simple import *
import os
import math

x = 40
y = x
z = x
d = 8
N = 10
r = 1
filename = "3d{0}x_{1}y_{2}z_{3}d_10N_{4}r".format(x, x, x, d, r)

LoadPlugin("D:/project_magnetosomes/magnetosomes_allcodes/MERRILL-plugins.xml", ns=globals())



view = CreateRenderView()
# view.ViewSize = [2400, 2200]
view.OrientationAxesVisibility = 0
view.Background = [1, 1, 1]
cam = view.GetActiveCamera()
cam.SetFocalPoint((x+d)*N/2e3,-y/1e3,-z/1e3)
cam.Dolly(5)
cam.Azimuth(-50)
cam.Elevation(20)

iszoomed = False


try: 
	os.makedirs("D:/project_magnetosomes/plots/NRM_{0}_new".format(filename))
except OSError:
	if not os.path.isdir("D:/project_magnetosomes/plots/NRM_{0}_new".format(filename)):
		raise

B = list(range(0,70,5))

for b in B:
    tecfile = "D:/magnetosomes_3d/domainstates_bent3d_NRM/{0}/minimize_{1}_{2}b_1a_mult.tec".format(filename,filename,b)
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
    SaveScreenshot("D:/project_magnetosomes/plots/NRM_{0}_new/{1}_{2}b.png".format(filename,filename,b), view, ImageResolution=[3000, 2400], TransparentBackground=1)
    Delete(gly)
    Delete(helDis)
    Delete(hel)