using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnManager : MonoBehaviour
{
    public GameObject signPrefab; // 표지판 프리팹
    public GameObject truckPrefab; // 트럭 프리팹
    public GameObject motorcyclePrefab; // 오토바이 프리팹
    public GameObject sedanPrefab; // 승용차 프리팹
    public GameObject boosterPrefab; // 부스터 아이템 프리팹
    public GameObject shieldPrefab; // 실드 아이템 프리팹
    public float spawnInterval = 1f; // 장애물 생성 간격
    public float itemSpawnInterval = 60f; // 아이템 생성 간격
    public float truckSpeed = 20f; // 트럭 이동 속도
    public float sedanSpeed = 10f; // 승용차 이동 속도
    public float motorcycleSpeed = 40f; // 오토바이 이동 속도

    private float[] lanePositions = { -15f, -5f, 5f, 15f };
    private float[] itemLanePositions = { -10f, 0f, 10f }; // 아이템 차선 위치
    private HashSet<Vector3> occupiedPositions = new HashSet<Vector3>(); // 장애물이 점유한 위치
    private Transform playerTransform;

    private float minSpawnDistance = 300f; // 장애물 최소 스폰 거리
    private float maxSpawnDistance = 500f; // 장애물 최대 스폰 거리

    void Start()
    {
        playerTransform = GameObject.FindGameObjectWithTag("Player").transform;
        StartCoroutine(SpawnObstacles());
        StartCoroutine(SpawnItems());
    }

    IEnumerator SpawnObstacles()
    {
        while (true)
        {
            float obstacleRoll = Random.value;

            if (obstacleRoll < 0.4f)
            {
                SpawnSign();
            }
            else if (obstacleRoll < 0.8f)
            {
                SpawnVehicle();
            }

            float motorcycleRoll = Random.value;
            if (motorcycleRoll < 0.3f)
            {
                SpawnMotorcycle();
            }

            yield return new WaitForSeconds(spawnInterval);
        }
    }

    IEnumerator SpawnItems()
    {
        while (true)
        {
            int chosenLane = Random.Range(0, itemLanePositions.Length);
            Vector3 spawnPosition = new Vector3(itemLanePositions[chosenLane], 1.5f, playerTransform.position.z + Random.Range(minSpawnDistance, maxSpawnDistance));

            float itemRoll = Random.value;
            if (itemRoll < 0.5f)
            {
                // 부스터 아이템 생성
                Instantiate(boosterPrefab, spawnPosition, Quaternion.Euler(0, 180, 0));
            }
            else
            {
                // 실드 아이템 생성
                Instantiate(shieldPrefab, spawnPosition, Quaternion.Euler(270, 0, 0));
            }

            yield return new WaitForSeconds(itemSpawnInterval);
        }
    }

    void SpawnSign()
    {
        int chosenLane = ChooseSafeLane(0); // 표지판은 속도가 0이므로 속도를 고려하지 않음
        if (chosenLane != -1)
        {
            Vector3 spawnPosition = new Vector3(lanePositions[chosenLane], 0.1f, playerTransform.position.z + Random.Range(minSpawnDistance, maxSpawnDistance));
            if (!IsPositionOccupied(spawnPosition))
            {
                Instantiate(signPrefab, spawnPosition, Quaternion.identity);
                occupiedPositions.Add(spawnPosition);
            }
        }
    }

    void SpawnVehicle()
    {
        float vehicleSpeed = Random.value < 0.5f ? sedanSpeed : truckSpeed;
        int chosenLane = ChooseSafeLane(vehicleSpeed);
        if (chosenLane != -1)
        {
            Vector3 spawnPosition = new Vector3(lanePositions[chosenLane], 1f, playerTransform.position.z + Random.Range(minSpawnDistance, maxSpawnDistance));
            if (!IsPositionOccupied(spawnPosition))
            {
                if (vehicleSpeed == sedanSpeed)
                {
                    Instantiate(sedanPrefab, spawnPosition, Quaternion.Euler(0, 180, 0));
                }
                else
                {
                    GameObject truck = Instantiate(truckPrefab, spawnPosition, Quaternion.Euler(0, 180, 0));
                    truck.GetComponent<Truck>().speed = truckSpeed;
                }
                occupiedPositions.Add(spawnPosition);
            }
        }
    }

    void SpawnMotorcycle()
    {
        int chosenLane = ChooseSafeLane(motorcycleSpeed);
        if (chosenLane != -1)
        {
            Vector3 spawnPosition = new Vector3(lanePositions[chosenLane], 1f, playerTransform.position.z + Random.Range(minSpawnDistance, maxSpawnDistance));
            if (!IsPositionOccupied(spawnPosition))
            {
                Instantiate(motorcyclePrefab, spawnPosition, Quaternion.Euler(0, 180, 0));
                occupiedPositions.Add(spawnPosition);
            }
        }
    }

    int ChooseSafeLane(float obstacleSpeed)
    {
        List<int> availableLanes = new List<int>();
        float playerZPosition = playerTransform.position.z;

        for (int i = 0; i < lanePositions.Length; i++)
        {
            bool isSafe = true;
            foreach (Vector3 occupiedPosition in occupiedPositions)
            {
                if (Mathf.Abs(occupiedPosition.x - lanePositions[i]) < 5f)
                {
                    float distance = Mathf.Abs(occupiedPosition.z - (playerZPosition + minSpawnDistance));
                    if (distance < (obstacleSpeed * 0.5f)) // 충돌을 최소화하기 위해 거리 고려
                    {
                        isSafe = false;
                        break;
                    }
                }
            }

            if (isSafe)
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

    //IEnumerator UpdateOccupiedLanes()
    //{
    //    yield return new WaitForSeconds(spawnInterval * 2);
    //    occupiedPositions.Clear();
    //    foreach (GameObject obj in GameObject.FindGameObjectsWithTag("Obstacle"))
    //    {
    //        Vector3 pos = new Vector3(obj.transform.position.x, 0.1f, obj.transform.position.z);
    //        occupiedPositions.Add(pos);
    //    }
    //}
}
