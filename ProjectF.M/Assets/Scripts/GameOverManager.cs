using UnityEngine;
using TMPro;

public class GameOverManager : MonoBehaviour
{
    public GameObject gameOverUI;               // ���� ���� UI ������Ʈ
    public GameObject HUD;
    public TextMeshProUGUI currentScoreText;    // ���� ������ ǥ���� TextMeshPro ������Ʈ
    public TextMeshProUGUI highScoreText;       // �ְ� ������ ǥ���� TextMeshPro ������Ʈ
    private ScoreManager scoreManager;

    void Start()
    {
        gameOverUI.SetActive(false); // ó������ ���� ���� UI�� ��Ȱ��ȭ
        scoreManager = FindObjectOfType<ScoreManager>(); // ScoreManager ��������
    }

    public void GameOver()
    {
        Time.timeScale = 0f;

        int currentScore = scoreManager.GetCurrentScore();
        int highScore = scoreManager.GetHighScore();

        gameOverUI.SetActive(true); // ���� ���� UI Ȱ��ȭ
        HUD.SetActive(false);
        currentScoreText.text = currentScore.ToString();
        highScoreText.text = highScore.ToString();
    }

}