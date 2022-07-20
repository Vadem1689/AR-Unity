using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Animation_Play : MonoBehaviour
{
    public Animator animator;
    public string animClip;
    void Start()
    {
        Start_Animation();
    }
    public void Start_Animation()
    {
        animator.Play("Jump and Sing");
        Debug.Log("ןדרמשכחהזץ‎");
    }
}
