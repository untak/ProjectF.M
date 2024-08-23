using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RoadManager : MonoBehaviour
{
    public Transform player;
    public GameObject[] roadPrefabs; // 3가지 일반 도로 프리팹 배열
    public GameObject finishLinePrefab; // 결승선 도로 프리팹
    private float roadLength = 200f; // 도로 길이
    private float spawnZPosition = 0f; // 도로 스폰 위치
    private int roadCountOnScreen = 6; // 화면에 유지할 도로 개수
    private List<GameObject> activeRoads = new List<GameObject>(); // 현재 활성화된 도로들
    private int currentRoadIndex = 0; // 현재 사용 중인 도로 인덱스
    private float roadChangeInterval = 210f; // 3분 30초(210초)마다 도로 변경
    private float finishLineTime = 600f; // 10분 후에 결승선 생성
    private bool finishLineSpawned = false; // 결승선이 생성되었는지 여부

    void Start()
    {
        // 코루틴 시작: 3분 30초마다 도로 타입 변경
        StartCoroutine(ChangeRoadType());

        // 첫 화면에 보일 도로들을 스폰
        for (int i = 0; i < roadCountOnScreen; i++)
        {
            SpawnRoad();
        }
    }

    void Update()
    {
        // 플레이어가 일정 거리 이상 이동했을 때 새로운 도로를 스폰
        if (player.position.z - roadLength > spawnZPosition - (roadCountOnScreen * roadLength))
        {
            SpawnRoad();
            RemoveOldRoad();
        }
    }

    void SpawnRoad()
    {
        GameObject newRoad;

        // 10분이 경과하고 결승선이 아직 생성되지 않았을 때 결승선 도로를 생성
        if (Time.time >= finishLineTime && !finishLineSpawned)
        {
            newRoad = Instantiate(finishLinePrefab, new Vector3(0, 0, spawnZPosition), Quaternion.identity);
            finishLineSpawned = true;
        }
        else
        {
            // 현재 도로 인덱스에 맞는 도로를 스폰
            newRoad = Instantiate(roadPrefabs[currentRoadIndex], new Vector3(0, 0, spawnZPosition), Quaternion.identity);
        }

        activeRoads.Add(newRoad);
        spawnZPosition += roadLength; // 다음 도로 스폰 위치 갱신
    }

    void RemoveOldRoad()
    {
        // 화면에서 벗어난 가장 오래된 도로를 제거
        Destroy(activeRoads[0]);
        activeRoads.RemoveAt(0);
    }

    IEnumerator ChangeRoadType()
    {
        while (!finishLineSpawned) // 결승선이 스폰될 때까지 도로 타입을 변경
        {
            yield return new WaitForSeconds(roadChangeInterval); // 3분 30초 대기
            currentRoadIndex = (currentRoadIndex + 1) % roadPrefabs.Length; // 도로 타입 순환
        }
    }
}
