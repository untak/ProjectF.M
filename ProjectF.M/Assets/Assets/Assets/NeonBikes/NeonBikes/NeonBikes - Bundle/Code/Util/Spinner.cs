using UnityEngine;

namespace NeonBikeBundle
{
    public class Spinner : MonoBehaviour
    {
        [SerializeField]
        private float _spinSpeed = 10;

        void Update()
        {
            this.transform.Rotate( Vector3.up, _spinSpeed * Time.deltaTime );

            Debug.Log(Time.deltaTime / 10);
        }

        
    }
}
