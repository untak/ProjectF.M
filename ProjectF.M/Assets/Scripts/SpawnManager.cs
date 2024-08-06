using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnManager : MonoBehaviour
{
    public GameObject signPrefab; // ǥ���� ������
    public GameObject truckPrefab; // Ʈ�� ������
    public float spawnInterval = 2f; // ��ֹ� ���� ����
    public float truckSpeed = 20f; // Ʈ�� �̵� �ӵ�

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
        // ��� ������ ���� ����
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

            // ��ֹ� Ÿ�� ����
            Vector3 spawnPosition = new Vector3(lanePositions[chosenLane], 0.1f, playerTransform.position.z + 100);
            if (Random.value < 0.5f)
            {
                // ǥ���� ����
                Instantiate(signPrefab, spawnPosition, Quaternion.identity);
            }
            else
            {
                // Ʈ�� ����
                GameObject truck = Instantiate(truckPrefab, spawnPosition, Quaternion.Euler(0, 180, 0)); // Ʈ���� 180�� ȸ���Ͽ� ����
                truck.GetComponent<Truck>().speed = truckSpeed;
            }
        }

        // ���� ���� ���� ������Ʈ (��ֹ� ���� �� ������Ʈ)
        StartCoroutine(UpdateOccupiedLanes());
    }

    IEnumerator UpdateOccupiedLanes()
    {
        yield return new WaitForSeconds(spawnInterval * 2); // ���� �ð� �� ������Ʈ
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
