using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class ScoreManager : MonoBehaviour
{
    [SerializeField]    private int score = 0;
    public TextMeshProUGUI scoreText;
    void Start()
    {
        UpdateScoreText();
    }

    public void GetScore(int point)
    {
        score += point;
        UpdateScoreText();
    }
    void UpdateScoreText()
    {
        scoreText.text = score.ToString();
    }
}
