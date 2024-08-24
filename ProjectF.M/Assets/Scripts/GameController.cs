using System.Collections;
using UnityEngine;

public class GameController : MonoBehaviour
{
    public GameObject homeUIPanel;
    public PlayerController playerController;
    public GameObject spawnManager;
    public GameObject cutscene;
    public GameObject score;
    public CameraFollow cameraFollow;

    public AudioClip[] homeBGMs; // 홈 화면에서 재생할 BGM들
    public AudioClip gameBGM; // 게임 내에서 재생할 BGM

    private AudioSource audioSource;

    void Start()
    {
        playerController.enabled = false;
        cameraFollow.enabled = false;
        spawnManager.SetActive(false);
        cutscene.SetActive(false);
        score.SetActive(false);
        audioSource = GetComponent<AudioSource>();
        StartCoroutine(PlayHomeBGMs());
    }

    IEnumerator PlayHomeBGMs()
    {
        while (true)
        {
            foreach (AudioClip bgm in homeBGMs)
            {
                audioSource.clip = bgm;
                audioSource.Play();
                yield return new WaitForSeconds(bgm.length);
            }
        }
    }

    public void StartGame()
    {
        StopCoroutine(PlayHomeBGMs());
        StartCoroutine(StartGameRoutine());
    }

    private IEnumerator StartGameRoutine()
    {
        homeUIPanel.SetActive(false);

        cutscene.SetActive(true);
        yield return new WaitForSeconds(1.5f);
        cutscene.SetActive(false);
        cameraFollow.enabled = true;
        playerController.enabled = true;
        spawnManager.SetActive(true);
        score.SetActive(true);

        // 게임 BGM 재생
        audioSource.clip = gameBGM;
        audioSource.loop = true;
        audioSource.Play();
    }
}
