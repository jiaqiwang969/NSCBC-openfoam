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
| Euler scheme explicit | [sineWaveDamping01](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/results/EulerSchemeExplicit.gif) | [Ref01](https://www.openfoam.com/documentation/guides/latest/doc/guide-schemes-time-local-euler.html) |
| Backward Scheme       | [sineWaveDamping02](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/results/BackwardTimeScheme.gif) | [Ref02](https://www.openfoam.com/documentation/guides/latest/doc/guide-schemes-time-backward.html) |
| Backward Scheme & p-sineWave & NRI-NSCBC       | [sineWaveDamping03](https://github.com/jiaqiwang969/NSCBC-openfoam/tree/main/Workspace/run/21-sineWaveDamping-backward-pressureOutletNSCBC-3000hz-temperatureOutletNSCBC-inletOutlet-zeroGradient-setFiled-1/python/21.gif) | [Ref03](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/projectUserDir/src/temperatureOutletNSCBC/temperatureOutletNSCBCFvPatchField.C) |
| Backward Scheme & p-sineWave & zeroGradient      | [sineWaveDamping04](https://github.com/jiaqiwang969/NSCBC-openfoam/tree/main/Workspace/run/22-sinWave-zerogradient/python/22.gif) |   |
| Backward Scheme & U-sineWave & NRI-NSCBC       | [sineWaveDamping05](https://github.com/jiaqiwang969/NSCBC-openfoam/tree/main/Workspace/run/23-sinWave-3000hz-U-NRINSCBC/python/23.gif) |   |
| Backward Scheme & p-triWave & NRI-NSCBC       | [sineWaveDamping06](https://github.com/jiaqiwang969/NSCBC-openfoam/tree/main/Workspace/run/24-triWave-table-U-NRINSCBC/python/24.gif) |   |
| Backward Scheme & U-waveletWave & NRI-NSCBC       | [sineWaveDamping07](https://github.com/jiaqiwang969/NSCBC-openfoam/tree/main/Workspace/run/31-codeMixed-NRINSCBC-5/python/31.gif) |   |



