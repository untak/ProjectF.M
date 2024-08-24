using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionHandler : MonoBehaviour
{
    private PlayerController playerController;
    private GameOverManager gameOverManager;
    private ScoreManager scoreManager;

    public GameObject boosterItem; // 부스터 아이템
    public GameObject shieldItem;  // 실드 아이템

    public float boosterDuration = 5f; // 부스터 지속 시간
    public float shieldDuration = 30f; // 실드 지속 시간
    public float obstacleRemoveDelay = 2f; // 장애물을 제거할 지연 시간

    private bool boosterOn = false;
    private bool shieldOn = false;

    public AudioClip boosterPickupSound; // 부스터 획득 소리
    public AudioClip shieldPickupSound; // 실드 획득 소리
    public AudioClip boosterActiveSound; // 부스터 활성화 사운드
    public AudioClip shieldActiveSound; // 실드 활성화 사운드
    public AudioClip obstacleHitSound; // 장애물 충돌 사운드

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
                    audioSource.PlayOneShot(obstacleHitSound); // 장애물 충돌 소리 재생
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
                    audioSource.PlayOneShot(obstacleHitSound); // 장애물 충돌 소리 재생
                    gameOverManager.GameOver();
                }
                
            }
            else
            {
                audioSource.PlayOneShot(obstacleHitSound); // 장애물 충돌 소리 재생
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
        audioSource.PlayOneShot(boosterPickupSound); // 부스터 획득 소리 재생
        boosterOn = true;
        boosterItem.SetActive(true);
        playerController.ActivateBooster();
        Destroy(booster);

        // 부스터 사운드 재생
        audioSource.clip = boosterActiveSound;
        audioSource.loop = true;
        audioSource.Play();

        StartCoroutine(DeactivateItemAfterTime(boosterItem, boosterDuration));
    }

    void HandleShieldCollision(GameObject shield)
    {
        audioSource.PlayOneShot(shieldPickupSound); // 실드 획득 소리 재생
        shieldOn = true;
        shieldItem.SetActive(true);
        Destroy(shield);

        // 실드 사운드 재생
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
            audioSource.Stop(); // 아이템 비활성화 시 소리 멈춤
        }
    }
}
