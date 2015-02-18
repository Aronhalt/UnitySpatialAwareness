import UnityEngine

class MasterScript (MonoBehaviour): 
	Scene = ""
	flag = 0
	public timer = 120.0
	public delayTime = 0.0 
	tFloors = 4
	currentFloor =0
	state = 1
	floorsRemaining = 4	
	nextScene = ["testEle3"]
	floors = ['movementtestWIP',
				'testEle1',
				'testEle2',
				'SceneA']


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
					 
	def getDelay():
		return delayTime
	
	def getNextFloor():
	 
		floorsRemaining--
		if floorsRemaining <= 0:
			Debug.Log("going to next scene")
			if state == 1:
				state = 2
				floorsRemaining = len(floors)
				Application.LoadLevel(floors[tFloors-floorsRemaining] as string)
			else:
				Application.LoadLevel(nextScene[0] as string)
			#go to next scene
			#temp = nextScene.first
			#remove nextScene. first
			#add temp to end of nextscene
			#return nextScene.first
		else:
			Debug.Log("going to next floor")
			
			Application.LoadLevel(floors[tFloors-floorsRemaining] as string)
			#Application.LoadLevel(nextScene[])
			#move up onefloor in current scene
			#go to floor floor[currentfloor+1]
			#currentFloor++
			#return currentFloor
	def floorBuild():
			floors.Add("movementtestWIP")
			floors.Add("testEle1")
			floors.Add("testEle2")
			floors.Add("SceneA")
			
			nextScene.Add("testEle3")
			
		
	 