# NSCBC-Openfoam project

## Test_cases:

### 01-sineWaveDamping-rhoPimpleFoam

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

### 02-sineWaveDamping-rhoPimpleFoam vs LusgsFoam
The LusgsFoam solver could be found: https://github.com/furstj/myFoam , plase refer it if use it.

| Time scheme           | Link                                                         | Info                                                         |  Time                                                         |
| --------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| sineWaveDampingPimpleFoam-Euler | [sineWaveDamping01](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam-Euler/python/sineWaveDampingPimpleFoam-Euler.gif) | [Timeseries01](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam-Euler/python/U-sineWaveDampingPimpleFoam-Euler.png) |   142.55 s |
| sineWaveDampingPimpleFoam-backward | [sineWaveDamping02](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam-backward/python/sineWaveDampingPimpleFoam-backward.gif) | [Timeseries02](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam-backward/python/U-sineWaveDampingPimpleFoam-backward.png) | 153.13 s |
| sineWaveDampingLusgsFoam-Euler | [sineWaveDamping03](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-Euler/python/sineWaveDampingLusgsFoam-Euler.gif) | [Timeseries03](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-Euler/python/U-sineWaveDampingLusgsFoam-backward.png) | 34.11 s |
| sineWaveDampingLusgsFoam-backward-iter10 | [sineWaveDamping04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-backward-iter10/python/1.gif) | [Timeseries04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-backward-iter10/python/p.jpg) | 184s |
| sineWaveDampingLusgsFoam-backward-iter50 | [sineWaveDamping04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-backward-iter50/python/1.gif) | [Timeseries04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-backward-iter50/python/p.jpg) | 283s |
| sineWaveDampingLusgsFoam-backward-iter100 | [sineWaveDamping04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-backward-iter100/python/1.gif) | [Timeseries04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-backward-iter100/python/p.jpg) | 270s (converged) |

### 03-ductWave 3D test
| Time scheme           | Link                                                         | Info                                                         |  Time                                                         |
| --------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| sineWaveDampingPimpleFoam3Dduct-basic | [sineWave3D01](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam3Dduct/python/duct3d-sinewave-render.gif) | 64 cores, waveTransimition boundary condition |   2028 s |





