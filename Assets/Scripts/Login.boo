import UnityEngine

class Login (MonoBehaviour): 

	public username as string
	public gender as string
	public age as string
	public mystyle = GUIStyle()
	
	def OnGUI() as void:
		
		mystyle.fontSize = 20
		xcenter = Screen.width/2
		ycenter = Screen.height/2
		
		

		GUI.Label(Rect(xcenter,ycenter-70,10,10), "Enter Name", mystyle)
		GUI.Label(Rect(xcenter,ycenter-10,10,10), "Enter Gender", mystyle)
		GUI.Label(Rect(xcenter,ycenter+50,10,10), "Enter Age", mystyle)
		
		
		username = GUI.TextField(Rect(xcenter-100, ycenter-50, 200, 25), username, 25)
		gender = GUI.TextField(Rect(xcenter-100, ycenter+10, 200, 20), gender, 25)
		age = GUI.TextField(Rect(xcenter-100, ycenter+70, 200, 20), age, 25)
