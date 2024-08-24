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

    public AudioClip boosterPickupSound; // �ν��� ȹ�� �Ҹ�
    public AudioClip shieldPickupSound; // �ǵ� ȹ�� �Ҹ�
    public AudioClip boosterActiveSound; // �ν��� Ȱ��ȭ ����
    public AudioClip shieldActiveSound; // �ǵ� Ȱ��ȭ ����
    public AudioClip obstacleHitSound; // ��ֹ� �浹 ����

    private AudioSource audioSource;

    void Start()
    {
        playerController = GetComponent<PlayerController>();
        gameOverManager = FindObjectOfType<GameOverManager>();
        scoreManager = FindObjectOfType<ScoreManager>();
        audioSource = GetComponent<AudioSource>();
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
                if (!collision.gameObject.name.Contains("Guardrail"))
                {
                    Destroy(collision.gameObject);
                }
                else
                {
                    audioSource.PlayOneShot(obstacleHitSound); // ��ֹ� �浹 �Ҹ� ���
                    gameOverManager.GameOver();
                }
                
            }
            else if (shieldOn)
            {
                if (!collision.gameObject.name.Contains("Guardrail"))
                {
                    scoreManager.GetScore(100);
                    HandleShieldCollisionWithObstacle(collision.gameObject);
                    StopCoroutine(DeactivateItemAfterTime(shieldItem, shieldDuration));
                    shieldItem.SetActive(false);
                    shieldOn = false;
                    audioSource.Stop();
                }
                else
                {
                    audioSource.PlayOneShot(obstacleHitSound); // ��ֹ� �浹 �Ҹ� ���
                    gameOverManager.GameOver();
                }
                
            }
            else
            {
                audioSource.PlayOneShot(obstacleHitSound); // ��ֹ� �浹 �Ҹ� ���
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
        else if (other.CompareTag("Line"))
        {
            gameOverManager.GameOver();
        }
    }

    void HandleBoosterCollision(GameObject booster)
    {
        audioSource.PlayOneShot(boosterPickupSound); // �ν��� ȹ�� �Ҹ� ���
        boosterOn = true;
        boosterItem.SetActive(true);
        playerController.ActivateBooster();
        Destroy(booster);

        // �ν��� ���� ���
        audioSource.clip = boosterActiveSound;
        audioSource.loop = true;
        audioSource.Play();

        StartCoroutine(DeactivateItemAfterTime(boosterItem, boosterDuration));
    }

    void HandleShieldCollision(GameObject shield)
    {
        audioSource.PlayOneShot(shieldPickupSound); // �ǵ� ȹ�� �Ҹ� ���
        shieldOn = true;
        shieldItem.SetActive(true);
        Destroy(shield);

        // �ǵ� ���� ���
        audioSource.clip = shieldActiveSound;
        audioSource.loop = true;
        audioSource.Play();

        StartCoroutine(DeactivateItemAfterTime(shieldItem, shieldDuration));
    }

    void HandleShieldCollisionWithObstacle(GameObject obstacle)
    {
        Rigidbody obstacleRb = obstacle.GetComponent<Rigidbody>();
        if (obstacleRb != null)
        {
            BoxCollider obstacleBc = obstacle.GetComponent<BoxCollider>();
            obstacleBc.enabled = false;
            Vector3 direction = (obstacle.transform.position - transform.position).normalized;
            float force = 500f;
            obstacleRb.AddForce(direction * force, ForceMode.Impulse);
        }

        StartCoroutine(RemoveObstacleAfterTime(obstacle, obstacleRemoveDelay));
    }

    IEnumerator RemoveObstacleAfterTime(GameObject obstacle, float delay)
    {
        yield return new WaitForSeconds(delay);
        Destroy(obstacle);
    }

    IEnumerator DeactivateItemAfterTime(GameObject item, float delay)
    {
        yield return new WaitForSeconds(delay);
        if (item.activeSelf)
        {
            item.SetActive(false);
            if (item == shieldItem)
            {
                shieldOn = false;
            }
            else
            {
                boosterOn = false;
            }
            audioSource.Stop(); // ������ ��Ȱ��ȭ �� �Ҹ� ����
        }
    }
}
