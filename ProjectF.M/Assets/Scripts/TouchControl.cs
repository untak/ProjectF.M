using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class TouchControl : MonoBehaviour, IPointerDownHandler
{
    public GameController gameController; // ���� ��Ʈ�ѷ� ��ũ��Ʈ ����
    public void OnPointerDown(PointerEventData data)
    {
        StartGame();
    }

    private void StartGame()
    {
        gameController.StartGame(); // GameController�� StartGame �޼��� ȣ��
    }
}
