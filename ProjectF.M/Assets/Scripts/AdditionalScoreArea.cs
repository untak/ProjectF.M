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
            // �÷��̾ ������ ������ �� Ÿ�̸� ����
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
            // �÷��̾ ������ ����� �� Ÿ�̸� ����
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
        while (timer < 0.2f) // 0.2�� ���
        {
            timer += Time.deltaTime;
            yield return null;
        }
        onArea = true;
        areaCoroutine = null;
    }
}
