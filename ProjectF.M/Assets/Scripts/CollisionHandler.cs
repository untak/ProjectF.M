using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionHandler : MonoBehaviour
{
    public float boosterSpeedMultiplier = 2f; // 부스터 효과로 증가할 속도 배율
    public float boosterDuration = 5f; // 부스터 지속 시간
    private bool isShieldActive = false; // 실드가 활성화되었는지 여부

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
            return; // 실드가 활성화된 경우, 충돌 무효화
        }

        Debug.Log("Player hit an obstacle: " + obstacle.name);
        // 예: 플레이어의 체력을 감소시키거나, 게임 오버 처리 등
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
        // 플레이어의 원래 속도 백업
        float originalSpeed = /* 플레이어의 원래 속도 */40f;

        // 플레이어 속도 증가 처리
        yield return new WaitForSeconds(boosterDuration);

        // 부스터 효과 종료 후 속도 원복 처리
    }

    void ActivateShield()
    {
        isShieldActive = true;
        // 실드 효과 활성화 처리

        // 일정 시간 후 실드 비활성화
        Invoke("DeactivateShield", 5f); // 실드는 5초 지속
    }

    void DeactivateShield()
    {
        isShieldActive = false;
        // 실드 비활성화 처리
    }
}
