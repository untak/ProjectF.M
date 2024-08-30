using UnityEngine;

public class GamePauseController : MonoBehaviour
{
    public GameObject settingsUI; // ���� UI�� ����
    public GameObject settingsButton; // ���� ��ư�� ����

    private bool isGamePaused = false;

    // ���� UI�� ���� �޼���
    public void OpenSettings()
    {
        // Ȩ UI �Ǵ� HUD UI�� ������� ���� UI�� Ȱ��ȭ
        settingsUI.SetActive(true);

        Time.timeScale = 0f;
        isGamePaused = true;
    }

    // ���� UI�� �ݴ� �޼���
    public void CloseSettings()
    {
        // ���� UI�� ��Ȱ��ȭ
        settingsUI.SetActive(false);

        // ������ �簳
        if (isGamePaused)
        {
            Time.timeScale = 1f;
            isGamePaused = false;
        }
    }
}
