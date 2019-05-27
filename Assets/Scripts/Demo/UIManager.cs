using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour {

    float[] vals;
    Slider[] sliders;

    void Start () {
        UpdateNames ();

        sliders = FindObjectsOfType<Slider> ();
        vals = new float[sliders.Length];

        for (int i = 0; i < sliders.Length; i++) {
            sliders[i] = sliders[i];
            vals[i] = sliders[i].value;
        }
    }

    [ContextMenu ("Update Names")]
    void UpdateNames () {
        var sliders = FindObjectsOfType<Slider> ();
        foreach (var s in sliders) {
            Transform t = s.transform.parent;
            t.GetComponentInChildren<TMP_Text> ().text = t.gameObject.name + ": " + s.value;
            SliderValue (t.gameObject);
            s.value += .1f;
            s.value -= .1f;
        }
    }

    public void SliderValue (GameObject s) {
        var slider = s.GetComponentInChildren<Slider> ();
        var t = s.GetComponentInChildren<TMP_Text> ();
        string text = t.text;
        text = text.Substring (0, text.IndexOf (':'));
        string n = string.Format ("{0:0.##}", slider.value).Replace (',', '.');
        if (slider.value >= 1000) {
            n = Mathf.RoundToInt (slider.value / 1000) + "k";
        }
        t.text = text + ": " + n;
    }

    public void ResetSettings () {
        for (int i = 0; i < sliders.Length; i++) {
            sliders[i].value = vals[i];
        }
    }
}