# NSCBC-Openfoam project
- Aim: Reproduce the Nonreflecting boundary condition in paper “Partially reflecting and non-reflecting boundary conditions for simulation of compressible viscous flow”
- Ref: see [here](https://github.com/jiaqiwang969/NSCBC-openfoam/tree/main/ref)
- New: 1. add backward NRBC scheme; 
- Sponsor：Dong
- Acknowledge：[Cheng](https://blog.csdn.net/weixin_39124457/article/details/120152679?spm=1001.2014.3001.5502)

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
| sineWaveDampingPimpleFoam-Euler | [sineWaveDamping01](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam-Euler/python/sineWaveDampingPimpleFoam-Euler.gif) | [Timeseries01](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam-Euler/python/U-sineWaveDampingPimpleFoam-Euler.png) |   4cores,142.55 s |
| sineWaveDampingPimpleFoam-backward | [sineWaveDamping02](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam-backward/python/sineWaveDampingPimpleFoam-backward.gif) | [Timeseries02](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam-backward/python/U-sineWaveDampingPimpleFoam-backward.png) | 4cores,153.13 s |
| sineWaveDampingLusgsFoam-Euler | [sineWaveDamping03](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-Euler/python/sineWaveDampingLusgsFoam-Euler.gif) | [Timeseries03](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-Euler/python/U-sineWaveDampingLusgsFoam-backward.png) | 4cores,34.11 s |
| sineWaveDampingLusgsFoam-backward-iter10 | [sineWaveDamping04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-backward-iter10/python/1.gif) | [Timeseries04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-backward-iter10/python/p.jpg) | 4cores,184s |
| sineWaveDampingLusgsFoam-backward-iter50 | [sineWaveDamping04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-backward-iter50/python/1.gif) | [Timeseries04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-backward-iter50/python/p.jpg) | 4cores,283s |
| sineWaveDampingLusgsFoam-backward-iter100 | [sineWaveDamping04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-backward-iter100/python/1.gif) | [Timeseries04](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingLusgsFoam-backward-iter100/python/p.jpg) | 4cores,270s (converged) |

### 03-ductWave 3D test - Mesh independent Test - waveTransimition boundary condition 
| CaseName | cells in Z-direction          | Link                                                         | Info                                                         |  Time                                                         |
| ---------------------| --------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| sineWaveDampingPimpleFoam3Dduct-basic | 115 | [sineWave3D](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam3Dduct/python/duct3d-sinewave-render.gif) | too coarse mesh in z-direction, [sinWave3D-plot-in-space](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam3Dduct/python/1.gif) |  64 cores, 2028 s |
| sineWaveDampingPimpleFoam3Dduct-Z16| 135 |  [sinWave3D](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam3Dduct-fine-Z16/python/11.gif) | no-converaged, [timeSeries](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam3Dduct-fine-Z16/python/p_U.jpg) [space](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam3Dduct-fine-Z16/python/1.gif)|   64cores, 2069 s |
| sineWaveDampingPimpleFoam3Dduct-Z32| 270 | [sinWave3D](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam3Dduct-fine-Z32/python/11.gif) | no-converaged, [timeSeries](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam3Dduct-fine-Z32/python/p_u.jpg) [space](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam3Dduct-fine-Z32/python/1.gif)|   64cores, 4582 s |
| sineWaveDampingPimpleFoam3Dduct-Z64| 540 |  [sinWave3D](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam3Dduct-fine-Z64/python/11.gif) | converaged, [timeSeries](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam3Dduct-fine-Z64/python/p_U.jpg) [space](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/sineWaveDampingPimpleFoam3Dduct-fine-Z64/python/1.gif)|   64cores, 10372 s |

### 04 sineWave in cascade test - NSCBC boundary condition 
| CaseName |  Link                                                         | Info                                                         |  Time                                                         |
| ---------------------| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 001-naca65-NSCBC-backward-sineWave-Ux1Uy1 |  [sinWaveCascade](https://github.com/jiaqiwang969/NSCBC-openfoam/blob/main/Workspace/run/001-naca65-NSCBC-backward-sineWave-Ux1Uy1/11.gif) | xxx  ｜ 40cores, 0.0192 s， 153s |


### Gallery
- [2D room NSCBC vs walls](https://www.youtube.com/watch?v=f8dbn-7mPXU)

