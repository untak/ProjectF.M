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
        // 최고 점수를 PlayerPrefs에서 불러옵니다.
        highScore = PlayerPrefs.GetInt("HighScore", 0);
        UpdateScoreText();
        //UpdateHighScoreText();
    }

    public void GetScore(int point)
    {
        score += point;
        UpdateScoreText();

        // 현재 점수가 최고 점수보다 크면 최고 점수를 갱신합니다.
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

    // 게임 오버 시 현재 점수와 최고 점수를 출력하는 메서드
    //public void OnGameOver()
    //{
    //    Debug.Log("Game Over! Your Score: " + score + ", High Score: " + highScore);
    //    // 게임 오버 화면에서 점수 출력 등 추가적인 로직을 여기에 작성
    //}
}
