using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionHandler : MonoBehaviour
{
    private PlayerController playerController;

    public GameObject boosterItem; // 부스터 아이템
    public GameObject shieldItem;  // 실드 아이템

    public float boosterDuration = 5f; // 부스터 지속 시간
    public float shieldDuration = 30f; // 실드 지속 시간

    void Start()
    {
        playerController = GetComponent<PlayerController>();

        // 처음에는 비활성화 상태로 설정
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
        boosterItem.SetActive(true); // 부스터 아이템 활성화
        playerController.ActivateBooster(); // 플레이어에게 부스터 효과 적용
        Destroy(booster); // 충돌한 부스터 아이템 제거

        StartCoroutine(DeactivateItemAfterTime(boosterItem, boosterDuration)); // 5초 후 부스터 비활성화
    }

    void HandleShieldCollision(GameObject shield)
    {
        shieldItem.SetActive(true); // 실드 아이템 활성화
        // 실드 관련 로직 추가 (예: 플레이어가 일정 시간 동안 무적이 되는 등)
        Destroy(shield); // 충돌한 실드 아이템 제거

        StartCoroutine(DeactivateItemAfterTime(shieldItem, shieldDuration)); // 30초 후 실드 비활성화
    }

    IEnumerator DeactivateItemAfterTime(GameObject item, float delay)
    {
        yield return new WaitForSeconds(delay);
        item.SetActive(false); // 지정된 시간이 지난 후 아이템 비활성화
    }
}
