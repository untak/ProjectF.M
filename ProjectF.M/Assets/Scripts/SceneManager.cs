using UnityEngine;
using UnityEngine.SceneManagement; // �� ������ ���� ���ӽ����̽�

public class SceneManager : MonoBehaviour
{
    // ���� ����� �޼���
    public void RestartGame()
    {
        Time.timeScale = 1f; // ���� �ð� �簳
        UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().name); // ���� �� ��ε�
    }

    // ���� ���� �޼���
    public void QuitGame()
    {
        Time.timeScale = 1f; // ���� �ð� �簳
#if UNITY_EDITOR
        UnityEditor.EditorApplication.isPlaying = false; // �����Ϳ��� ���� ����
#else
        Application.Quit(); // ����� ���ø����̼� ����
#endif
    }
}