#if UNITY_EDITOR
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.IO;
using System.Linq;

public class worldExecuteEditorTools : EditorWindow
{
    public Mesh meshPrep;
    public Mesh meshStats;
    public int nOfMeshes;
    public Mesh[] meshes;
    public Material worldExecute;
    public Texture texture;
    public AudioSource worldExecuteAudio;
    private bool playing = false;
    static int max = 4194304;
    Vector2 scrollPos;

    [MenuItem("Window/World.Execute")]
    static void Init()
    {
        worldExecuteEditorTools window = (worldExecuteEditorTools)EditorWindow.GetWindow(typeof(worldExecuteEditorTools));
        window.Show();
    }

    private void OnGUI()
    {
        EditorGUILayout.BeginVertical();
        scrollPos = EditorGUILayout.BeginScrollView(scrollPos);

        meshPrep = (Mesh)EditorGUILayout.ObjectField(meshPrep, typeof(Mesh), false);
        if (GUILayout.Button("Prepare Mesh for Vertex Shader"))
        {
            Vector2[] uvs2 = new Vector2[meshPrep.vertices.Length];
            for (int i = 0; i < meshPrep.triangles.Length; i++)
            {
                uvs2[meshPrep.triangles[i]] = new Vector2(i / 3, i);
                if (i % 100 == 0)
                {
                    EditorUtility.DisplayProgressBar(
                        "If I'm a progress bar",
                        "Then I will give you the illusion of progress: " + i.ToString() + "/" + meshPrep.triangles.Length.ToString(),
                        (float)i / (float)meshPrep.triangles.Length
                    );
                }
            }
            EditorUtility.ClearProgressBar();
            Debug.Log("done");
            meshPrep.uv2 = uvs2;
            meshPrep.SetUVs(1, uvs2.ToList<Vector2>());
        }

        meshStats = (Mesh)EditorGUILayout.ObjectField(meshStats, typeof(Mesh), false);
        if (GUILayout.Button("Show Stats"))
        {
            Debug.Log("If I can be a texture containing " + meshStats.triangles.Length + " verticies as pixels named " + meshStats.name + ".exr");
        }
        if (GUILayout.Button("Populate List"))
        {
            string path = "Assets/world.execute/keyframes/";

            string[] files = Directory.GetFiles(path);
            int n = 0;
            foreach (string file in files)
            {
                if (Path.GetExtension(file) == ".FBX" || Path.GetExtension(file) == ".fbx")
                {
                    Mesh mesh = (Mesh)AssetDatabase.LoadAssetAtPath(file, typeof(Mesh));
                    if (mesh != null)
                    {
                        n++;
                    }
                }
            }
            nOfMeshes = n;
            meshes = new Mesh[nOfMeshes];
            n = 0;
            foreach (string file in files)
            {
                if (Path.GetExtension(file) == ".FBX" || Path.GetExtension(file) == ".fbx")
                {
                    Mesh mesh = (Mesh)AssetDatabase.LoadAssetAtPath(file, typeof(Mesh));
                    if (mesh != null)
                    {
                        meshes[n] = mesh;
                        n++;
                    }
                }
            }
        }

        nOfMeshes = EditorGUILayout.IntField(nOfMeshes);
        if (meshes.Length != nOfMeshes || meshes == null)
        {
            meshes = new Mesh[nOfMeshes];
        }
        for (int i = 0; i < nOfMeshes; i++)
        {
            meshes[i] = (Mesh)EditorGUILayout.ObjectField(i.ToString(),meshes[i], typeof(Mesh), false);
        }
        if (GUILayout.Button("Make Texture"))
        {
            int tCount = 0;
            int tCurrent = 0;
            int index = 0;
            //calculate number of triangles and safety check.
            foreach (Mesh mesh in meshes)
            {
                if (mesh != null)
                {
                    tCount += mesh.triangles.Length;
                }
            }
            //Debug.Log(tCount + " / " + max);
            if (tCount > max)
            {
                Debug.Log("Cannot Continue, too many triangles in combined meshes.");
                return;
            }

            //create, then zero the textures first.
            Texture2D meshTex = new Texture2D(2048, 2048, TextureFormat.RGBAFloat, false);
            Texture2D indexTex = new Texture2D(32, 32, TextureFormat.RGBAFloat, false);
            for (int i = 0; i < 2048; i++)
            {
                for (int j = 0; j < 2048; j++)
                {
                    meshTex.SetPixel(i, j, Vector4.zero);
                }
            }
            for (int i = 0; i < 32; i++)
            {
                for (int j = 0; j < 32; j++)
                {
                    indexTex.SetPixel(i, j, Vector4.zero);
                }
            }
            meshTex.Apply();
            indexTex.Apply();



            foreach (Mesh mesh in meshes)
            {
                if (mesh != null)
                {
                    Debug.Log("If I can be a mesh containing " + mesh.triangles.Length + " verticies");
                    int[] tris = mesh.triangles;
                    Vector3[] verts = mesh.vertices;
                    Color[] colors = meshTex.GetPixels();


                    for (int i = 0; i < mesh.triangles.Length; i++)
                    {
                        int n = tCurrent + i;
                        int x = n % 2048;
                        int y = n / 2048;
                        int t = tris[i];

                       Vector4 color = new Vector4(verts[t].x, verts[t].y, verts[t].z, 1);
                       colors[n] = color;

                        if (i % 100 == 0)
                        {
                            EditorUtility.DisplayProgressBar(
                                "If I'm a progress bar",
                                "Then I will give you the illusion of progress: " + n.ToString() + "/" + tCount,
                                (float)n / (float)tCount
                            );
                        }
                    }


                    meshTex.SetPixels(colors);
                    Debug.Log("Then, I will give you my pixels for execution.");

                    int x2 = index % 32;
                    int y2 = index / 32;
                    int p1 = tCurrent % 2048;
                    int p2 = tCurrent / 2048;
                    int l1 = mesh.triangles.Length % 2048;
                    int l2 = mesh.triangles.Length / 2048;
                    //Alpha is 1, just so I can tell something is there.
                    Vector4 color2 = new Vector4( p1, p2, l1, l2 );//position, then length. 
                    indexTex.SetPixel(x2, y2, color2);
                    indexTex.Apply();

                    //end of loop stuff.
                    tCurrent += mesh.triangles.Length;
                    index++;
                }
            }
            EditorUtility.ClearProgressBar();



            meshTex.Apply();
            byte[] bytes = meshTex.EncodeToEXR(Texture2D.EXRFlags.None);
            Object.DestroyImmediate(meshTex);
            File.WriteAllBytes(Application.dataPath + "/world.execute/meshData.exr", bytes);

            indexTex.Apply();
            bytes = indexTex.EncodeToEXR(Texture2D.EXRFlags.None);
            Object.DestroyImmediate(indexTex);
            File.WriteAllBytes(Application.dataPath + "/world.execute/indexData.exr", bytes);
        }

        if (GUILayout.Button("Make Seperate Texture"))
        {
            int width = 512;
            int height = 512;

            foreach (Mesh mesh in meshes) {
                if (mesh != null)
                {
                    Texture2D tex = new Texture2D(width, height, TextureFormat.RGBAFloat, false);

                    //reset (clear) the texture first.
                    for (int i = 0; i < 512; i++)
                    {
                        for (int j = 0; j < 512; j++)
                        {
                            tex.SetPixel(i, j, Vector4.zero);
                        }
                    }

                    Debug.Log("If I can be a texture containing " + mesh.triangles.Length + " verticies as pixels named " + mesh.name + ".exr");

                    for (int i = 0; i < mesh.triangles.Length; i++)
                    {
                        int x = i % 512;
                        int y = i / 512;
                        int t = mesh.triangles[i];

                        Vector4 color = new Vector4(mesh.vertices[t].x, mesh.vertices[t].y, mesh.vertices[t].z, 1);
                        tex.SetPixel(x, y, color);
                        if (i % 100 == 0)
                        {
                            EditorUtility.DisplayProgressBar(
                                "If I'm a progress bar",
                                "Then I will give you the illusion of progress: " + i.ToString() + "/" + mesh.triangles.Length.ToString(),
                                (float)i / (float)mesh.triangles.Length
                            );
                        }
                    }
                    EditorUtility.ClearProgressBar();
                    tex.Apply();
                    byte[] bytes = tex.EncodeToEXR(Texture2D.EXRFlags.None);
                    Object.DestroyImmediate(tex);
                    File.WriteAllBytes(Application.dataPath + "/world.execute/" + mesh.name + ".exr", bytes);
                    Debug.Log("Then, I will give you my pixels for execution.");
                }
            } 
        }

        worldExecute = (Material)EditorGUILayout.ObjectField(worldExecute, typeof(Material), true);
        worldExecuteAudio = (AudioSource)EditorGUILayout.ObjectField(worldExecuteAudio, typeof(AudioSource), true);
        if (GUILayout.Button("World.Execute(me)"))
        {
            if (!playing)
            {
                worldExecute.SetFloat("_StartTime", UnityEngine.Time.timeSinceLevelLoad);
                worldExecute.SetInt("_Play", 1);
                worldExecuteAudio.time = 0;
                worldExecuteAudio.Play();
                playing = true;
            } else
            {
                worldExecute.SetFloat("_StartTime", 0);
                worldExecute.SetInt("_Play", 0);
                worldExecuteAudio.time = 0;
                worldExecuteAudio.Stop();
                playing = false;
            }
        }
        EditorGUILayout.EndScrollView();
        EditorGUILayout.EndVertical();
    }
}
#endif