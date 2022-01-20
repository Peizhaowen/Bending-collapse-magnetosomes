from paraview.simple import *
import os
import math



H =[-300,-280,-260,-240,-220,-200,-180,-160,-140,-120,-100,-90,-80,-70,-60,-50,-40,-30,-20,-10,0,1,2,3,4,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,120,140,160,180,200,220,240,260,280,300] 
# H=[0]
LoadPlugin("D:/project_magnetosomes/magnetosomes_allcodes/MERRILL-plugins.xml", ns=globals())

filename = "tomo16_402"

a = 1
view = CreateRenderView()
view.OrientationAxesVisibility = 0
view.Background = [1.0, 1.0, 1.0]
cam = view.GetActiveCamera()
cam.SetFocalPoint(50*10/2e3,-40/1e3,-40/1e3)
cam.Dolly(5)
# 原来是-50
cam.Azimuth(30)
# 原来是20
cam.Elevation(20)

iszoomed = False

try: 
	os.makedirs("D:/project_magnetosomes/plots/{0}".format(filename))
except OSError:
	if not os.path.isdir("D:/project_magnetosomes/plots/{0}".format(filename)):
		raise


# aa = range(1, 99, 1)
# aa = [a]; 


for h in H:
	mydata = OpenDataFile("D:/magnetosomes/domainstates_tomo/{0}/{1}_{2}_mT_{3}a_mult.tec".format(filename, filename, h, a))

	Show()
	Hide()
	hel = Helicity(mydata)
	helDis = Show(hel)
	helDis.Opacity = 0.3
	gly = Glyph(hel)
	Show(gly)
	gly.ScaleFactor = 0.04 * 40/100
    
	Render()


	SaveScreenshot("D:/project_magnetosomes/plots/{0}/{1}_{2}_mT_{3}a.png".format(filename, filename, h, a), 
		view, ImageResolution=[3600, 3000], TransparentBackground=1)
		
	
	Delete(gly)
	Delete(helDis)
	Delete(hel)

