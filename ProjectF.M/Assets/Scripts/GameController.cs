using System.Collections;
using UnityEngine;

public class GameController : MonoBehaviour
{
    public GameObject homeUIPanel; // 홈 UI 패널
    public PlayerController playerController; // 플레이어 컨트롤러 스크립트 참조
    public GameObject spawnManager; // 스폰 매니저 스크립트 참조
    public GameObject cutscene; // 메인 카메라 참조
    public GameObject score;
    public CameraFollow cameraFollow;
    void Start()
    {
        playerController.enabled = false;
        cameraFollow.enabled = false;
        spawnManager.SetActive(false);
        cutscene.SetActive(false);
        score.SetActive(false);
    }

    public void StartGame()
    {
        StartCoroutine(StartGameRoutine()); // 코루틴 실행
    }

    private IEnumerator StartGameRoutine()
    {
        homeUIPanel.SetActive(false); // 홈 UI 비활성화

        cutscene.SetActive(true); // 컷신 활성화
        yield return new WaitForSeconds(1.5f); // 1.5초 대기
        cutscene.SetActive(false);
        cameraFollow.enabled = true;
        playerController.enabled = true; // 플레이어 움직임 활성화
        spawnManager.SetActive(true); // 스폰 매니저 활성화
        score.SetActive(true); // 점수 UI 활성화
    }
}