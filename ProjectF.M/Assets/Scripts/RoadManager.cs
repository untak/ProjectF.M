using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RoadManager : MonoBehaviour
{
    public Transform player;
    public GameObject[] roads;
    private float roadLength = 200f; // 도로 길이를 200으로 설정
    private float nextMoveThreshold;
    private int lastMovedRoadIndex = 0;

    void Start()
    {
        // 도로의 초기 위치 설정
        for (int i = 0; i < roads.Length; i++)
        {
            roads[i].transform.position = new Vector3(0, 0, i * roadLength);
        }
        // 첫 번째 도로 이동 기준점 설정
        nextMoveThreshold = roadLength;  // 첫 번째 도로의 끝
    }

    void Update()
    {
        if (player.position.z > nextMoveThreshold)
        {
            MoveRoad();
            nextMoveThreshold += roadLength;  // 다음 도로의 끝으로 갱신
        }
    }

    void MoveRoad()
    {
        // 도로를 번갈아 가면서 앞으로 이동
        GameObject roadToMove = roads[lastMovedRoadIndex];
        // 현재 마지막 도로의 뒤에 위치하도록 새로운 위치 계산
        float newZPosition = roads[(lastMovedRoadIndex + roads.Length - 1) % roads.Length].transform.position.z + roadLength;
        roadToMove.transform.position = new Vector3(0, 0, newZPosition);

        // 인덱스를 다음으로 갱신
        lastMovedRoadIndex = (lastMovedRoadIndex + 1) % roads.Length;
    }
}
