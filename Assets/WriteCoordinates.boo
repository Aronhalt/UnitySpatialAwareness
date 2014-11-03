﻿import UnityEngine

class WriteCoordinates (MonoBehaviour): 

	placed = 0 #Checks whether object has been placed
	confidence = 0 #Confidence score on placement of object
	startX = 0.0
	startY = 0.0
	endX = 0.0
	endY = 0.0

	def Start ():
		self.startX = transform.position.x
		self.startY = transform.position.y
		#Debug.Log("This is x = $startX and this is y = $startY")
	
	def Update ():
		pass
			
	def saveCSV ():
		self.endX = transform.position.x
		self.endY = transform.position.y
		filepath = "Data/data.csv"
		del = ","
		
		output = "$startX$del$startY$del$endX$del$endY$del$confidence"
		try:
			using myfile = System.IO.StreamWriter(filepath, true):
				myfile.WriteLine(output)
		except e:
			Debug.Log("There was an error in writing this object to data.scv")
			
	/*def OnGUI ():
		if placed == 1:
			getConfidence()

	def getConfidence ():
		dialogWidth = 400
		dialogHeight = 200
		
		GUI.backgroundColor = Color.green
		GUILayout.BeginArea(Rect((Screen.width - dialogWidth) / 2, (Screen.height - dialogHeight) / 2, dialogWidth, dialogHeight))
		GUILayout.BeginVertical("Box")
		GUILayout.FlexibleSpace()
		
		GUILayout.EndVertical()
		GUILayout.EndArea()
		
		/ GUI.backgroundColor = Color.green
  		GUILayout.BeginArea(Rect((Screen.width - dialogWidth) / 2, (Screen.height - dialogHeight) / 2, dialogWidth, dialogHeight))
    	GUILayout.BeginVertical("Box")
      	GUILayout.FlexibleSpace()

      	GUILayout.BeginHorizontal()
        GUILayout.FlexibleSpace()
        #GUILayout.Label("press [" + CONFIDENCE_MIN + " - " + CONFIDENCE_MAX + "] to indicate how confident you are")
        GUILayout.FlexibleSpace()
      	GUILayout.EndHorizontal()

      	GUILayout.BeginHorizontal()
        GUILayout.FlexibleSpace()
        #GUILayout.Label("press [" + closeDialogKey + "] to pick this item back up")
        GUILayout.FlexibleSpace()
      	GUILayout.EndHorizontal()

      	GUILayout.FlexibleSpace()
    	GUILayout.EndVertical()
  		GUILayout.EndArea()*/