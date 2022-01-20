from paraview.simple import *
import os
import math

x = 40
y = x
z = x
d = 8
N = 10
b = 70
r = 5
a = 10

H =[-300,-280,-260,-240,-220,-200,-180,-160,-140,-120,-100,-90,-80,-70,-60,-50,-40,-30,-20,-10,0,1,2,3,4,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,120,140,160,180,200,220,240,260,280,300] 

LoadPlugin("D:/project_magnetosomes/magnetosomes_allcodes/MERRILL-plugins.xml", ns=globals())

filename = "3d{0}x_{1}y_{2}z_{3}d_10N_{4}b_{5}r".format(x, x, x, d, b, r)


view = CreateRenderView()
view.OrientationAxesVisibility = 0
view.Background = [1.0, 1.0, 1.0]
cam = view.GetActiveCamera()
cam.SetFocalPoint((x+d)*N/2e3,-y/1e3,-z/1e3)
cam.Dolly(5)
cam.Azimuth(210)
cam.Elevation(80)

iszoomed = False

try: 
	os.makedirs("D:/project_magnetosomes/plots/{0}".format(filename))
except OSError:
	if not os.path.isdir("D:/project_magnetosomes/plots/{0}".format(filename)):
		raise


# aa = range(1, 99, 1)
# aa = [a]; 


for h in H:
	mydata = OpenDataFile("D:/magnetosomes_3d/domainstates_bent3d/{0}/{1}_{2}_mT_{3}a_mult.tec".format(filename, filename, h, a))

	Show()
	Hide()
	hel = Helicity(mydata)
	helDis = Show(hel)
	helDis.Opacity = 0.3
	gly = Glyph(hel)
	Show(gly)
	gly.ScaleFactor = 0.04 * y/100
		
	Render()


	SaveScreenshot("D:/project_magnetosomes/plots/{0}/{1}_{2}_mT_{3}a.png".format(filename, filename, h, a), 
		view, ImageResolution=[2400, 2000], TransparentBackground=1)
		
	
	Delete(gly)
	Delete(helDis)
	Delete(hel)

