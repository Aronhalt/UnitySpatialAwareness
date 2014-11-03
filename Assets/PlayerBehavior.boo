import UnityEngine

class PlayerBehavior (MonoBehaviour): 
	
	Objects = []
	
	enum state:
		Stage1 = 1
		Stage2 = 2
		
	index = 0#Position in list of inventory items.
	

	public currentState = state.Stage2

	def Start ():
		currentState = state.Stage2
		if currentState == state.Stage1:
			pass
		elif currentState == state.Stage2:
			for obj in GameObject.FindGameObjectsWithTag('Placeable'):
				Objects.Add(obj)
				obj.renderer.enabled = false
				Debug.Log("$obj")
	
	def Update ():
		if currentState == state.Stage1:
			pass
		elif currentState == state.Stage2:
			UpdateCurrentItemPosition()
		
	def incIndex():
		self.index += 1
	def decIndex():
		self.index -= 1
		
	#This next method is for placing items in front of the player on screen.
	#A thank you to the 2013 Unity Team for coming up with most of this code, in javascript.
	def UpdateCurrentItemPosition():
		#Grabs the correct item (defined by index) form your inventory list
		obj = Objects[index] as GameObject
		p = obj.GetComponent()
		#Debug.Log("$obj")
		if(obj is null): #Checks to make sure it really got something
			Debug.Log("NOPE")
			return
		#All objects are invisible on the map right now, this changes that for the current item.
		obj.renderer.enabled = true
		
		#Moves the object to infront of the player
		obj.transform.position = gameObject.transform.position
		obj.transform.position += 2 * gameObject.transform.forward
		
		#apply correction offset
		obj.transform.position += p.offset.x * gameObject.transform.right.normalized;
		obj.transform.position += p.offset.y * gameObject.transform.up.normalized;
		obj.transform.position += p.offset.z * gameObject.transform.forward.normalized;

		/*heightDelta = Terrain.VerticalDisplacement(obj) - Terrain.VerticalDisplacement(p.InitialPos());
		if(heightDelta < 0):
			obj.transform.position.y += -heightDelta + 0.01;*/


		#lock rotation angle
		obj.transform.eulerAngles.y = gameObject.transform.eulerAngles.y;

		#apply correction rotation
		obj.transform.rotation.eulerAngles += p.rotation;
		
		
