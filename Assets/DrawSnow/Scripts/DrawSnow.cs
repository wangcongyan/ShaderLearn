using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DrawSnow : MonoBehaviour
{
    // Start is called before the first frame update

    public Camera Camera;

    protected RaycastHit _hit;

    public Shader _drawShader;

    protected RenderTexture _splatMap;

    private Material _snowMaterial;

    public Texture2D Texture2D;
    void Start()
    {
        Camera = Camera.main;

        _drawShader = Shader.Find("Unlit/DrawTracks");
        _drawMaterial = new Material(_drawShader);

        _drawMaterial.SetVector("_Color",Color.red);

        _snowMaterial = GetComponent<MeshRenderer>().sharedMaterial;
        _splatMap = new RenderTexture(1024, 1024, 0, RenderTextureFormat.ARGBFloat);
        _snowMaterial.SetTexture("_Splat", _splatMap);
    }


    public Material _drawMaterial;

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.Mouse0))
        {
            if (Physics.Raycast(Camera.ScreenPointToRay(Input.mousePosition), out _hit))
            {
                _drawMaterial.SetVector("_Coordinate", new Vector4(_hit.textureCoord.x, _hit.textureCoord.y, 0, 0));

                RenderTexture temp = RenderTexture.GetTemporary(_splatMap.width, _splatMap.height, 0, RenderTextureFormat.ARGBFloat);
                Graphics.Blit(_splatMap, temp);
                Graphics.Blit(temp, _splatMap, _drawMaterial);
                RenderTexture.ReleaseTemporary(temp);
            }

        }
    }

    public GUISkin customSkin;

    void onGUI() 
    {
        GUI.skin = customSkin;
        GUI.DrawTexture(new Rect(0,0,256,256), _splatMap,ScaleMode.ScaleToFit,false,1);
        GUI.DrawTexture(new Rect(0, 0, 256, 256), Texture2D, ScaleMode.ScaleToFit, false, 1);
        GUI.TextArea(new Rect(0, 0, 256, 256), "test");

        GUILayout.Button("I am a custom styled Button", "MyCustomControl");

        // We can also ignore the Custom Style, and use the Skin's default Button Style
        GUILayout.Button("I am the Skin's Button Style");
    }
}
