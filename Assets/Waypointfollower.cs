using UnityEngine;
using System.Collections;

public class Waypointfollower : MonoBehaviour {

	//public Transform[] wayPoint = new Transform[9]; 
	public GameObject[] wayPoint;
	int currentWayPoint = 0;
	private NavMeshAgent agent;
	public Transform destination;
	//float rotationSpeed = 6.0f;
	public float accelerate = 1.8f;

	
	// Use this for initialization
	//to do, write a function that goes out and finds the waypoints
	void Start () 
	{
		agent = gameObject.GetComponent<NavMeshAgent>();
		wayPoint = GameObject.FindGameObjectsWithTag("Waypoint"); 
		/*wayPoint[0] = GameObject.Find("Waypoint1").transform;
		wayPoint[1] = GameObject.Find("Waypoint2").transform;
		wayPoint[2] = GameObject.Find("Waypoint3").transform;
		wayPoint[3] = GameObject.Find("Waypoint4").transform;
		wayPoint[4] = GameObject.Find("Waypoint5").transform;
		wayPoint[5] = GameObject.Find("Waypoint6").transform;
		wayPoint[6] = GameObject.Find("Waypoint7").transform;
		wayPoint[7] = GameObject.Find("Waypoint8").transform;
		wayPoint[8] = GameObject.Find("Waypoint9").transform;*/
	}
	
	// Update is called once per frame
	//to do mouse wheel speed ups and slow downs
	//smoother tranisions
	void Update () 
	{
		if(currentWayPoint >= (wayPoint.Length))
		{
			//return;
		}
		else
		{
			if (Input.GetAxis("Mouse ScrollWheel")  < 0) // forward
			{
				agent.speed -= 0.8f;
			}
			if (Input.GetAxis("Mouse ScrollWheel")  > 0) // forward
			{
				agent.speed += 0.8f;
			}
			if(agent.speed <=0)
			{	
				agent.speed =0;
			}else{


				walk();
			}
		}
	}
	
	void walk()
	{

		if (!agent.pathPending && agent.remainingDistance < 0.5f && (currentWayPoint < wayPoint.Length))//Vector3.Distance(wayPoint[currentWayPoint].transform.position, transform.position) < 1)//accelerate)
		{
			//float temp = agent.speed;
			//print( agent.remainingDistance);
			//agent.speed = 0;
			agent.SetDestination(wayPoint[currentWayPoint].transform.position);
			currentWayPoint++;
			//agent.speed = temp;
		}
		//agent.SetDestination(destination.position);
		/*Quaternion rotation = Quaternion.LookRotation(wayPoint[currentWayPoint].transform.position - transform.position);
		transform.rotation = Quaternion.Slerp(transform.rotation, rotation, Time.deltaTime*rotationSpeed);
		
		Vector3 wayPointDirection = wayPoint[currentWayPoint].transform.position - transform.position;
		float speedElement = Vector3.Dot(wayPointDirection.normalized, transform.forward);
		float speed = accelerate + speedElement;
		transform.Translate(0,0,Time.deltaTime*speed);
		*/

	}
	
	void OnTriggerEnter(Collider collider)
	{
		if(collider.tag == "WayPoint")
			currentWayPoint++;  
	}
}
