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
|  boundary condition   | Link  |  Info  |
|  ----  | ----  | ----  |
| waveTransmitive & acousticDampingSource  | [sineWaveDamping01](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/results/sineWaveDamping.gif) |  |
