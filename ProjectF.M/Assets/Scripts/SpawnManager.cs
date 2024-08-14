using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnManager : MonoBehaviour
{
    public GameObject signPrefab; // ǥ���� ������
    public GameObject truckPrefab; // Ʈ�� ������
    public GameObject motorcyclePrefab; // ������� ������
    public GameObject sedanPrefab; // �¿��� ������
    public GameObject boosterPrefab; // �ν��� ������ ������
    public GameObject shieldPrefab; // �ǵ� ������ ������
    public float spawnInterval = 1f; // ��ֹ� ���� ����
    public float itemSpawnInterval = 60f; // ������ ���� ����
    public float truckSpeed = 20f; // Ʈ�� �̵� �ӵ�

    private float[] lanePositions = { -15f, -5f, 5f, 15f };
    private float[] itemLanePositions = { -10f, 0f, 10f }; // ������ ���� ��ġ
    private HashSet<Vector3> occupiedPositions = new HashSet<Vector3>(); // ��ֹ��� ������ ��ġ
    private Transform playerTransform;

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
            Vector3 spawnPosition = new Vector3(itemLanePositions[chosenLane], 2f, playerTransform.position.z + 100);

            float itemRoll = Random.value;
            if (itemRoll < 0.5f)
            {
                // �ν��� ������ ����
                Instantiate(boosterPrefab, spawnPosition, Quaternion.identity);
            }
            else
            {
                // �ǵ� ������ ����
                Instantiate(shieldPrefab, spawnPosition, Quaternion.identity);
            }

            yield return new WaitForSeconds(itemSpawnInterval);
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
        yield return new WaitForSeconds(spawnInterval * 2);
        occupiedPositions.Clear();
        foreach (GameObject obj in GameObject.FindGameObjectsWithTag("Obstacle"))
        {
            Vector3 pos = new Vector3(obj.transform.position.x, 0.1f, obj.transform.position.z);
            occupiedPositions.Add(pos);
        }
    }
}
