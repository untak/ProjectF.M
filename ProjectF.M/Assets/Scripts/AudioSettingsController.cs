using UnityEngine;
using UnityEngine.UI;

public class AudioSettingsController : MonoBehaviour
{
    public AudioSource bgmAudioSource;  // BGM�� ����� AudioSource
    public AudioSource sfxAudioSource;  // ȿ�� �Ҹ��� ����� AudioSource
    public Slider bgmSlider;            // BGM �����̴�
    public Slider sfxSlider;            // ȿ�� �Ҹ� �����̴�

    void Start()
    {
        // �����̴��� �ʱ� ���� AudioSource�� ���� ������ �°� ����
        bgmSlider.value = bgmAudioSource.volume;
        sfxSlider.value = sfxAudioSource.volume;

        // �����̴� �� ���� �̺�Ʈ ���
        bgmSlider.onValueChanged.AddListener(OnBGMVolumeChanged);
        sfxSlider.onValueChanged.AddListener(OnSFXVolumeChanged);
    }

    // BGM �����̴� ���� ����� �� ȣ��Ǵ� �޼���
    private void OnBGMVolumeChanged(float value)
    {
        if (bgmAudioSource != null)
        {
            bgmAudioSource.volume = value;
        }
    }

    // ȿ�� �Ҹ� �����̴� ���� ����� �� ȣ��Ǵ� �޼���
    private void OnSFXVolumeChanged(float value)
    {
        if (sfxAudioSource != null)
        {
            sfxAudioSource.volume = value;
        }
    }
}
