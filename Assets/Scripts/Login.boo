import UnityEngine

class Login (MonoBehaviour): 

	public username as string
	public gender as string
	public mystyle = GUIStyle()
	
	public playNormal as Texture2D
	public playHover as Texture2D
	
	def Start():
		w = .156*Screen.width
		h = .137*Screen.height
		x = (Screen.width-w)/2
		y = (Screen.height/2)-(1.4*h)
		guiTexture.pixelInset = Rect (x, y, w, h)
		Debug.Log(guiTexture.pixelInset)
		Debug.Log(Screen.width+":"+Screen.height)
		
	def OnGUI() as void:
		
		mystyle.fontSize = 20
		xcenter = Screen.width/2
		ycenter = Screen.height/2

		GUI.Label(Rect(xcenter,ycenter-70,10,10), "Enter Proctor", mystyle)
		GUI.Label(Rect(xcenter,ycenter-10,10,10), "Enter Gender", mystyle)
		
		username = GUI.TextField(Rect(xcenter-100, ycenter-50, 200, 25), username, 25)
		gender = GUI.TextField(Rect(xcenter-100, ycenter+10, 200, 20), gender, 25)

	def OnMouseEnter() as void:
		guiTexture.texture = playHover

	def OnMouseExit() as void:
		guiTexture.texture = playNormal

	def OnMouseDown() as void:
		saveCSV()
		PlayerPrefs.SetInt("state", 2)
		Application.LoadLevel("SceneA")
		
	def saveCSV ():
		Debug.Log("Got Here")
		filepath = "Data/data.csv"
		del = ","
		
		output = "$username$del$gender$del"
		try:
			using myfile = System.IO.StreamWriter(filepath, true):
				myfile.Write(output)
		except e:
			Debug.Log("There was an error in writing this object to data.scv")