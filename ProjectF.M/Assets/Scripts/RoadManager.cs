using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RoadManager : MonoBehaviour
{
    public Transform player;
    public GameObject[] roadPrefabs; // 3���� �Ϲ� ���� ������ �迭
    public GameObject finishLinePrefab; // ��¼� ���� ������
    private float roadLength = 200f; // ���� ����
    private float spawnZPosition = 0f; // ���� ���� ��ġ
    private int roadCountOnScreen = 6; // ȭ�鿡 ������ ���� ����
    private List<GameObject> activeRoads = new List<GameObject>(); // ���� Ȱ��ȭ�� ���ε�
    private int currentRoadIndex = 0; // ���� ��� ���� ���� �ε���
    private float roadChangeInterval = 210f; // 3�� 30��(210��)���� ���� ����
    private float finishLineTime = 600f; // 10�� �Ŀ� ��¼� ����
    private bool finishLineSpawned = false; // ��¼��� �����Ǿ����� ����

    void Start()
    {
        // �ڷ�ƾ ����: 3�� 30�ʸ��� ���� Ÿ�� ����
        StartCoroutine(ChangeRoadType());

        // ù ȭ�鿡 ���� ���ε��� ����
        for (int i = 0; i < roadCountOnScreen; i++)
        {
            SpawnRoad();
        }
    }

    void Update()
    {
        // �÷��̾ ���� �Ÿ� �̻� �̵����� �� ���ο� ���θ� ����
        if (player.position.z - roadLength > spawnZPosition - (roadCountOnScreen * roadLength))
        {
            SpawnRoad();
            RemoveOldRoad();
        }
    }

    void SpawnRoad()
    {
        GameObject newRoad;

        // 10���� ����ϰ� ��¼��� ���� �������� �ʾ��� �� ��¼� ���θ� ����
        if (Time.time >= finishLineTime && !finishLineSpawned)
        {
            newRoad = Instantiate(finishLinePrefab, new Vector3(0, 0, spawnZPosition), Quaternion.identity);
            finishLineSpawned = true;
        }
        else
        {
            // ���� ���� �ε����� �´� ���θ� ����
            newRoad = Instantiate(roadPrefabs[currentRoadIndex], new Vector3(0, 0, spawnZPosition), Quaternion.identity);
        }

        activeRoads.Add(newRoad);
        spawnZPosition += roadLength; // ���� ���� ���� ��ġ ����
    }

    void RemoveOldRoad()
    {
        // ȭ�鿡�� ��� ���� ������ ���θ� ����
        Destroy(activeRoads[0]);
        activeRoads.RemoveAt(0);
    }

    IEnumerator ChangeRoadType()
    {
        while (!finishLineSpawned) // ��¼��� ������ ������ ���� Ÿ���� ����
        {
            yield return new WaitForSeconds(roadChangeInterval); // 3�� 30�� ���
            currentRoadIndex = (currentRoadIndex + 1) % roadPrefabs.Length; // ���� Ÿ�� ��ȯ
        }
    }
}
