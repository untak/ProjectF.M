using System.Collections;
using UnityEngine;

public class GameController : MonoBehaviour
{
    public GameObject homeUIPanel; // Ȩ UI �г�
    public PlayerController playerController; // �÷��̾� ��Ʈ�ѷ� ��ũ��Ʈ ����
    public GameObject spawnManager; // ���� �Ŵ��� ��ũ��Ʈ ����
    public GameObject cutscene; // ���� ī�޶� ����
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
        StartCoroutine(StartGameRoutine()); // �ڷ�ƾ ����
    }

    private IEnumerator StartGameRoutine()
    {
        homeUIPanel.SetActive(false); // Ȩ UI ��Ȱ��ȭ

        cutscene.SetActive(true); // �ƽ� Ȱ��ȭ
        yield return new WaitForSeconds(1.5f); // 1.5�� ���
        cutscene.SetActive(false);
        cameraFollow.enabled = true;
        playerController.enabled = true; // �÷��̾� ������ Ȱ��ȭ
        spawnManager.SetActive(true); // ���� �Ŵ��� Ȱ��ȭ
        score.SetActive(true); // ���� UI Ȱ��ȭ
    }
}