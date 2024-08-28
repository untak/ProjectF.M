using System.Collections;
using UnityEngine;
using TMPro;


public class GameController : MonoBehaviour
{
    public GameObject homeUIPanel;
    public PlayerController playerController;
    public GameObject spawnManager;
    public GameObject roadManager;
    public GameObject cutscene;
    public GameObject score;
    public GameObject HUD;
    public CameraFollow cameraFollow;
    public TextMeshProUGUI highScoreText;

    public AudioClip[] homeBGMs; // Ȩ ȭ�鿡�� ����� BGM��
    public AudioClip[] gameBGMs; // ���� ������ ����� BGM��

    private AudioSource audioSource;
    private ScoreManager scoreManager;

    void Start()
    {
        scoreManager = FindObjectOfType<ScoreManager>();
        playerController.enabled = false;
        cameraFollow.enabled = false;
        roadManager.SetActive(false);
        spawnManager.SetActive(false);
        cutscene.SetActive(false);
        score.SetActive(false);
        audioSource = GetComponent<AudioSource>();
        
        // Ȩ BGM �ϳ��� ���
        PlaySingleHomeBGM();
        StartCoroutine(InitializeUI());
    }
    private IEnumerator InitializeUI()
    {
        yield return null; // �� ������ ����Ͽ� ScoreManager�� Start()�� ����� �ð��� ��

        // highScore�� ������ �� UI�� ������Ʈ
        DrowMainUI();
    }
    private void DrowMainUI()
    {
        int highScore = scoreManager.GetHighScore();
        highScoreText.text = highScore.ToString();
    }

    private void PlaySingleHomeBGM()
    {
        // Ȩ BGM �� ù ��°�� ���
        audioSource.clip = homeBGMs[0];
        audioSource.loop = true;
        audioSource.Play();
    }

    public void StartGame()
    {
        // Ȩ BGM ��� ����
        audioSource.Stop();

        // ���� ���� ��ƾ ����
        StartCoroutine(StartGameRoutine());
    }

    private IEnumerator StartGameRoutine()
    {
        homeUIPanel.SetActive(false);
        HUD.SetActive(true);

        cutscene.SetActive(true);
        yield return new WaitForSeconds(1.5f);
        cutscene.SetActive(false);
        cameraFollow.enabled = true;
        playerController.enabled = true;
        spawnManager.SetActive(true);
        roadManager.SetActive(true);
        score.SetActive(true);

        // ���� BGM ���������� ���
        StartCoroutine(PlayGameBGMs());
    }

    private IEnumerator PlayGameBGMs()
    {
        int currentBGMIndex = 0;

        while (true)
        {
            // ���� �ε����� BGM ���
            audioSource.clip = gameBGMs[currentBGMIndex];
            audioSource.Play();

            // 3�� 30�� ���
            yield return new WaitForSeconds(210f); // 210�� = 3�� 30��

            // ���� BGM���� �ε��� ������Ʈ
            currentBGMIndex = (currentBGMIndex + 1) % gameBGMs.Length;
        }
    }
}
