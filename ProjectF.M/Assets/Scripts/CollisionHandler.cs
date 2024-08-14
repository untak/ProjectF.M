using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionHandler : MonoBehaviour
{
    private PlayerController playerController;
    private GameOverManager gameOverManager;
    private ScoreManager scoreManager;

    public GameObject boosterItem; // �ν��� ������
    public GameObject shieldItem;  // �ǵ� ������

    public float boosterDuration = 5f; // �ν��� ���� �ð�
    public float shieldDuration = 30f; // �ǵ� ���� �ð�
    public float obstacleRemoveDelay = 2f; // ��ֹ��� ������ ���� �ð�

    private bool boosterOn = false;
    private bool shieldOn = false;

    void Start()
    {
        playerController = GetComponent<PlayerController>();
        gameOverManager = FindObjectOfType<GameOverManager>();
        scoreManager = FindObjectOfType<ScoreManager>();
        // ó������ ��Ȱ��ȭ ���·� ����
        boosterItem.SetActive(false);
        shieldItem.SetActive(false);
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Obstacle"))
        {
            if (boosterOn)
            {
                scoreManager.GetScore(100);
                Destroy(collision.gameObject); // �ν��� Ȱ��ȭ �� ��ֹ� ��� ����
            }
            else if (shieldOn)
            {
                scoreManager.GetScore(100);
                HandleShieldCollisionWithObstacle(collision.gameObject); // ��ֹ� ����������
                // �ǵ尡 �浹�� �� ��� ��Ȱ��ȭ
                StopCoroutine(DeactivateItemAfterTime(shieldItem, shieldDuration));
                shieldItem.SetActive(false);
                shieldOn = false; // �ǵ� ��Ȱ��ȭ ���� ������Ʈ
            }
            else
            {
                // ��ֹ��� �浹 �� ���� ����
                gameOverManager.GameOver();
            }
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

    void HandleBoosterCollision(GameObject booster)
    {
        boosterOn = true;
        boosterItem.SetActive(true); // �ν��� ������ Ȱ��ȭ
        playerController.ActivateBooster(); // �÷��̾�� �ν��� ȿ�� ����
        Destroy(booster); // �浹�� �ν��� ������ ����

        StartCoroutine(DeactivateItemAfterTime(boosterItem, boosterDuration)); // 5�� �� �ν��� ��Ȱ��ȭ
    }

    void HandleShieldCollision(GameObject shield)
    {
        shieldOn = true;
        shieldItem.SetActive(true); // �ǵ� ������ Ȱ��ȭ
        Destroy(shield); // �浹�� �ǵ� ������ ����

        StartCoroutine(DeactivateItemAfterTime(shieldItem, shieldDuration)); // 30�� �� �ǵ� ��Ȱ��ȭ
    }

    void HandleShieldCollisionWithObstacle(GameObject obstacle)
    {
        // ��ֹ��� ���������� ���� ���� ����
        Rigidbody obstacleRb = obstacle.GetComponent<Rigidbody>();
        if (obstacleRb != null)
        {
            Vector3 direction = (obstacle.transform.position - transform.position).normalized;
            float force = 500f; // ������ ���� ũ��
            obstacleRb.AddForce(direction * force, ForceMode.Impulse);
        }

        // ���� �ð� �� ��ֹ� ����
        StartCoroutine(RemoveObstacleAfterTime(obstacle, obstacleRemoveDelay));
    }

    IEnumerator RemoveObstacleAfterTime(GameObject obstacle, float delay)
    {
        yield return new WaitForSeconds(delay);
        Destroy(obstacle); // ���� �ð� �� ��ֹ� ����
    }

    IEnumerator DeactivateItemAfterTime(GameObject item, float delay)
    {
        yield return new WaitForSeconds(delay);
        if (item.activeSelf) // �������� ���� Ȱ�� ������ ��쿡�� ��Ȱ��ȭ
        {
            item.SetActive(false); // ������ �ð��� ���� �� ������ ��Ȱ��ȭ
            if (item == shieldItem)
            {
                shieldOn = false; // �ǵ� ��Ȱ��ȭ ���� ������Ʈ
            }
            else
            {
                boosterOn = false;
            }
        }
    }
}
