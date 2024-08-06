using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnManager : MonoBehaviour
{
    public GameObject signPrefab; // 표지판 프리팹
    public GameObject truckPrefab; // 트럭 프리팹
    public float spawnInterval = 2f; // 장애물 생성 간격
    public float truckSpeed = 20f; // 트럭 이동 속도

    private float[] lanePositions = { -15f, -5f, 5f, 15f };
    private HashSet<int> occupiedLanes = new HashSet<int>();
    private Transform playerTransform;

    void Start()
    {
        playerTransform = GameObject.FindGameObjectWithTag("Player").transform;
        StartCoroutine(SpawnObstacles());
    }

    IEnumerator SpawnObstacles()
    {
        while (true)
        {
            SpawnObstacle();
            yield return new WaitForSeconds(spawnInterval);
        }
    }

    void SpawnObstacle()
    {
        // 사용 가능한 차선 선택
        List<int> availableLanes = new List<int>();
        for (int i = 1; i < lanePositions.Length - 1; i++)
        {
            if (!occupiedLanes.Contains(i))
            {
                availableLanes.Add(i);
            }
        }

        if (availableLanes.Count > 0)
        {
            int chosenLane = availableLanes[Random.Range(0, availableLanes.Count)];
            occupiedLanes.Add(chosenLane);

            // 장애물 타입 결정
            Vector3 spawnPosition = new Vector3(lanePositions[chosenLane], 0.1f, playerTransform.position.z + 100);
            if (Random.value < 0.5f)
            {
                // 표지판 생성
                Instantiate(signPrefab, spawnPosition, Quaternion.identity);
            }
            else
            {
                // 트럭 생성
                GameObject truck = Instantiate(truckPrefab, spawnPosition, Quaternion.Euler(0, 180, 0)); // 트럭을 180도 회전하여 생성
                truck.GetComponent<Truck>().speed = truckSpeed;
            }
        }

        // 차선 점유 정보 업데이트 (장애물 제거 시 업데이트)
        StartCoroutine(UpdateOccupiedLanes());
    }

    IEnumerator UpdateOccupiedLanes()
    {
        yield return new WaitForSeconds(spawnInterval * 2); // 일정 시간 후 업데이트
        occupiedLanes.Clear();
        foreach (GameObject obj in GameObject.FindGameObjectsWithTag("Obstacle"))
        {
            int lane = System.Array.IndexOf(lanePositions, obj.transform.position.x);
            if (lane >= 1 && lane <= 3)
            {
                occupiedLanes.Add(lane);
            }
        }
    }
}
