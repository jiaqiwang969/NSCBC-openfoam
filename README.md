# NSCBC-Openfoam project

## Test_cases:
### 01-shockTube
|  boundary condition   | Link  |  Info  |
|  ----  | ----  | ----  |
| ZeroGradient  | [shockTube01](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/results/hardwall.gif) |  |
| waveTransmitive  | [shockTube02](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/results/shockTube-waveTrasmition-lInf%3D1.gif) | lInf=1 |
| waveTransmitive  | [shockTube03](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/results/shockTube-waveTrasmition-lInf%3D1000.gif) | lInf=1000 |
| NRI-inlet-Pressure  | [shockTube04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/results/inletPressure-NRI-NSCBC-K.gif) | etaAc=1 (etaAc=0.25 not convergent because of drift of mean velocity) |



### 02-sineWaveDamping

| Time scheme           | Link                                                         | Info                                                         |
| --------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Euler scheme explicit | [sineWaveDamping01](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/results/Euler scheme explicit.gif) | [Ref01](https://www.openfoam.com/documentation/guides/latest/doc/guide-schemes-time-local-euler.html) |
| Backward Scheme       | [sineWaveDamping02](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/results/Backward time scheme.gif) | [Ref02](https://www.openfoam.com/documentation/guides/latest/doc/guide-schemes-time-backward.html) |

Below boundary condition testing in "Backward Scheme": (Vertificating)

| boundary condition        | Link | Info                                                         |
| ------------------------- | ---- | ------------------------------------------------------------ |
| waveTransmitive & damping |      | [Ref](https://www.openfoam.com/documentation/guides/latest/doc/guide-fvoptions-sources-acoustic-damping.html) |
| waveTransmitive           |      |                                                              |
| NRI-outlet-Pressure       |      |                                                              |
|                           |      |                                                              |

