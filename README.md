# Carton Shaders Package
Shaders designed to help make a game looke more cartoonish (things like thick outlines, cell shading etc.)

# Project Includes:
1. Shader to change texture + color + transparency (Included on all shaders)
2. Cel-Shade Shader
3. Saturate/Contrast/Brightness Controls
4. Outline renderer
5. Water-like animator

# Instructions:
1. To use a basic shader, attach the BasicMat material to the gameobject(s)
2. To use the cel-shader, attach the ToonMat material to the gameobject(s)
3. To use the saturation/contrast shader, attach the PostProcessingCamera.cs script to the camera, then attach the PostProcessMat material to the "Post Process Mat" variable
4. To use the outline renderer, attach the OutlineMat material to the gameobject(s)
5. To use the water animator, attach the WaterMat material to the gameobject(s) [ideally a plane or a cube shape to make it look like water, but can be used on anyting to give it a wave effect]

# Resources:
https://docs.unity3d.com/Manual/SL-SetTexture.html 
https://docs.unity3d.com/Manual/SL-VertexFragmentShaderExamples.html 
https://docs.unity3d.com/Manual/Graphics.html 
https://www.youtube.com/watch?v=DeATXF4Szqo
https://www.youtube.com/watch?v=DeATXF4Szqo 
