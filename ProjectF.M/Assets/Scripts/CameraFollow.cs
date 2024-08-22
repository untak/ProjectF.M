using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour
{
    public Transform player;       // 플레이어 차량의 Transform
    public Vector3 offset;         // 카메라와 플레이어 차량 간의 오프셋

    // 쿼터뷰와 탑뷰의 중간 정도의 각도를 지정합니다.
    public float distance = 10f;   // 차량과의 거리
    public float height = 5f;      // 차량 위로의 높이
    public float angle = 30f;      // 카메라 각도

    private bool gameStarted = false;

    void Start()
    {
        // 카메라의 초기 위치를 설정합니다.
        offset = new Vector3(0, height, -distance);
        offset = Quaternion.AngleAxis(angle, Vector3.right) * offset;
    }

    void LateUpdate()
    {
        if(gameStarted == true)
        {
            // 카메라의 위치를 플레이어 차량의 위치와 오프셋을 기반으로 설정합니다.
            transform.position = player.position + offset;
        }

    }
    public void GameStart()
    {
        gameStarted = true;
    }
}
