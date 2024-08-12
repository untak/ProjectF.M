using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnManager : MonoBehaviour
{
    public GameObject signPrefab; // 표지판 프리팹
    public GameObject truckPrefab; // 트럭 프리팹
    public GameObject motorcyclePrefab; // 오토바이 프리팹
    public GameObject sedanPrefab; // 승용차 프리팹
    public float spawnInterval = 1f; // 장애물 생성 간격
    public float truckSpeed = 20f; // 트럭 이동 속도

    private float[] lanePositions = { -15f, -5f, 5f, 15f };
    private HashSet<Vector3> occupiedPositions = new HashSet<Vector3>(); // 장애물이 점유한 위치
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
            // 장애물의 종류와 생성 여부 결정
            float obstacleRoll = Random.value;

            if (obstacleRoll < 0.4f)
            {
                // 표지판 생성
                SpawnSign();
            }
            else if (obstacleRoll < 0.8f)
            {
                // 차량 생성 (승용차 또는 트럭)
                SpawnVehicle();
            }

            // 오토바이 생성 확률 따로 계산
            float motorcycleRoll = Random.value;
            if (motorcycleRoll < 0.3f) // 20% 확률로 오토바이 생성
            {
                SpawnMotorcycle();
            }

            yield return new WaitForSeconds(spawnInterval);
        }
    }

    void SpawnSign()
    {
        int chosenLane = ChooseAvailableLane();
        if (chosenLane != -1)
        {
            Vector3 spawnPosition = new Vector3(lanePositions[chosenLane], 0.1f, playerTransform.position.z + 200);
            if (!IsPositionOccupied(spawnPosition))
            {
                Instantiate(signPrefab, spawnPosition, Quaternion.identity);
                occupiedPositions.Add(spawnPosition);
            }
        }
    }

    void SpawnVehicle()
    {
        int chosenLane = ChooseAvailableLane();
        if (chosenLane != -1)
        {
            Vector3 spawnPosition = new Vector3(lanePositions[chosenLane], 1f, playerTransform.position.z + 200);
            if (!IsPositionOccupied(spawnPosition))
            {
                if (Random.value < 0.5f)
                {
                    // 승용차 생성
                    Instantiate(sedanPrefab, spawnPosition, Quaternion.Euler(0, 180, 0));
                }
                else
                {
                    // 트럭 생성
                    GameObject truck = Instantiate(truckPrefab, spawnPosition, Quaternion.Euler(0, 180, 0));
                    truck.GetComponent<Truck>().speed = truckSpeed;
                }
                occupiedPositions.Add(spawnPosition);
            }
        }
    }

    void SpawnMotorcycle()
    {
        int chosenLane = ChooseAvailableLane();
        if (chosenLane != -1)
        {
            List<float> availableOffsets = new List<float> { -2.5f, 0f, 2.5f };
            Vector3 motorcycleSpawnPosition = Vector3.zero;
            bool positionFound = false;

            foreach (float offset in availableOffsets)
            {
                Vector3 potentialPosition = new Vector3(lanePositions[chosenLane] + offset, 0.1f, playerTransform.position.z + 200);
                if (!IsPositionOccupied(potentialPosition))
                {
                    motorcycleSpawnPosition = potentialPosition;
                    positionFound = true;
                    break;
                }
            }

            if (positionFound)
            {
                Instantiate(motorcyclePrefab, motorcycleSpawnPosition, Quaternion.Euler(0, 180, 0));
                occupiedPositions.Add(motorcycleSpawnPosition);
            }
        }
    }

    int ChooseAvailableLane()
    {
        List<int> availableLanes = new List<int>();
        for (int i = 0; i < lanePositions.Length; i++)
        {
            Vector3 laneCenterPosition = new Vector3(lanePositions[i], 0.1f, playerTransform.position.z + 100);
            if (!IsPositionOccupied(laneCenterPosition))
            {
                availableLanes.Add(i);
            }
        }

        return availableLanes.Count > 0 ? availableLanes[Random.Range(0, availableLanes.Count)] : -1;
    }

    bool IsPositionOccupied(Vector3 position)
    {
        return occupiedPositions.Contains(position);
    }

    IEnumerator UpdateOccupiedLanes()
    {
        yield return new WaitForSeconds(spawnInterval * 2); // 일정 시간 후 업데이트
        occupiedPositions.Clear();
        foreach (GameObject obj in GameObject.FindGameObjectsWithTag("Obstacle"))
        {
            Vector3 pos = new Vector3(obj.transform.position.x, 0.1f, obj.transform.position.z);
            occupiedPositions.Add(pos);
        }
    }
}
