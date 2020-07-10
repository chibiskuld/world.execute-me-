
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class WorldExecute : UdonSharpBehaviour
{
    public Material material;
    public AudioSource audio;

    bool enabled = false;

    void Start()
    {
        
    }

    public override void Interact()
    {
        if (enabled)
        {
            material.SetFloat("_StartTime", 0);
            material.SetInt("_Play", 0);
            audio.time = 0;
            audio.Stop();
            enabled = false;
        }
        else
        {
            material.SetFloat("_StartTime", UnityEngine.Time.timeSinceLevelLoad);
            material.SetInt("_Play", 1);
            audio.time = 0;
            audio.Play();
            enabled = true;
        }
    }
}
