using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class ScreenSpaceSnow : MonoBehaviour
{
	public Camera m_Cam;
	public Texture2D SnowTexture;

	public Color SnowColor = Color.white;

	public float SnowTextureScale = 0.1f;

	[Range(-1, 1)]
	public float BottomThreshold = 0f;
	[Range(-1, 1)]
	public float TopThreshold = 1f;

	private Material _material;

	void OnEnable()
	{
		// dynamically create a material that will use our shader
		_material = new Material(Shader.Find("Jamesloo/ScreenSpaceSnow"));

		// tell the camera to render depth and normals
		GetComponent<Camera>().depthTextureMode |= DepthTextureMode.DepthNormals;
	}

	void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		// set shader properties
		//_material.SetMatrix("_CamToWorld", GetComponent<Camera>().cameraToWorldMatrix);
		//m_Cam.ResetWorldToCameraMatrix
		_material.SetMatrix("_CamToWorld", m_Cam.worldToCameraMatrix);
		_material.SetColor("_SnowColor", SnowColor);
		_material.SetFloat("_BottomThreshold", BottomThreshold);
		_material.SetFloat("_TopThreshold", TopThreshold);
		_material.SetTexture("_SnowTex", SnowTexture);
		_material.SetFloat("_SnowTexScale", SnowTextureScale);

		// execute the shader on input texture (src) and write to output (dest)
		Graphics.Blit(src, dest, _material);
	}
}

