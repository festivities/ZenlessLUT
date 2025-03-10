# Pre-defined objects seen in the code such as `slider[0]` and `layer[0]` are exclusive to the Adobe After Effects plug-in [PixelsWorld](https://aescripts.com/pixelsworld/).

---

![Billy](https://public-files.gumroad.com/x2f7hou7ic9n79cshqloocutw1v9)

---

## Preview (better image comparisons [here](https://imgsli.com/Mjg0OTkx) and [here](https://imgsli.com/Mjg0OTkw))

![Billy](https://public-files.gumroad.com/of4m8dxj1kqk8qkm4yc8wi33hm28)

![Billy](https://public-files.gumroad.com/0hkxtoytb5e0xsl2avp86uglasil)

---

<p align="center">
    <a href="https://github.com/festivities/ZenlessLUT/blob/main/LICENSE"><img alt="GitHub license" src="https://img.shields.io/github/license/festivities/ZenlessLUT?style=for-the-badge"></a><br>
    <a href="https://discord.gg/85rP9SpAkF"><img alt="Discord" src="https://img.shields.io/discord/894925535870865498?style=for-the-badge"></a>
    <a href="https://github.com/festivities/ZenlessLUT/issues"><img alt="GitHub issues" src="https://img.shields.io/github/issues/festivities/ZenlessLUT?style=for-the-badge"></a>
</p>

---

## Usage with PixelsWorld

1. Download the game's internal LUT file [here](https://github.com/festivities/ZenlessLUT/blob/main/InternalLut_Char_1024x32.png). *Take note that this is not a traditional LUT - it's hard to explain but you can't use it as if it was any other LUT for filmography.*

2. In your Adobe After Effects project, apply the `PixelsWorld` effect onto the layer you want to apply ZenlessLUT to.

3. Set the `Language` parameter in PixelsWorld to `GLSL` and click on `Edit`. With `ZenlessLUT.glsl` open in a separate text editor, copy-paste the code onto the `World formula` editor. Once done, head onto the first `Layer` parameter and set it to the imported LUT. Control the strength of the LUT with the first `Slider` parameter. **Be sure to set the `Mipmap filter` parameter of the effect to `None`.**

4. If you have issues with flickering visuals/crashing, try turning off Multi-Frame Rendering in Edit -> Preferences -> Memory & Performance.

---

## Contact / Issues
- [Discord server](https://discord.gg/85rP9SpAkF)
- [Twitter](https://twitter.com/festivizing)
- Either contact me or [create an issue](https://github.com/festivities/ZenlessLUT/issues/new/choose) for any problems that may arise.
