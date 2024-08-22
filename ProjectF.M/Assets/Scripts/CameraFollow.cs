using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour
{
    public Transform player;       // �÷��̾� ������ Transform
    public Vector3 offset;         // ī�޶�� �÷��̾� ���� ���� ������

    // ���ͺ�� ž���� �߰� ������ ������ �����մϴ�.
    public float distance = 10f;   // �������� �Ÿ�
    public float height = 5f;      // ���� ������ ����
    public float angle = 30f;      // ī�޶� ����

    private bool gameStarted = false;

    void Start()
    {
        // ī�޶��� �ʱ� ��ġ�� �����մϴ�.
        offset = new Vector3(0, height, -distance);
        offset = Quaternion.AngleAxis(angle, Vector3.right) * offset;
    }

    void LateUpdate()
    {
        if(gameStarted == true)
        {
            // ī�޶��� ��ġ�� �÷��̾� ������ ��ġ�� �������� ������� �����մϴ�.
            transform.position = player.position + offset;
        }

    }
    public void GameStart()
    {
        gameStarted = true;
    }
}
