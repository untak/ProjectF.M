using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StopSign : MonoBehaviour
{
    public float destroyDistance = 50f; // 플레이어와의 거리 임계값
    private AdditionalScoreArea additionalScoreArea;
    private Transform playerTransform;
    private ScoreManager scoreManager;

    private int normalscore = 50;
    private int specialscore = 100;
    private bool isScored = false;
    void Start()
    {
        playerTransform = GameObject.FindGameObjectWithTag("Player").transform;
        scoreManager = GameObject.FindGameObjectWithTag("GameManager").GetComponent<ScoreManager>();
        additionalScoreArea = GetComponentInChildren<AdditionalScoreArea>();
        transform.rotation = Quaternion.Euler(0, 180, 0);
    }

    void Update()
    {
        if (playerTransform != null && transform.position.z < playerTransform.position.z - 2 && !isScored)
        {
            if (additionalScoreArea != null && additionalScoreArea.onArea)
            {
                // 추가 점수 영역에 플레이어가 있을 때 점수 추가
                scoreManager.GetScore(specialscore);
                additionalScoreArea.onArea = false;
            }
            else
            {
                scoreManager.GetScore(normalscore);
            }
            isScored = true;
        }
        // 플레이어와의 거리를 체크하여 일정 거리 이상 뒤에 있을 때 제거
        else if (playerTransform != null && transform.position.z < playerTransform.position.z - destroyDistance)
        {
            Destroy(gameObject);
        }
    }
}
