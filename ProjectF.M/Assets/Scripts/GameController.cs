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

    public AudioClip[] homeBGMs; // 홈 화면에서 재생할 BGM들
    public AudioClip[] gameBGMs; // 게임 내에서 재생할 BGM들

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
        
        // 홈 BGM 하나만 재생
        PlaySingleHomeBGM();
        StartCoroutine(InitializeUI());
    }
    private IEnumerator InitializeUI()
    {
        yield return null; // 한 프레임 대기하여 ScoreManager의 Start()가 실행될 시간을 줌

        // highScore를 가져온 후 UI에 업데이트
        DrowMainUI();
    }
    private void DrowMainUI()
    {
        int highScore = scoreManager.GetHighScore();
        highScoreText.text = highScore.ToString();
    }

    private void PlaySingleHomeBGM()
    {
        // 홈 BGM 중 첫 번째만 재생
        audioSource.clip = homeBGMs[0];
        audioSource.loop = true;
        audioSource.Play();
    }

    public void StartGame()
    {
        // 홈 BGM 재생 중지
        audioSource.Stop();

        // 게임 시작 루틴 시작
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

        // 게임 BGM 순차적으로 재생
        StartCoroutine(PlayGameBGMs());
    }

    private IEnumerator PlayGameBGMs()
    {
        int currentBGMIndex = 0;

        while (true)
        {
            // 현재 인덱스의 BGM 재생
            audioSource.clip = gameBGMs[currentBGMIndex];
            audioSource.Play();

            // 3분 30초 대기
            yield return new WaitForSeconds(210f); // 210초 = 3분 30초

            // 다음 BGM으로 인덱스 업데이트
            currentBGMIndex = (currentBGMIndex + 1) % gameBGMs.Length;
        }
    }
}
