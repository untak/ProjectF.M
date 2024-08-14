using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class ScoreManager : MonoBehaviour
{
    [SerializeField] private int score = 0;
    public TextMeshProUGUI scoreText;
    //public TextMeshProUGUI highScoreText;

    private int highScore;

    void Start()
    {
        // �ְ� ������ PlayerPrefs���� �ҷ��ɴϴ�.
        highScore = PlayerPrefs.GetInt("HighScore", 0);
        UpdateScoreText();
        //UpdateHighScoreText();
    }

    public void GetScore(int point)
    {
        score += point;
        UpdateScoreText();

        // ���� ������ �ְ� �������� ũ�� �ְ� ������ �����մϴ�.
        if (score > highScore)
        {
            highScore = score;
            PlayerPrefs.SetInt("HighScore", highScore);
            //UpdateHighScoreText();
        }
    }

    void UpdateScoreText()
    {
        scoreText.text = score.ToString();
    }
    public int GetCurrentScore()
    {
        return score;
    }

    public int GetHighScore()
    {
        return highScore;
    }

    //void UpdateHighScoreText()
    //{
    //    highScoreText.text = "High Score: " + highScore.ToString();
    //}

    // ���� ���� �� ���� ������ �ְ� ������ ����ϴ� �޼���
    //public void OnGameOver()
    //{
    //    Debug.Log("Game Over! Your Score: " + score + ", High Score: " + highScore);
    //    // ���� ���� ȭ�鿡�� ���� ��� �� �߰����� ������ ���⿡ �ۼ�
    //}
}
