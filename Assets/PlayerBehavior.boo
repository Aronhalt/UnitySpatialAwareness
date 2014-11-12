import UnityEngine

/*
Alexander Quigley Freedman + the 2014 Spacial Memory Unity Team
I like to write some useful info up here if I can.

This code in total should give all of the things the player can do, besides moving.
Included is holding objects, moving them around and placing them.

Terms:
	held object - means the object currently selected by index
	dop - Depth of Displacement which is how far from the player the held object is.
*/
class PlayerBehavior (MonoBehaviour): 
	
	Objects = []
	Placed = []
	numPlaced = 0#We should probably scrap my Placed idea above for something better.
	z = float = 0.0;
	p = 0
	showConfidenceGui = false
	
	enum state:
		Stage1 = 1
		Stage2 = 2
		
	index = 0#Position in list of inventory items.
	total = 0
	
	#Depth of placement, so you can fine tune right where objects drop.
	dop = 0.5

	public currentState = state.Stage2

	def Start ():
		currentState = PlayerPrefs.GetInt("state")
		if currentState == state.Stage1:
			pass
		elif currentState == state.Stage2:
			for obj in GameObject.FindGameObjectsWithTag('Placeable'):
				Objects.Add(obj)
				Placed.Add(false)
				obj.renderer.enabled = false
				obj.transform.position = Vector3(0,0,0)
				#Debug.Log("$obj")
			total = len(Objects)
	
	def Update ():
		if currentState == state.Stage1:
			pass
		elif currentState == state.Stage2:
			if (index < total):
				#Check whether you should be placing objects or giving a confidence
				if not showConfidenceGui:
				    UpdateCurrentItemPosition()#Updates position of items on screen.
					if(Input.GetKeyDown(KeyCode.Tab)):
						dop = .5
						if(p < total):
							self.incIndex()
					elif(Input.GetMouseButtonDown(0)):
						#Increase the distance from the player of held object
						#dop+=.1
						showConfidenceGui = true
				else:
					if(Input.GetKeyDown(KeyCode.Backspace)):
						showConfidenceGui = false
					else:
						for i in range(1,8):#Bad way to do this, rewrite later.
							if(Input.GetKeyDown("" + i)):
								obj = Objects[index] as GameObject
								obj.GetComponent[of WriteCoordinates]().saveCSV(i)
								showConfidenceGui = false
								Placed[index] = true
								p++
								i = index
								numPlaced += 1 #This should show us when we've 
								while(Placed[i]):
									if(p >= total):
										i = total+1
										break
									i++
									if(i>=total):
										i = 0
								index = i
								if(numPlaced >= total):
									#Debug.Log("$total")
									self.finishCSVsave()
									self.reset()
									
							
			else:
				pass
		
	#Will just Exit the game for now, should be changed later.
	#Maybe Reset to scene 1? Perhaps say YOU WIN(even if you don't)
	public def reset():
		Debug.Log("EXIT")
		Application.Quit()
			
	#Last step before exiting (or restarting) the game, sets data.csv up for the next runthrough
	public def finishCSVsave():
		filepath = "Data/data.csv"
		output = Time.time
		try:
			using myfile = System.IO.StreamWriter(filepath, true):
				myfile.WriteLine(output)
		except e:
			Debug.Log("There was an error in finishing writing to data.scv\nYou should press return in the document to set the writer to a newline.")
		
	def incIndex():
		obj = Objects[index] as GameObject
		obj.renderer.enabled = false
		obj.transform.position = Vector3(0,0,0)
		index++
		if(self.index >= total):
			self.index = 0
		while(Placed[index]):
			index++
			if(index >= total):
				index = 0
		Debug.Log(index + "    " + Placed[index])
		//while(index < total-1 and Placed[index] != false):
		//	self.index+=1
	def decIndex():
		obj = Objects[index] as GameObject
		obj.renderer.enabled = false
		obj.transform.position = Vector3(0,0,0)
		self.index -= 1
		if(self.index < 0):
			self.index = total-1
		while(index > 0 and Placed[index] != false):
			self.index+=1
		
	#This next method is for placing items in front of the player on screen.
	#A thank you to the 2013 Unity Team for coming up with most of this code, in javascript.
	def UpdateCurrentItemPosition():
		#Grabs the correct item (defined by index) form your inventory list
		obj = Objects[index] as GameObject
		#p = obj.GetComponent()
		#Debug.Log("$obj")
		if(obj is null): #Checks to make sure it really got something
			Debug.Log("NOPE")
			return
		#All objects are invisible on the map right now, this changes that for the current item.
		obj.renderer.enabled = true
		
		### OLD VERSION ###
		#Moves the object to infront of the player
		#obj.transform.position = gameObject.transform.position
		#obj.transform.position += 2 * gameObject.transform.forward
		
		### NEW VERSION OF PLACING OBJECT ON SCREEN ###
		#Moves the selected(index) object out of your inventory and to infront of you.
		if (Input.GetAxis("Mouse ScrollWheel")):
			temp = Input.GetAxis("Mouse ScrollWheel")
			
			if (temp < 0 and dop > 0.5):
				dop -= 0.1
			elif (temp > 0 and dop < 1.0):
				dop += 0.1	
			
		obj.transform.position = Camera.main.ScreenToWorldPoint(Vector3(Screen.width/2, Screen.height/2, (Camera.main.nearClipPlane+dop)))
		
		#apply correction offset
		/*obj.transform.position += p.offset.x * gameObject.transform.right.normalized;
		obj.transform.position += p.offset.y * gameObject.transform.up.normalized;
		obj.transform.position += p.offset.z * gameObject.transform.forward.normalized;

		heightDelta = Terrain.VerticalDisplacement(obj) - Terrain.VerticalDisplacement(p.InitialPos());
		if(heightDelta < 0):
			obj.transform.position.y += -heightDelta + 0.01;


		#lock rotation angle
		obj.transform.eulerAngles.y = gameObject.transform.eulerAngles.y;

		#apply correction rotation
		obj.transform.rotation.eulerAngles += p.rotation;*/
		
	def OnConfidenceGUI ():
		dialogWidth = 400;
		dialogHeight = 200;

		//TODO : make the dialog pretty!
		GUI.backgroundColor = Color.green
		GUILayout.BeginArea(Rect((Screen.width - dialogWidth) / 2, (Screen.height - dialogHeight) / 2, dialogWidth, dialogHeight))
		GUILayout.BeginVertical("Box")
		GUILayout.FlexibleSpace()

		GUILayout.BeginHorizontal()
		GUILayout.FlexibleSpace()
		GUILayout.Label("press [1 - 7] to indicate how confident you are")
		GUILayout.FlexibleSpace()
		GUILayout.EndHorizontal()

		GUILayout.BeginHorizontal()
		GUILayout.FlexibleSpace()
		GUILayout.Label("press [Backspace] to pick this item back up")
		GUILayout.FlexibleSpace()
		GUILayout.EndHorizontal()

		GUILayout.FlexibleSpace()
		GUILayout.EndVertical()
		GUILayout.EndArea()
	
	def OnGUI():
		//Debug.Log(showConfidenceGui)
		if(showConfidenceGui):
			OnConfidenceGUI()