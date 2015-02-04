import UnityEngine
#import System.Collections

class elevatorManager (MonoBehaviour):
		public delayTime = 0.0 
		tFloors = 3
		currentFloor =0
		floorsRemaining = 3
		nextScene = []
		floors = []
		

		def Start ():
			
			#buildfloors
			#currentFloor = tFloors - floorsRemaining
			floors.Add("movementtestWIP")
			floors.Add("SceneA")
			floors.Add("blackScreen")
			 
		def Awake() as void:
			DontDestroyOnLoad(transform.gameObject)	 
		def Update ():
			pass
		 
		def getDelay():
			return delayTime
		def getFloor():
			return tFloors -floorsRemaining
		def getNextFloor():
		 
			floorsRemaining--
			if floorsRemaining <= 0:
				Debug.Log("going to next scene")
				Application.LoadLevel(0)
				#go to next scene
				#temp = nextScene.first
				#remove nextScene. first
				#add temp to end of nextscene
				#return nextScene.first
			else:
				Debug.Log("going to next floor")
				Application.LoadLevel(tFloors -floorsRemaining)
				#Application.LoadLevel(nextScene[])
				#move up onefloor in current scene
				#go to floor floor[currentfloor+1]
				#currentFloor++
				#return currentFloor
	 