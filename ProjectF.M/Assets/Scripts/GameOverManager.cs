using UnityEngine;
using TMPro;

public class GameOverManager : MonoBehaviour
{
    public GameObject gameOverUI;               // 게임 오버 UI 오브젝트
    public GameObject HUD;
    public TextMeshProUGUI currentScoreText;    // 현재 점수를 표시할 TextMeshPro 오브젝트
    public TextMeshProUGUI highScoreText;       // 최고 점수를 표시할 TextMeshPro 오브젝트
    private ScoreManager scoreManager;

    void Start()
    {
        gameOverUI.SetActive(false); // 처음에는 게임 오버 UI를 비활성화
        scoreManager = FindObjectOfType<ScoreManager>(); // ScoreManager 가져오기
    }

    public void GameOver()
    {
        Time.timeScale = 0f;

        int currentScore = scoreManager.GetCurrentScore();
        int highScore = scoreManager.GetHighScore();

        gameOverUI.SetActive(true); // 게임 오버 UI 활성화
        HUD.SetActive(false);
        currentScoreText.text = currentScore.ToString();
        highScoreText.text = highScore.ToString();
    }

}