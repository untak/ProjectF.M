using UnityEngine;

public class GamePauseController : MonoBehaviour
{
    public GameObject settingsUI; // 설정 UI를 참조
    public GameObject settingsButton; // 설정 버튼을 참조

    private bool isGamePaused = false;

    // 설정 UI를 여는 메서드
    public void OpenSettings()
    {
        // 홈 UI 또는 HUD UI에 상관없이 설정 UI를 활성화
        settingsUI.SetActive(true);

        Time.timeScale = 0f;
        isGamePaused = true;
    }

    // 설정 UI를 닫는 메서드
    public void CloseSettings()
    {
        // 설정 UI를 비활성화
        settingsUI.SetActive(false);

        // 게임을 재개
        if (isGamePaused)
        {
            Time.timeScale = 1f;
            isGamePaused = false;
        }
    }
}
