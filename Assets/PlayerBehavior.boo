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
	z = float = 0.0;
	
	enum state:
		Stage1 = 1
		Stage2 = 2
		
	index = 0#Position in list of inventory items.
	total = 0
	
	#Depth of placement, so you can fine tune right where objects drop.
	dop = 0.5
	

	public currentState = state.Stage2

	def Start ():
		currentState = state.Stage2
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
			UpdateCurrentItemPosition()#Updates position of items on screen.
			if(Input.GetKeyDown(KeyCode.Tab)):
				dop = .5
				self.incIndex()
			elif(Input.GetKeyDown(KeyCode.Space)):
				#Increase the distance from the player of held object
				dop+=.1
				#Placed[index] = true
				#index += 1
		
	def incIndex():
		obj = Objects[index] as GameObject
		obj.renderer.enabled = false
		obj.transform.position = Vector3(0,0,0)
		self.index += 1
		if(self.index >= total):
			self.index = 0
		Debug.Log(index + "    " + Placed[index])
		while(index < total-1 and Placed[index] != false):
			self.index+=1
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
			
			if (temp < 0):
				z -= .1
			else:
				z += .1	
			z = Mathf.Clamp(z, 0.0f,  1.0f)
			
		obj.transform.position = Camera.main.ScreenToWorldPoint(Vector3(Screen.width/2, Screen.height/2, (Camera.main.nearClipPlane+dop + z)))
		
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
		
		
