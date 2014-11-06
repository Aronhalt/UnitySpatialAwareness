#pragma strict
var playNormal : Texture2D;
var playHover : Texture2D;
var login : GameObject;
function Start () {

}

function OnMouseEnter() {
	guiTexture.texture = playHover;
}
function OnMouseExit() {
	guiTexture.texture = playNormal;
}
function OnMouseDown() {
	Instantiate(login, Vector3(0, 0, 0),Quaternion.identity);
	Destroy(GameObject.Find("ExitButton"));
	Destroy(gameObject);
	//Application.LoadLevel("SceneA");
}