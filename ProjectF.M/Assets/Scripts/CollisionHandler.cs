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

    void Start()
    {
        playerController = GetComponent<PlayerController>();
        gameOverManager = FindObjectOfType<GameOverManager>();
        scoreManager = FindObjectOfType<ScoreManager>();
        // 처음에는 비활성화 상태로 설정
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
                Destroy(collision.gameObject); // 부스터 활성화 시 장애물 즉시 제거
            }
            else if (shieldOn)
            {
                scoreManager.GetScore(100);
                HandleShieldCollisionWithObstacle(collision.gameObject); // 장애물 날려버리기
                // 실드가 충돌한 후 즉시 비활성화
                StopCoroutine(DeactivateItemAfterTime(shieldItem, shieldDuration));
                shieldItem.SetActive(false);
                shieldOn = false; // 실드 비활성화 상태 업데이트
            }
            else
            {
                // 장애물과 충돌 시 게임 오버
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
        boosterItem.SetActive(true); // 부스터 아이템 활성화
        playerController.ActivateBooster(); // 플레이어에게 부스터 효과 적용
        Destroy(booster); // 충돌한 부스터 아이템 제거

        StartCoroutine(DeactivateItemAfterTime(boosterItem, boosterDuration)); // 5초 후 부스터 비활성화
    }

    void HandleShieldCollision(GameObject shield)
    {
        shieldOn = true;
        shieldItem.SetActive(true); // 실드 아이템 활성화
        Destroy(shield); // 충돌한 실드 아이템 제거

        StartCoroutine(DeactivateItemAfterTime(shieldItem, shieldDuration)); // 30초 후 실드 비활성화
    }

    void HandleShieldCollisionWithObstacle(GameObject obstacle)
    {
        // 장애물을 날려버리기 위한 힘을 적용
        Rigidbody obstacleRb = obstacle.GetComponent<Rigidbody>();
        if (obstacleRb != null)
        {
            Vector3 direction = (obstacle.transform.position - transform.position).normalized;
            float force = 500f; // 날리는 힘의 크기
            obstacleRb.AddForce(direction * force, ForceMode.Impulse);
        }

        // 일정 시간 뒤 장애물 제거
        StartCoroutine(RemoveObstacleAfterTime(obstacle, obstacleRemoveDelay));
    }

    IEnumerator RemoveObstacleAfterTime(GameObject obstacle, float delay)
    {
        yield return new WaitForSeconds(delay);
        Destroy(obstacle); // 일정 시간 후 장애물 제거
    }

    IEnumerator DeactivateItemAfterTime(GameObject item, float delay)
    {
        yield return new WaitForSeconds(delay);
        if (item.activeSelf) // 아이템이 아직 활성 상태인 경우에만 비활성화
        {
            item.SetActive(false); // 지정된 시간이 지난 후 아이템 비활성화
            if (item == shieldItem)
            {
                shieldOn = false; // 실드 비활성화 상태 업데이트
            }
            else
            {
                boosterOn = false;
            }
        }
    }
}
