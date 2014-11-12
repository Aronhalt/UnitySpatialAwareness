import UnityEngine

class MasterScript (MonoBehaviour): 
	Scene = ""
	flag = 0
	timer = 120.0

	def Awake ():
		Scene = Application.loadedLevelName
		newScene = Scene
		GameObject.DontDestroyOnLoad(self)
		
		if (GameObject.FindObjectsOfType(GetType()).Length > 1):
			Destroy(self)
	
	def Update():
		
		if (timer > 0.0):
			timer = timer - Time.deltaTime;
		
		if (timer <= 0 and flag == 1):
			Application.LoadLevel(Scene)
			flag = 0
		
	def loadNewScene():
		if (timer <= 0 and flag == 0):
			Application.LoadLevel("blackScreen")
			flag = 1
			timer = 120.0
