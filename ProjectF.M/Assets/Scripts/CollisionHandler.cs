using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionHandler : MonoBehaviour
{
    public float boosterSpeedMultiplier = 2f; // �ν��� ȿ���� ������ �ӵ� ����
    public float boosterDuration = 5f; // �ν��� ���� �ð�
    private bool isShieldActive = false; // �ǵ尡 Ȱ��ȭ�Ǿ����� ����

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Obstacle"))
        {
            HandleObstacleCollision(collision.gameObject);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Booster"))
        {
            HandleBoosterCollision(other.gameObject);
        }
        else if (other.CompareTag("Shield"))
        {
            HandleShieldCollision(other.gameObject);
        }
    }

    void HandleObstacleCollision(GameObject obstacle)
    {
        if (isShieldActive)
        {
            Debug.Log("Player hit an obstacle, but shield is active: " + obstacle.name);
            return; // �ǵ尡 Ȱ��ȭ�� ���, �浹 ��ȿȭ
        }

        Debug.Log("Player hit an obstacle: " + obstacle.name);
        // ��: �÷��̾��� ü���� ���ҽ�Ű�ų�, ���� ���� ó�� ��
    }

    void HandleBoosterCollision(GameObject booster)
    {
        Debug.Log("Player collected a booster: " + booster.name);
        StartCoroutine(ActivateBooster());
        Destroy(booster);
    }

    void HandleShieldCollision(GameObject shield)
    {
        Debug.Log("Player collected a shield: " + shield.name);
        ActivateShield();
        Destroy(shield);
    }

    IEnumerator ActivateBooster()
    {
        // �÷��̾��� ���� �ӵ� ���
        float originalSpeed = /* �÷��̾��� ���� �ӵ� */40f;

        // �÷��̾� �ӵ� ���� ó��
        yield return new WaitForSeconds(boosterDuration);

        // �ν��� ȿ�� ���� �� �ӵ� ���� ó��
    }

    void ActivateShield()
    {
        isShieldActive = true;
        // �ǵ� ȿ�� Ȱ��ȭ ó��

        // ���� �ð� �� �ǵ� ��Ȱ��ȭ
        Invoke("DeactivateShield", 5f); // �ǵ�� 5�� ����
    }

    void DeactivateShield()
    {
        isShieldActive = false;
        // �ǵ� ��Ȱ��ȭ ó��
    }
}
