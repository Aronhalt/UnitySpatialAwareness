import UnityEngine

class MasterScript (MonoBehaviour): 
	Scene = ""
	flag = 0
	timer = 120.0

	def Awake ():
		Scene = Application.loadedLevelName
		GameObject.DontDestroyOnLoad(self)
		
		if (GameObject.FindObjectsOfType(GetType()).Length > 1):
			Destroy(self)
	
	def Update():
		
		if (timer > 0.0 and flag != 2):
			timer = timer - Time.deltaTime;
		
		if (timer <= 0 and flag == 1):
			Application.LoadLevel(Scene)
			PlayerPrefs.SetInt("state", 2)
			flag = 2
		
	def loadNewScene():
		if (timer <= 0 and flag == 0):
			Application.LoadLevel("blackScreen")
			flag = 1
			timer = 120.0
