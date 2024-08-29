using UnityEngine;
using UnityEngine.UI;

public class AudioSettingsController : MonoBehaviour
{
    public AudioSource bgmAudioSource;  // BGM을 재생할 AudioSource
    public AudioSource sfxAudioSource;  // 효과 소리를 재생할 AudioSource
    public Slider bgmSlider;            // BGM 슬라이더
    public Slider sfxSlider;            // 효과 소리 슬라이더

    void Start()
    {
        // 슬라이더의 초기 값을 AudioSource의 현재 볼륨에 맞게 설정
        bgmSlider.value = bgmAudioSource.volume;
        sfxSlider.value = sfxAudioSource.volume;

        // 슬라이더 값 변경 이벤트 등록
        bgmSlider.onValueChanged.AddListener(OnBGMVolumeChanged);
        sfxSlider.onValueChanged.AddListener(OnSFXVolumeChanged);
    }

    // BGM 슬라이더 값이 변경될 때 호출되는 메서드
    private void OnBGMVolumeChanged(float value)
    {
        if (bgmAudioSource != null)
        {
            bgmAudioSource.volume = value;
        }
    }

    // 효과 소리 슬라이더 값이 변경될 때 호출되는 메서드
    private void OnSFXVolumeChanged(float value)
    {
        if (sfxAudioSource != null)
        {
            sfxAudioSource.volume = value;
        }
    }
}
