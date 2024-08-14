using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionHandler : MonoBehaviour
{
    private PlayerController playerController;

    public GameObject boosterItem; // �ν��� ������
    public GameObject shieldItem;  // �ǵ� ������

    public float boosterDuration = 5f; // �ν��� ���� �ð�
    public float shieldDuration = 30f; // �ǵ� ���� �ð�

    void Start()
    {
        playerController = GetComponent<PlayerController>();

        // ó������ ��Ȱ��ȭ ���·� ����
        boosterItem.SetActive(false);
        shieldItem.SetActive(false);
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

    void HandleBoosterCollision(GameObject booster)
    {
        boosterItem.SetActive(true); // �ν��� ������ Ȱ��ȭ
        playerController.ActivateBooster(); // �÷��̾�� �ν��� ȿ�� ����
        Destroy(booster); // �浹�� �ν��� ������ ����

        StartCoroutine(DeactivateItemAfterTime(boosterItem, boosterDuration)); // 5�� �� �ν��� ��Ȱ��ȭ
    }

    void HandleShieldCollision(GameObject shield)
    {
        shieldItem.SetActive(true); // �ǵ� ������ Ȱ��ȭ
        // �ǵ� ���� ���� �߰� (��: �÷��̾ ���� �ð� ���� ������ �Ǵ� ��)
        Destroy(shield); // �浹�� �ǵ� ������ ����

        StartCoroutine(DeactivateItemAfterTime(shieldItem, shieldDuration)); // 30�� �� �ǵ� ��Ȱ��ȭ
    }

    IEnumerator DeactivateItemAfterTime(GameObject item, float delay)
    {
        yield return new WaitForSeconds(delay);
        item.SetActive(false); // ������ �ð��� ���� �� ������ ��Ȱ��ȭ
    }
}
