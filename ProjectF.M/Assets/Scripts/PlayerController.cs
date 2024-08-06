using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public float forwardSpeed = 10f;
    public float laneChangeSpeed = 5f;
    public float gradualLaneChangeSpeed = 5f;
    private float[] lanePositions = { -25f, -15f, -5f, 5f, 15f, 25f };
    private int currentLane = 2; 
    private int futureLane = 2; 
    //private float timeSinceLastMove = 0f;
    //private float moveInterval = 0.5f; 
    private int lastInputDirection = 0;
    private bool isMove = false;
    private bool isInput= false;
    private float epsilon = 0.1f; // 오차 허용 범위
    void Start()
    {
        transform.position = new Vector3(lanePositions[currentLane], transform.position.y, -90);
    }

    void Update()
    {

        transform.Translate(Vector3.forward * forwardSpeed * Time.deltaTime);

        LaneFind();

        if (Input.GetKeyDown(KeyCode.LeftArrow))
        {
            futureLane = currentLane - 1;
            lastInputDirection = 1;
            isInput = true;
        }
        else if (Input.GetKeyDown(KeyCode.RightArrow))
        {
            futureLane = currentLane +1;
            lastInputDirection = -1;
            isInput = true;
        }
        Car_Move();
    }

    private void LaneFind()
    {
        if( transform.position.x <=-10f && transform.position.x >= -20f)
        {
            currentLane = 1;
        }
        else if(transform.position.x <= 0f && transform.position.x >= -10f)
        {
            currentLane = 2;
        }
        else if (transform.position.x <= 10f && transform.position.x >= 0f)
        {
            currentLane = 3;
        }
        else if (transform.position.x <= 20f && transform.position.x >= 10f)
        {
            currentLane = 4;
        }
    }

    private void Car_Move()
    {
        if (isInput)
        {
            isMove = true;
            float targetXPosition = lanePositions[futureLane];
            float xPosition = Mathf.Lerp(transform.position.x, targetXPosition, laneChangeSpeed * Time.deltaTime);
            transform.position = new Vector3(xPosition, transform.position.y, transform.position.z);
            if (Mathf.Abs(transform.position.x - lanePositions[futureLane]) < epsilon)
            {
                isMove = false;
                isInput = false;
            }
        }
        else
        {
            if (!isMove)
            {
                transform.Translate(Vector3.right * lastInputDirection * gradualLaneChangeSpeed * Time.deltaTime);
            }
        }
    }

}
