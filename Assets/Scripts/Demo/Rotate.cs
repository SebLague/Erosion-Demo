using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour {
    public float speed = 30;
    public float dragSpeed = 30;
    bool dragging;

    public void SetAngle (float v) {
        speed = v;
    }

    public void Click () {
        dragging = true;
    }

    void Update () {
        if (Input.GetMouseButtonUp (0)) {
            dragging = false;
        }

        if (dragging) {
            float x = Input.GetAxis ("Mouse X");
            transform.Rotate (Vector3.up * x * dragSpeed);
        } else {
            transform.Rotate (Vector3.up * speed * Time.deltaTime);
        }
    }
}