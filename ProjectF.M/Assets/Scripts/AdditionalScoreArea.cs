using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AdditionalScoreArea : MonoBehaviour
{
    public bool onArea = false;
    private Coroutine areaCoroutine;

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            // 플레이어가 영역에 들어왔을 때 타이머 시작
            if (areaCoroutine == null)
            {
                areaCoroutine = StartCoroutine(AreaTimer());
            }
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            // 플레이어가 영역을 벗어났을 때 타이머 중지
            if (areaCoroutine != null)
            {
                StopCoroutine(areaCoroutine);
                areaCoroutine = null;
                onArea = false;
            }
        }
    }

    private IEnumerator AreaTimer()
    {
        float timer = 0f;
        while (timer < 0.2f) // 0.2초 대기
        {
            timer += Time.deltaTime;
            yield return null;
        }
        onArea = true;
        areaCoroutine = null;
    }
}
