using UnityEngine;


public class Change_sound : MonoBehaviour
{
    public AudioSource myAudio_1;
    public AudioSource myAudio_2;
    
   

    void Start()
    {
        StartSound();
    }
   public void StartSound()
    {
        myAudio_1.Play();
        Invoke("audioFinished", myAudio_1.clip.length);
    }
    public void audioFinished()
    {
        myAudio_2.Play();
     
     
    }



}
