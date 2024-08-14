using UnityEngine;
using UnityEngine.SceneManagement; // 씬 관리를 위한 네임스페이스

public class SceneManager : MonoBehaviour
{
    // 게임 재시작 메서드
    public void RestartGame()
    {
        Time.timeScale = 1f; // 게임 시간 재개
        UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().name); // 현재 씬 재로딩
    }

    // 게임 종료 메서드
    public void QuitGame()
    {
        Time.timeScale = 1f; // 게임 시간 재개
#if UNITY_EDITOR
        UnityEditor.EditorApplication.isPlaying = false; // 에디터에서 실행 중지
#else
        Application.Quit(); // 빌드된 애플리케이션 종료
#endif
    }
}