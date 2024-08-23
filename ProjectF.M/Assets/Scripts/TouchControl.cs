using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class TouchControl : MonoBehaviour, IPointerDownHandler
{
    public GameController gameController; // 게임 컨트롤러 스크립트 참조
    public void OnPointerDown(PointerEventData data)
    {
        StartGame();
    }

    private void StartGame()
    {
        gameController.StartGame(); // GameController의 StartGame 메서드 호출
    }
}
