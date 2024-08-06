using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RoadManager : MonoBehaviour
{
    public Transform player;
    public GameObject[] roads;
    private float roadLength = 200f; // ���� ���̸� 200���� ����
    private float nextMoveThreshold;
    private int lastMovedRoadIndex = 0;

    void Start()
    {
        // ������ �ʱ� ��ġ ����
        for (int i = 0; i < roads.Length; i++)
        {
            roads[i].transform.position = new Vector3(0, 0, i * roadLength);
        }
        // ù ��° ���� �̵� ������ ����
        nextMoveThreshold = roadLength;  // ù ��° ������ ��
    }

    void Update()
    {
        if (player.position.z > nextMoveThreshold)
        {
            MoveRoad();
            nextMoveThreshold += roadLength;  // ���� ������ ������ ����
        }
    }

    void MoveRoad()
    {
        // ���θ� ������ ���鼭 ������ �̵�
        GameObject roadToMove = roads[lastMovedRoadIndex];
        // ���� ������ ������ �ڿ� ��ġ�ϵ��� ���ο� ��ġ ���
        float newZPosition = roads[(lastMovedRoadIndex + roads.Length - 1) % roads.Length].transform.position.z + roadLength;
        roadToMove.transform.position = new Vector3(0, 0, newZPosition);

        // �ε����� �������� ����
        lastMovedRoadIndex = (lastMovedRoadIndex + 1) % roads.Length;
    }
}
