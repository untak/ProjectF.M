using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Motorcycle : MonoBehaviour
{
    public float speed = 40f;
    public float destroyDistance = 50f; // �÷��̾���� �Ÿ� �Ӱ谪
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
    }
    void Update()
    {
        // �÷��̾ ���� ����
        transform.Translate(Vector3.forward * speed * Time.deltaTime);

        if (playerTransform != null && transform.position.z < playerTransform.position.z - 2 && !isScored)
        {
            if (additionalScoreArea != null && additionalScoreArea.onArea)
            {
                // �߰� ���� ������ �÷��̾ ���� �� ���� �߰�
                scoreManager.GetScore(specialscore);
                additionalScoreArea.onArea = false;
            }
            else
            {
                scoreManager.GetScore(normalscore);
            }
            isScored = true;
        }
        // �÷��̾���� �Ÿ��� üũ�Ͽ� ���� �Ÿ� �̻� �ڿ� ���� �� ����
        if (playerTransform != null && transform.position.z < playerTransform.position.z - destroyDistance)
        {
            Destroy(gameObject);
        }
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Obstacle"))
        {
            Destroy(gameObject);
        }
    }
}
