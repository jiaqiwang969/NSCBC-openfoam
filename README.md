# NSCBC-Openfoam project

## Test_cases:

### 01-sineWaveDamping

| Time scheme           | Link                                                         | Info                                                         |
| --------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Euler scheme explicit | [sineWaveDamping01](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/results/EulerSchemeExplicit.gif) | [Ref01](https://www.openfoam.com/documentation/guides/latest/doc/guide-schemes-time-local-euler.html) |
| Backward Scheme       | [sineWaveDamping02](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/results/BackwardTimeScheme.gif) | [Ref02](https://www.openfoam.com/documentation/guides/latest/doc/guide-schemes-time-backward.html) |
| Backward Scheme & p-sineWave & NRI-NSCBC       | [sineWaveDamping03](https://github.com/jiaqiwang969/NSCBC-openfoam/tree/main/Workspace/run/oldVertified/21-sineWaveDamping-backward-pressureOutletNSCBC-3000hz-temperatureOutletNSCBC-inletOutlet-zeroGradient-setFiled-1/python/21.gif) | [Ref03](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/projectUserDir/src/temperatureOutletNSCBC/temperatureOutletNSCBCFvPatchField.C) |
| Backward Scheme & p-sineWave & zeroGradient      | [sineWaveDamping04](https://github.com/jiaqiwang969/NSCBC-openfoam/tree/main/Workspace/run/oldVertified/22-sinWave-zerogradient/python/22.gif) |   |
| Backward Scheme & U-sineWave & NRI-NSCBC       | [sineWaveDamping05](https://github.com/jiaqiwang969/NSCBC-openfoam/tree/main/Workspace/run/oldVertified/23-sinWave-3000hz-U-NRINSCBC/python/23.gif) |   |
| Backward Scheme & p-triWave & NRI-NSCBC       | [sineWaveDamping06](https://github.com/jiaqiwang969/NSCBC-openfoam/tree/main/Workspace/run/oldVertified/24-triWave-table-U-NRINSCBC/python/24.gif) |   |
| Backward Scheme & U-waveletWave & NRI-NSCBC       | [sineWaveDamping07](https://github.com/jiaqiwang969/NSCBC-openfoam/tree/main/Workspace/run/oldVertified/31-codeMixed-NRINSCBC-5/python/31.gif) |   |
| Backward Scheme & U-waveletWave & NRI-NSCBC       | [sineWaveDamping08](https://github.com/jiaqiwang969/NSCBC-openfoam/tree/main/Workspace/run/31-codeMixed-NRINSCBC-6/python/31.gif) | 2e-6(case07) vs dt=2e-5 (case08)  |


