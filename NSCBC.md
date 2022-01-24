Paper1: 公式：

### 可压N-S方程



主控方程，

笛卡尔坐标系：
$$
\left\{\begin{array}{l}
\frac{\partial \rho}{\partial t}+\nabla \cdot \rho \boldsymbol{u}=0 \\
\frac{\partial \rho \boldsymbol{u}}{\partial t}+\nabla \cdot[\boldsymbol{u}(\rho \boldsymbol{u})]+\nabla p=\nabla \cdot \mathbf{T} \\
\frac{\partial \rho E}{\partial t}+\nabla \cdot[\boldsymbol{u}(\rho E)]+\nabla \cdot(\boldsymbol{u} p)=\nabla \cdot \mathbf{T} \cdot \boldsymbol{u}-\nabla \cdot \boldsymbol{q}
\end{array}\right.
$$
状态方程:
$$
\rho E=\frac{1}{2} \rho u_{k} \cdot u_{k}+\frac{p}{\gamma-1}
$$
T 是粘性应力张量，其展开形式为：
$$
\tau_{i, j}=\mu\left(\frac{\partial u_{i}}{\partial x_{j}}+\frac{\partial u_{j}}{\partial x_{i}}-\frac{2}{3} \delta_{i j} \frac{\partial u_{k}}{\partial x_{k}}\right)
$$
m_i为三个方向的动量：
$$
m_i=\rho \boldsymbol{u}
$$
E is the total energy density (kinetic+thermal)
$$
e_{s}=\int_{T o}^{T} C_{v} d T \text { and } E=e_{s}+\frac{1}{2}\left(u^{2}+v^{2}+w^{2}\right)
$$
p 为压强, , q 为热传导通量。
$$
\boldsymbol{q}=-\lambda \nabla T
$$
T 为气体的温度，\lambda 为热传导率，它跟比热和普朗特常数有关系：
$$
\lambda=\frac{\mu c_{p}}{\operatorname{Pr}}
$$

## 相对坐标系的表达

从笛卡尔坐标系转化到相对坐标系，如图，相对坐标系建立在对象的边界上，边界上的每个单元都有自己的一套相对坐标系（以自我为中心）。

<img src="/Users/wjq/Library/Application Support/typora-user-images/image-20220120185505864.png" alt="image-20220120185505864" style="zoom:33%;" />

类似的，我们对每个感兴趣的单元，都有一套方程：

连续性方程：
$$
\frac{\partial \rho}{\partial t}+d_{1}+\frac{\partial m_{2}}{\partial \eta}+\frac{\partial m_{3}}{\partial \zeta}=0
$$
动量方程：
$$
\begin{aligned}
&\frac{\partial m_{1}}{\partial t}+u_{1} d_{1}+\rho d_{3}+\frac{\partial m_{1} u_{2}}{\partial \eta}+\frac{\partial m_{1} u_{3}}{\partial \zeta}=\frac{\partial \tau_{1 j}}{\partial x_{j}} \\
&\frac{\partial m_{2}}{\partial t}+u_{2} d_{1}+\rho d_{4}+\frac{\partial m_{2} u_{2}}{\partial \eta}+\frac{\partial m_{2} u_{3}}{\partial \zeta}=-\frac{\partial p}{\partial \eta}+\frac{\partial \tau_{2 j}}{\partial x_{j}} \\
&\frac{\partial m_{3}}{\partial t}+u_{3} d_{1}+\rho d_{5}+\frac{\partial m_{3} u_{2}}{\partial \eta}+\frac{\partial m_{3} u_{3}}{\partial \zeta}=-\frac{\partial p}{\partial \zeta}+\frac{\partial \tau_{3 j}}{\partial x_{j}}
\end{aligned}
$$
能量方程：
$$
\frac{\partial \rho E}{\partial t}+\frac{1}{2}\left(u_{k} \cdot u_{k}\right) d_{1}+\frac{d_{2}}{\gamma-1}+m_{1} d_{3}+m_{2} d_{4}+m_{3} d_{5}+\frac{\partial\left[(\rho E+p) u_{2}\right]}{\partial \eta}+\frac{\partial\left[(\rho E+p) u_{3}\right]}{\partial \zeta}=-\nabla \cdot q+\frac{\partial u_{j} \tau_{i j}}{\partial x_{i}}
$$
这里实际上，相当于将上述广义的方程，针对坐标系展开。这里，有个技巧，就是后续我们再做无反射边界处理，只关系垂直于表面的方向，因此，d1-d5为该方向的单独整理：
$$
\boldsymbol{d}=\left[\begin{array}{l}
d_{1} \\
d_{2} \\
d_{3} \\
d_{4} \\
d_{5}
\end{array}\right]=\left[\begin{array}{c}
\frac{1}{c^{2}}\left[L_{2}+\frac{1}{2}\left(L_{5}+L_{1}\right)\right] \\
\frac{1}{2}\left(L_{5}+L_{1}\right) \\
\frac{1}{2 \rho c}\left(L_{5}-L_{1}\right) \\
L_{3} \\
L_{4}
\end{array}\right]=\left[\begin{array}{c}
\frac{\partial m_{1}}{\partial \xi} \\
\frac{\partial c^{2} m_{1}}{\partial \xi}+u_{1} \frac{\partial p}{\partial \xi} \\
u_{1} \frac{\partial u_{1}}{\partial \xi}+\frac{1}{\rho} \frac{\partial p}{\partial \xi} \\
u_{1} \frac{\partial u_{2}}{\partial \xi} \\
u_{1} \frac{\partial u_{3}}{\partial \xi}
\end{array}\right]
$$
L1-L5到目前为止，其实还没有出现，怎么来的呢？

### 黎曼问题（特征方程）

该小节是为了完整的推导，并引出L，如果不感兴趣，完全可以跳过。

首先，上述主控方程，我们可以整理成矩阵的形式：
$$
\frac{\partial F(U(x, t))}{\partial t}+\frac{\partial F(U(x, t))}{\partial x}=0
$$
引入雅可比矩阵：
$$
J(x, t)=\frac{\partial F(U)}{\partial U}
$$
得到：
$$
\frac{\partial F(U(x, t))}{\partial t}+J(x, t) \frac{\partial U(x, t)}{\partial x}=0
$$
其核心思想:就是研究雅可比矩阵的性质，如何研究？求特征值：
$$
J(x, t)=K(x, t) \Lambda(x, t) K^{-1}(x, t)
$$

$$
A(x, t) K^{i}(x, t)=\lambda_{i}(x, t) K^{i}(x, t)
$$

我们拿一维的欧拉方程作为案例，方便理解：
$$
\frac{\partial U}{\partial t}+\frac{\partial}{\partial x} F(U)=0
$$

$$
U=\left(\begin{array}{c}
\rho \\
\rho u \\
\rho e_{t o t}
\end{array}\right), F(U)=\left(\begin{array}{c}
\rho u \\
\rho u^{2}+p \\
\rho e_{t o t} u+p u
\end{array}\right), \text { and } p=(\gamma-1)\left(\rho e_{t o t}-\frac{1}{2} \rho u^{2}\right)
$$

简单的高数知识：
$$
J(U)=\frac{\partial F(U)}{\partial U}=\left(\begin{array}{ccc}
0 & 1 & 0 \\
\frac{1}{2}(\gamma-3) u^{2} & (3-\gamma) u & \gamma-1 \\
-\gamma u e_{t o t}+(\gamma-1) u^{3} & \gamma e_{t o t}-\frac{3}{2}(\gamma-1) u^{2} & \gamma u
\end{array}\right)
$$
然后做手动做特征值分解：
$$
\Lambda(U)=\left(\begin{array}{ccc}
u-c_{s} & 0 & 0 \\
0 & u & 0 \\
0 & 0 & u+c_{s}
\end{array}\right) \quad K(U)=\left(\begin{array}{ccc}
1 & 1 & 1 \\
u-c_{s} & u & u+c_{s} \\
e_{t o t}+\frac{p}{\rho}-u c_{s} & \frac{1}{2} u^{2} & e_{t o t}+\frac{p}{\rho}+u c_{s}
\end{array}\right)
$$
cs为声速，
$$
c_{s}=\sqrt{\frac{\gamma p}{\rho}}
$$
三维的线性欧拉方程同理（无能量方程）：
$$
J(U)=\left(\begin{array}{ccccc}
0 & 1 & 0 & 0 \\
-u_{x}^{2}+\frac{1}{2}(\gamma-1) \underline{u}^{2} & (3-\gamma) u_{x} & -(\gamma-1) u_{y} & -(\gamma-1) u_{z} & \gamma-1 \\
-u_{x} u_{y} & u_{y} & u_{x} & 0 & 0 \\
-u_{x} u_{z} & u_{z} & 0 & u_{x} & 0 \\
-\gamma e_{t o t} u_{x}-2 u_{x}^{3}+(\gamma-1) u_{x} \underline{u}^{2} & \gamma e_{t o t}+(4-\gamma) u_{x}^{2}-\frac{1}{2}(\gamma-1) \underline{u}^{2} & -(\gamma-1) u_{x} u_{y} & -(\gamma-1) u_{x} u_{z} & \gamma u_{x}
\end{array}\right)
$$

$$
\Lambda(U)=\left(\begin{array}{ccccc}
u_{x}-c_{s} & 0 & 0 & 0 & 0 \\
0 & u_{x} & 0 & 0 & 0 \\
0 & 0 & u_{x} & 0 & 0 \\
0 & 0 & 0 & u_{x} & 0 \\
0 & 0 & 0 & 0 & u_{x}+c_{s}
\end{array}\right)
$$

从特征值，我们一下子就能对流声特征进行分析和分离，无反射边界的核心思想也在此体现。

声波：没有方向性，u-c和u+c，还有三个方向的流动。



### 无反射边界条件

基于上述的线性欧拉方程的特征分解结果，整理一下：

特征值：
$$
\left\{\begin{array}{l}
\lambda_{1}=u_{1}-c \\
\lambda_{2}=\lambda_{3}=\lambda_{4}=u_{1} \\
\lambda_{5}=u_{1}+c
\end{array}\right.
$$
特征值对应的特征函数：
$$
\boldsymbol{L}=\left[\begin{array}{l}
L_{1} \\
L_{2} \\
L_{3} \\
L_{4} \\
L_{5}
\end{array}\right]=\left[\begin{array}{c}
\lambda_{1}\left(\frac{\partial p}{\partial \xi}-\rho c \frac{\partial u_{1}}{\partial \xi}\right) \\
\lambda_{2}\left(c^{2} \frac{\partial \rho}{\partial \xi}-\frac{\partial p}{\partial \xi}\right) \\
\lambda_{3} \frac{\partial u_{2}}{\partial \xi} \\
\lambda_{4} \frac{\partial u_{3}}{\partial \xi} \\
\lambda_{5}\left(\frac{\partial p}{\partial \xi}+\rho c \frac{\partial u_{1}}{\partial \xi}\right)
\end{array}\right]
$$
再次说明，无反射条件的处理办法，就是将入射波的L设置为0。

（这样一通筛查操作之后，我们便可以将坐标系转化回去。有点像是调查罪犯一样，一通思想拷问之后，把不法分子关起来，然后把清白的都放回家。）



特征函数与基本参数之间的对应关系，也找到了：
$$
\boldsymbol{d}=\left[\begin{array}{l}
d_{1} \\
d_{2} \\
d_{3} \\
d_{4} \\
d_{5}
\end{array}\right]=\left[\begin{array}{c}
\frac{1}{c^{2}}\left[L_{2}+\frac{1}{2}\left(L_{5}+L_{1}\right)\right] \\
\frac{1}{2}\left(L_{5}+L_{1}\right) \\
\frac{1}{2 \rho c}\left(L_{5}-L_{1}\right) \\
L_{3} \\
L_{4}
\end{array}\right]=\left[\begin{array}{c}
\frac{\partial m_{1}}{\partial \xi} \\
\frac{\partial c^{2} m_{1}}{\partial \xi}+u_{1} \frac{\partial p}{\partial \xi} \\
u_{1} \frac{\partial u_{1}}{\partial \xi}+\frac{1}{\rho} \frac{\partial p}{\partial \xi} \\
u_{1} \frac{\partial u_{2}}{\partial \xi} \\
u_{1} \frac{\partial u_{3}}{\partial \xi}
\end{array}\right]
$$
将主控方程表达成与特征方程有关的形式（这也是上面为啥引入d的原因）
$$
\left\{\begin{array}{l}
\frac{\partial \rho}{\partial t}+\frac{1}{c^{2}}\left[L_{2}+\frac{1}{2}\left(L_{5}+L_{1}\right)\right]+\frac{\partial m_{2}}{\partial \eta}+\frac{\partial m_{3}}{\partial \zeta}=0 \\
\frac{\partial p}{\partial t}+\frac{1}{2}\left(L_{5}+L_{1}\right)+\frac{\partial\left[(\rho E+p) u_{2}\right]}{\partial \eta} \frac{\partial\left[(\rho E+p) u_{3}\right]}{\partial \zeta}=-\nabla \cdot q \\
\frac{\partial u_{1}}{\partial t}+\frac{1}{2 \rho c}\left(L_{5}-L_{1}\right)+\frac{\partial m_{1} u_{2}}{\partial \eta}+\frac{\partial m_{1} u_{3}}{\partial \zeta}=0 \\
\frac{\partial u_{2}}{\partial t}+L_{3}+\frac{\partial m_{2} u_{2}}{\partial \eta}+\frac{\partial m_{2} u_{3}}{\partial \zeta}=-\frac{\partial p}{\partial \eta} \\
\frac{\partial u_{3}}{\partial t}+L_{4}+\frac{\partial m_{3} u_{2}}{\partial \eta}+\frac{\partial m_{3} u_{3}}{\partial \zeta}=-\frac{\partial p}{\partial \zeta}
\end{array}\right.
$$

### 算法实现：

仅考虑一维的情况,x1，且不考虑源项（第二篇论文就复杂这上面，待会再说），因此，上面方程可以简化成：

公式1:
$$
\left\{\begin{array}{l}
\frac{\partial \rho}{\partial t}+\frac{1}{c^{2}}\left[L_{2}+\frac{1}{2}\left(L_{5}+L_{1}\right)\right]=0 \\
\frac{\partial p}{\partial t}+\frac{1}{2}\left(L_{5}+L_{1}\right)=0 \\
\frac{\partial u_{1}}{\partial t}+\frac{1}{2 \rho c}\left(L_{5}-L_{1}\right)=0 \\
\frac{\partial u_{2}}{\partial t}+L_{3}=0 \\
\frac{\partial u_{3}}{\partial t}+L_{4}=0
\end{array}\right.
$$
为了更好的说明清楚，会有上面的重复内容。

特征值：
$$
\left\{\begin{array}{l}
\lambda_{1}=u_{1}-c \\
\lambda_{2}=\lambda_{3}=\lambda_{4}=u_{1} \\
\lambda_{5}=u_{1}+c
\end{array}\right.
$$
公式2:
$$
\boldsymbol{L}=\left[\begin{array}{l}L_{1} \\L_{2} \\L_{3} \\L_{4} \\L_{5}\end{array}\right]=\left[\begin{array}{c}\lambda_{1}\left(\frac{\partial p}{\partial x_1}-\rho c \frac{\partial u_{1}}{\partial x_1}\right) \\\lambda_{2}\left(c^{2} \frac{\partial \rho}{\partial x_1}-\frac{\partial p}{\partial x_1}\right) \\\lambda_{3} \frac{\partial u_{2}}{\partial x_1} \\\lambda_{4} \frac{\partial u_{3}}{\partial x_1} \\\lambda_{5}\left(\frac{\partial p}{\partial x_1}+\rho c \frac{\partial u_{1}}{\partial x_1}\right)\end{array}\right]
$$

​		可以分析得出，\lambda_1 为负（传入），其他都为正（传出）。
​		

这里，在执行数值化的时候，需要注意，不能讲L1直接设置为0。这样，方程会出现病态。因此，一些人已经做了一些优化：Rudy and Strikwerda ，

公式3:
$$
L_{1}=K \cdot\left(p-p_{\infty}\right)=\sigma \cdot \frac{\left|1-M^{2}\right|}{\sqrt{2} J \rho l}\left(p-p_{\infty}\right)
$$
\sigma可以在【0.1，pi】之间取值。

#### 基本流程

Step1: 利用上面的公式2、3，计算L2、L3、 L4、 L5，L1单独计算。

Step2: 带入公式1，时间步迭代，更新边界条件的结果。

此时，该算法，就可以以函数的形式写入到openfoam solver里去了。但是，这种面向策略的植入，会碰到诸多版本不同，或者交流、改写、升级代码的诸多不便。

因此，需要进一步改写代码，使其兼容mix-coded的框架。



### Openfoam植入

边界条件最核心的四个参数：
$$
\begin{array}{l|l|l}
\hline & \text { Diagonal Coeff } & \text { Source term } \\
\hline \text { Divergence } & \text { valueInternalCoeffs } & \text { valueBoundaryCoeffs } \\
\hline \text { Laplacian } & \text { gradientInternalCoeffs } & \text { gradientBoundaryCoeffs } \\
\hline
\end{array}
$$
所有openfoam下的边界条件都是这四个参数的组合：
$$
\begin{aligned}
\phi_{b} &=F l u x C b \phi_{C}+F l u x V b \\
&=\text { valueInternalCoeffs } \phi_{C}+\text { valueBoundaryCoeffs }
\end{aligned}
$$

$$
\nabla \phi_{b}=\text { gradientInternalCoeffs } \phi_{C}+\text { gradientBoundaryCoeffs }
$$

#### 1. Dirichlet 边界条件

$$
\begin{array}{l|l|l}
\hline \text { Dirichlet } & \text { Diagonal Coeff } & \text { Source term } \\
\hline \text { Divergence } & 0 & \text { Boundary value } \\
\hline \text { Laplacian } & \text { Delta } & \text { Boundary value and delta } \\
\hline
\end{array}
$$

$$
\begin{aligned}
\phi_{b} &=F l u x C b \phi_{C}+F l u x V b \\
&=\text { valueInternalCoeffs } \phi_{C}+\text { valueBoundaryCoeffs } \\
&=0 \phi_{C}+\phi_{\text {specified }}
\end{aligned}
$$

$$
\begin{aligned}
\nabla \phi_{b} &=\text { gradientInternalCoeffs } \phi_{C}+\text { gradientBoundaryCoeffs } \\
&=\frac{-\phi_{C}+\phi_{b}}{d}=\left(-\phi_{C}+\phi_{b}\right) \text { delta }=-\phi_{C} \text { delta }+\phi_{b} \text { delta }
\end{aligned}
$$

#### 2. Nuemann 边界条件

$$
\begin{array}{l|l|l}
\hline \text { Neumann (zero order) } & \text { Diagonal Coeff } & \text { Source term } \\
\hline \text { Divergence } & \text { Value(1) } & 0 \\
\hline \text { Laplacian } & 0 & 0 \\
\hline
\end{array}
$$

$$
\begin{aligned}
\phi_{b} &=\text { FluxCb } \phi_{C}+\text { FluxVb } \\
&=\text { valueInternalCoeffs } \phi_{C}+\text { valueBoundaryCoeffs } \\
&=1 \phi_{C}+0
\end{aligned}
$$

$$
\begin{aligned}
\nabla \phi_{b} &=\text { gradientInternalCoeffs } \phi_{C}+\text { gradientBoundaryCoeffs } \\
&=0 \phi_{C}+0
\end{aligned}
$$

#### 3. 混合边界条件

```
valueInternalCoeffs=1.0 - valueFraction
valueBoundaryCoeffs= valueFraction * refValue + (1.0 - valueFraction) * refGrad /deltaCoeffs
gradientInternalCoeffs =valueFraction*deltaCoeffs
gradientBoundaryCoeffs=valueFraction * deltaCoeffs * refValue+ (1.0 - valueFraction) * refGrad_;
```

可以看出，这个边界实际上是由valueFraction、refValue、refGrad这三个参数来控制(这3个参数更有物理意义)。

表示，Dirichlet和Nuemann边界条件的组合形式：
$$
P_{face}^{n+1}= valueFraction*refVlaue+(1-valueFraction)*(P_{centre}^{n+1}+refGrad* Delta)
$$
通过，观察就能发现，和上面的关系是一一对应的。

$P_{centre}^{n+1}$ 是因为，solver要先进行计算，然后再更新边界条件，更新边界条件之前，centre已经算到n+1了



### 将NSCBC转化成混合边界的表达形式

仅考虑一维的情况,x1，且不考虑源项（第二篇论文就复杂这上面，待会再说），因此，上面方程可以简化成：

为了更好的说明清楚，会有上面的重复内容。

特征值：
$$
\left\{\begin{array}{l}
\lambda_{1}=u_{1}-c \\
\lambda_{2}=\lambda_{3}=\lambda_{4}=u_{1} \\
\lambda_{5}=u_{1}+c
\end{array}\right.
$$
公式2:
$$
\boldsymbol{L}=\left[\begin{array}{l}L_{1} \\L_{2} \\L_{3} \\L_{4} \\L_{5}\end{array}\right]=\left[\begin{array}{c}\lambda_{1}\left(\frac{\partial p}{\partial x_1}-\rho c \frac{\partial u_{1}}{\partial x_1}\right) \\\lambda_{2}\left(c^{2} \frac{\partial \rho}{\partial x_1}-\frac{\partial p}{\partial x_1}\right) \\\lambda_{3} \frac{\partial u_{2}}{\partial x_1} \\\lambda_{4} \frac{\partial u_{3}}{\partial x_1} \\\lambda_{5}\left(\frac{\partial p}{\partial x_1}+\rho c \frac{\partial u_{1}}{\partial x_1}\right)\end{array}\right]
$$

​		可以分析得出，\lambda_1 为负（传入），其他都为正（传出）。
​		

这里，在执行数值化的时候，需要注意，不能讲L1直接设置为0。这样，方程会出现病态。因此，一些人已经做了一些优化：Rudy and Strikwerda ，
$$
L_{1}=K \cdot\left(p-p_{\infty}\right)=\sigma \cdot \frac{\left|1-M^{2}\right|}{\sqrt{2} J \rho l}\left(p-p_{\infty}\right)
$$
\sigma可以在【0.1，pi】之间取值。



$$
\left\{\begin{array}{l}
\frac{\partial \rho}{\partial t}+\frac{1}{c^{2}}\left[L_{2}+\frac{1}{2}\left(L_{5}+L_{1}\right)\right]=0 \\
\frac{\partial p}{\partial t}+\frac{1}{2}\left(L_{5}+L_{1}\right)=0 \\
\frac{\partial u_{1}}{\partial t}+\frac{1}{2 \rho c}\left(L_{5}-L_{1}\right)=0 \\
\frac{\partial u_{2}}{\partial t}+L_{3}=0 \\
\frac{\partial u_{3}}{\partial t}+L_{4}=0
\end{array}\right.
$$
还可以继续将温度项，动量，熵，焓都表达成L的形式：见ref-1
$$
\frac{\partial T}{\partial t}+\frac{T}{\rho c^{2}}\left[-L_{2}+\frac{1}{2}(\gamma-1)\left(L_{5}+L_{1}\right)\right]=0
$$

$$
\frac{\partial m_{1}}{\partial t}+\frac{1}{c}\left[M L_{2}+\frac{1}{2}\left\{(M-1) L_{1}+(M+1) L_{5}\right\}\right]=0
$$

$$
\frac{\partial s}{\partial t}-\frac{1}{(\gamma-1) \rho T} L_{2}=0
$$

$$
\frac{\partial h}{\partial t}+\frac{1}{(\gamma-1) \rho}\left[-L_{2}+\frac{\gamma-1}{2}\left\{(1-M) L_{1}+(1+M) L_{5}\right\}\right]=0
$$

$$
h=(\rho E+p) / \rho=\frac{1}{2} u_{i}^{2}+C_{p} T
$$

$$
s=C_{\nu} \log p / \rho^{\gamma}+const
$$

$$
M=u_{1} / c
$$



另外，时间和空间是可以相互变换的，也可以表达成空间的形式。暂时不做赘述。



![image-20220121203322316](/Users/wjq/Library/Application Support/typora-user-images/image-20220121203322316.png)



### 1. 波动方程的NSCBC

代码实现举例-openfoam中的advection和waveTransmissive边界条件。

在openfoam中，日本博主的[博文](http://caefn.com/openfoam/bc-advective-wavetransmissive)和陈十七的[博客](https://blog.csdn.net/weixin_39124457/article/details/120152679?spm=1001.2014.3001.5502)完整介绍了advective边界条件。
$$
\frac{D \phi}{D t} \approx \frac{\partial \phi}{\partial t}+U_{n} \cdot \frac{\partial \phi}{\partial \mathbf{n}}=0
$$
数值化：
$$
\frac{\phi_{\text {face }}^{n+1}-\phi_{\text {face }}^{n}}{d t}+U_n \frac{\phi_{\text {face }}^{n+1}-\phi_{\text {centre }}^{n+1}}{d x}=0
$$

$$
\rightarrow \begin{aligned}
\phi_{\text {face }}^{n+1}\left(1+U_n \frac{d t}{d x}\right) &=\phi_{\text {face }}^{n}+U_n \frac{d t}{d x} \phi_{\text {centre }}^{n+1}
\end{aligned}
$$

$$
\rightarrow \quad \phi_{f a c e}^{n+1} =\frac{1}{1+U_n \frac{d t}{d x}} [P_{f a c e}^{n}]+\frac{U_n \frac{d t}{d x}}{1+U_n \frac{d t}{d x}} [P_{\text {centre }}^{n+1} ]
$$

$$
P_{face}^{n+1}= valueFraction*refVlaue+(1-valueFraction)*(P_{centre}^{n+1}+refGrad* Delta)
$$

源代码：advectiveFvPatchField.C

```
const scalarField w(Foam::max(advectionSpeed(), scalar(0)));
const scalarField alpha(w*deltaT*this->patch().deltaCoeffs());

this->refValue() =(field.oldTime().boundaryField()[patchi] + k*fieldInf_)/(1.0 + k);
this->valueFraction() = (1.0 + k)/(1.0 + alpha + k);
this->refGrad() =zero;
```

k是和松弛有关的参数，可以不考虑。



### 2. 线性欧拉方程的NSCBC(不考虑速度)-ref1

waveTransmissive可以看成最简单的波动方程，而现在我们考虑联系欧拉方程的情况。

如果不考虑进口的初始速度，则梯度项为0，lambda3 和lambda4为0，L3、L4项可以忽略，着重考虑L1、L2和L5项的影响。

但后续，我们运用到叶轮机械的仿真，会着重考虑速度项的影响。

Polifke加了几项修正，该项目是单独从波动方程推演过来的，但可能非常重要，不要忽视，我们暂时不考虑。
$$
\begin{array}{c|c|c}
\text { Inlet } & \text { LODI system } & \text { Outlet } \\
\hline \hline L_{1}=(u-c)\left[\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right] & \frac{\partial p}{\partial t}+\frac{1}{2}\left(L_{5}+L_{1}\right)=0 & L_{1}=\frac{\sigma_{1}}{\rho c}\left[p-\rho c\left(f_{d}+g_{x}\right)-p_{\infty}\right]+2 \frac{\partial g_{x}}{\partial t} \\
L_{5}=\sigma_{5}\left[u-\left(f_{x}-g_{u}\right)-u_{t}\right]+2 \frac{\partial f_{x}}{\partial t} & \frac{\partial u_{1}}{\partial t}+\frac{1}{2 \rho c}\left(L_{5}-L_{1}\right) & L_{5}=(u-c)\left[\frac{\partial p}{\partial x}+\rho c \frac{\partial u}{\partial x}\right] \\
L_{2}=\sigma_{2}\left[T-\frac{\gamma-1}{\gamma}\left(f_{d}+g_{x}\right)-T_{t}\right] & \frac{\partial T}{\partial t}+\frac{T}{\rho c^{2}}\left(-L_{2}+\frac{1}{2}(\gamma-1)\left(L_{5}+L_{1}\right)\right) & L_{2}=u\left[c^{2}\left(\frac{\partial \rho}{\partial x}-\frac{\partial p}{\partial x}\right)\right]
\end{array}
$$
**1. Inlet Pressure**
$$
\frac{\partial p}{\partial t}+\frac{1}{2}\left(L_{5}+L_{1}\right)=0
$$

$$
L_{1}=(u-c)\left[\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right] \quad \text { and } \quad L_{5}=\sigma_{5}\left[u-\left(f_{x}-g u\right)-u_{t}\right]+2 \rho c \frac{\partial f_{x}}{\partial t}
$$

$$
\frac{\partial p}{\partial t}+\frac{1}{2}\left[\sigma_{5}\left(u-\left(f_{x}-g_{u}\right)-u_{t}\right)+2 \rho c \frac{\partial f_{x}}{\partial t}+(u-c)\left(\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right)\right]=0
$$

$$
\frac{\partial p}{\partial t}+\frac{\sigma_{5}}{2}\left(u-u_{t}\right)-\frac{\sigma_{5}}{2}\left(f_{x}-g_{u}\right)+\rho c \frac{\partial f_{x}}{\partial t}+\frac{u-c}{2} \frac{\partial p}{\partial x}-\frac{u-c}{2} \rho c \frac{\partial u}{\partial x}=0
$$

$$
\frac{\partial p}{\partial t}+\frac{u-c}{2} \frac{\partial p}{\partial x}-\frac{\sigma_{5}}{2}\left(u-u_{t}\right)-\frac{\sigma_{5}}{2}\left(f_{x}-g_{u}\right)-\frac{u-c}{2} \rho c \frac{\partial u}{\partial x}+\rho c \frac{\partial f_{x}}{\partial t}=0
$$

数值化：
$$
\frac{P_{\text {face }}^{n+1}-P_{\text {face }}^{n}}{d t}+\frac{u-c}{2} \frac{P_{\text {face }}^{n+1}-P_{\text {centre }}^{n+1}}{d x}-\frac{\sigma_{5}}{2}\left(u-u_{t}\right)-\frac{\sigma_{5}}{2}\left(f_{x}-g_{u}\right)-\frac{u-c}{2} \rho c \frac{\partial u}{\partial x}+\rho c \frac{\partial f_{x}}{\partial t}=0
$$

$$
\rightarrow \begin{aligned}
P_{\text {face }}^{n+1}\left(1+\frac{u-c}{2} \frac{d t}{d x}\right) &=P_{\text {face }}^{n}+\frac{u-c}{2} \frac{d t}{d x} P_{\text {centre }}^{n+1}+\frac{\sigma_{5}}{2} d t\left(u-u_{t}\right)-\frac{\sigma_{5}}{2} d t\left(f_{x}-g_{u}\right)-\\
&-\frac{u-c}{2} \rho c d t \frac{\partial u}{\partial x}+d t \rho c \frac{\partial f_{x}}{\partial t}
\end{aligned}
$$

$$
\begin{aligned}
\rightarrow \quad P_{f a c e}^{n+1} &=\frac{1}{1+\frac{u-c}{2} \frac{d t}{d x}}\left[P_{f a c e}^{n}-\frac{\sigma_{5}}{2} d t\left[\left(u-u_{t}\right)+\left(f_{x}-g_{u}\right)\right]+d t \rho c \frac{\partial f_{x}}{\partial t}\right]+\\
&+\frac{\frac{u-c}{2} \frac{d t}{d x}}{1+\frac{u-c}{2} \frac{d t}{d x}}\left[P_{\text {centre }}^{n+1}+\rho c \frac{\partial u}{\partial x} d x\right]
\end{aligned}
$$

$$
\begin{aligned}
\Rightarrow \quad P_{f a c e}^{n+1} &=\underbrace{\frac{1}{1+\frac{u-c}{2} \frac{d t}{d x}}}_{f} \underbrace{\left[P_{f a c e}^{n}-\frac{\sigma_{5}}{2} d t\left[\left(u-u_{t}\right)+\left(f_{x}-g u\right)\right]+d t \rho c \frac{\partial f_{x}}{\partial t}\right]}_{\text {valueExpr }}+\\
&+\underbrace{\frac{\frac{u-c}{2} \frac{d t}{d x}}{1+\frac{u-c}{2} \frac{d t}{d x}}}_{1-f}[P_{\text {centre }}^{n+1}+\underbrace{\rho c \frac{\partial u}{\partial x}}_{\text {gradExpr }} d x]
\end{aligned}
$$


$$
P_{face}^{n+1}= valueFraction*refVlaue+(1-valueFraction)*(P_{centre}^{n+1}+refGrad* Delta)
$$

**2. Outlet Pressure**
$$
\frac{\partial p}{\partial t}+\frac{1}{2}\left(L_{5}+L_{1}\right)=0
$$

$$
L_{5}=\frac{1}{2}\left[(u+c)\left(\frac{\partial p}{\partial x}+\rho c \frac{\partial u}{\partial x}\right)\right] \quad \text { and } \quad L_{1}=\frac{\sigma}{\rho c}\left[p-\rho c\left(f_{d}+g_{x}\right)-p_{\infty}\right]+2 \frac{\partial g_{x}}{\partial t}
$$

$$
\frac{\partial p}{\partial t}+\frac{1}{2}\left[(u+c)\left(\frac{\partial p}{\partial x}+\rho c \frac{\partial u}{\partial x}\right)+\frac{\sigma}{\rho c}\left(p-\rho c\left(f_{d}+g_{x}\right)-p_{\infty}\right)+2 \frac{\partial g_{x}}{\partial t}\right]=0
$$

$$
\frac{\partial p}{\partial t}+\frac{u+c}{2} \frac{\partial p}{\partial x}+\rho c \frac{u+c}{2} \frac{\partial u}{\partial x}+\frac{\sigma}{2 \rho c}\left(p-p_{\infty}\right)-\frac{\sigma}{2}\left(f_{d}+g_{x}\right)+\frac{\partial g_{x}}{\partial t}=0
$$

数值化：
$$
\frac{P_{f a c e}^{n+1}-P_{f a c e}^{n}}{d t}+\frac{u+c}{2} \frac{P_{f a c e}^{n+1}-P_{c e n t r e}^{n+1}}{d x}+\rho c \frac{u+c}{2} \frac{\partial u}{\partial x}+\frac{\sigma}{2 \rho c}\left(P_{f a c e}^{n+1}-p_{\infty}\right)-\frac{\sigma}{2}\left(f_{d}+g x\right)+\frac{\partial g_{x}}{\partial t}=0
$$

$$
\begin{aligned}
&P_{f a c e}^{n+1}-P_{f a c e}^{n}+\frac{u+c}{2} \frac{d t}{d x}\left(P_{f a c e}^{n+1}-P_{c e n t r e}^{n+1}\right)+\rho c \frac{u+c}{2} d t \frac{\partial u}{\partial x}+\frac{\sigma}{2 \rho c} d t\left(P_{f a c e}^{n+1}-p_{\infty}\right)-\frac{\sigma}{2} d t\left(f_{d}+g_{x}\right)+ \\
&+\frac{\partial g_{x}}{\partial t} d t=0
\end{aligned}
$$

$$
\begin{aligned}
&P_{\text {face }}^{n+1}\left(1+\frac{u+c}{2} \frac{d t}{d x}+\frac{\sigma}{2 \rho c} d t\right)=P_{\text {face }}^{n}+\frac{u+c}{2} \frac{d t}{d x} P_{\text {centre }}^{n+1}-\rho c \frac{u+c}{2} d t \frac{\partial u}{\partial x}+\frac{\sigma}{2} d t\left(f_{d}+g_{x}\right)+\frac{\sigma}{2 \rho c} d t p_{\infty}- \\
&-\frac{\partial g_{x}}{\partial t} d t
\end{aligned}
$$

$$
\begin{aligned}
&P_{f a c e}^{n+1}=\frac{1+\frac{\sigma d t}{2 \rho c}}{1+\frac{u+c}{2} \frac{d t}{d x}+\frac{\sigma d t}{2 \rho c}}\left[\frac{P_{f a c e}^{n}+\frac{\sigma d t}{2 \rho c} p_{\infty}+\frac{\sigma d t}{2}\left(f_{d}+g x\right)-d t \frac{\partial g_{x}}{\partial t}}{1+\frac{\sigma d t}{2 \rho c}}\right]+\frac{\frac{u+c}{2} \frac{d t}{d x}}{1+\frac{u+c}{2} \frac{d t}{d x}+\frac{\sigma d t}{2 \rho c}}\left[P_{c e n t r e}^{n+1}+\right. \\
&\left.+\left(-\rho c \frac{\partial u}{\partial x} d x\right)\right]
\end{aligned}
$$

$$
\begin{aligned}
&P_{f a c e}^{n+1}=\underbrace{\frac{1+\frac{\sigma d t}{2 \rho c}}{1+\frac{u+c}{2} \frac{d t}{d x}+\frac{\sigma d t}{2 \rho c}}}_{f} \underbrace{\left[\frac{P_{f a c e}^{n}+\frac{\sigma d t}{2 \rho c} p_{\infty}+\frac{\sigma d t}{2}\left(f_{d}+g_{x}\right)-d t \frac{\partial g_{x}}{\partial t}}{1+\frac{\sigma d t}{2 \rho c}}\right]}_{\text {valueExpr }}+\\
&+\underbrace{\frac{\frac{u+c}{2} \frac{d t}{d x}}{1+\frac{u+c}{2} \frac{d t}{d x}+\frac{\sigma d t}{2 \rho c}}}_{1-f}\left[P_{\text {centre }}^{n+1}+(\underbrace{-\rho c \frac{\partial u}{\partial x}}_{\text {gradExpr }} d x)\right]
\end{aligned}
$$

**3. Inlet Temperature**
$$
\frac{\partial T}{\partial t}+\frac{T}{\rho c^{2}}\left[-L_{2}+\frac{1}{2}(\gamma-1)\left(L_{5}+L_{1}\right)\right]=0
$$

$$
\left.L_{1}=(u-c)\left[\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right] \quad \text { and } \quad L_{5}=-\sigma_{5}\left[u-\left(f_{x}-g_{u}\right)-u_{t}\right]-2 \rho c \frac{\partial f_{x}}{\partial t} \quad \text { and } \quad L_{2}=-\sigma_{2}\left[\left(T-T_{t}\right)-\frac{\gamma-1}{\gamma} \frac{c}{R}(f+g)\right)\right]
$$

$$
\begin{aligned}
&\frac{\partial T}{\partial t}+\frac{T}{\rho c^{2}}\left[\sigma_{2}\left(\left(T-T_{t}\right)-\frac{\gamma-1}{\gamma} \frac{c}{R}(f+g)\right)+\frac{1}{2}(\gamma-1)\left(-\sigma_{5}\left(u-(f-g)-u_{t}\right)-2 \rho c \frac{\partial f}{\partial t}+\right.\right. \\
&\left.\left.\quad+(u-c)\left(\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right)\right)\right]=0
\end{aligned}
$$

$$
\text { as } \quad \frac{T}{\rho c^{2}}=\frac{1}{\gamma \rho R}
$$

$$
\begin{aligned}
\frac{\partial T}{\partial t} &+\sigma_{2} \frac{1}{\gamma \rho R}\left(T-T_{t}\right)-\sigma_{2} \frac{\gamma-1}{\gamma} \frac{1}{\gamma \rho R} \frac{c}{R}(f+g)-\sigma_{5} \frac{\gamma-1}{\gamma} \frac{1}{2 \rho R}\left(u-(f-g)-u_{t}\right)-\\
&-\frac{\gamma-1}{\gamma} \frac{c}{R} \frac{\partial f}{\partial t}+\frac{\gamma-1}{\gamma} \frac{u-c}{2 \rho R}\left(\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right)=0
\end{aligned}
$$

数值化：
$$
\begin{aligned}
\frac{T_{\text {face }}^{n+1}-T_{\text {face }}^{n}}{d t} &+\frac{\sigma_{2}}{\gamma \rho R}\left(T_{\text {face }}^{n+1}-T_{t}\right)-\sigma_{2} \frac{\gamma-1}{\gamma} \frac{1}{\gamma \rho R} \frac{c}{R}(f+g)-\sigma_{5} \frac{\gamma-1}{\gamma} \frac{1}{2 \rho R}\left(u-(f-g)-u_{t}\right)-\\
&-\frac{\gamma-1}{\gamma} \frac{c}{R} \frac{\partial f}{\partial t}+\frac{\gamma-1}{\gamma} \frac{u-c}{2 \rho R}\left(\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right)=0
\end{aligned}
$$

$$
\begin{gathered}
T_{\text {face }}^{n+1}\left(1+\frac{\sigma_{2} d t}{\gamma \rho R}\right)-T_{\text {face }}^{n}-\frac{\sigma_{2} d t}{\gamma \rho R} T_{t}-\sigma_{2} \frac{\gamma-1}{\gamma} \frac{d t}{\gamma \rho R} \frac{c}{R}(f+g)-\sigma_{5} \frac{\gamma-1}{\gamma} \frac{d t}{2 \rho R}\left(u-(f-g)-u_{t}\right)- \\
-\frac{\gamma-1}{\gamma} \frac{c}{R} d t \frac{\partial f}{\partial t}+\frac{\gamma-1}{\gamma} \frac{u-c}{2 \rho R} d t\left(\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right)=0
\end{gathered}
$$

$$
\begin{aligned}
\rightarrow \quad T_{f a c e}^{n+1} &=\left[T_{f a c e}^{n}+\frac{\sigma_{2} d t}{\gamma \rho R} T_{t}+\sigma_{2} \frac{\gamma-1}{\gamma} \frac{d t}{\gamma \rho R} \frac{c}{R}(f+g)+\sigma_{5} \frac{\gamma-1}{\gamma} \frac{d t}{2 \rho R}\left(u-(f-g)-u_{t}\right)+\right.\\
&\left.+\frac{\gamma-1}{\gamma} \frac{c}{R} d t \frac{\partial f}{\partial t}-\frac{\gamma-1}{\gamma} \frac{u-c}{2 \rho R} d t\left(\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right)\right] /\left[1+\frac{\sigma_{2} d t}{\gamma \rho R}\right]
\end{aligned}
$$

$$
\begin{aligned}
\Rightarrow 
T_{\text {face }}^{n+1}=&\left[T_{\text {face }}^{n}+\frac{\sigma_{2} d t}{\gamma \rho R} T_{t}+\frac{\gamma-1}{\gamma}\left[\frac{c}{R} d t \frac{\partial f}{\partial t}-\frac{u-c}{2 \rho R} d t\left(\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right)+\right.\right.\\
&\left.\left.\sigma_{5} \frac{d t}{2 \rho R}\left(u-(f-g)-u_{t}\right)+\sigma_{2} \frac{d t}{\gamma \rho R} \frac{c}{R}(f+g)\right]\right] /\left[1+\frac{\sigma_{2} d t}{\gamma \rho R}\right]
\end{aligned}
$$

$$
T_{face}^{n+1}= valueFraction*refVlaue+0
$$

**3. Outlet Temperature**
$$
\frac{\partial T}{\partial t}+\frac{T}{\rho c^{2}}\left[-L_{2}+\frac{1}{2}(\gamma-1)\left(L_{5}+L_{1}\right)\right]=0
$$

$$
L_{2}=u\left(c^{2} \frac{\partial \rho}{\partial x}-\frac{\partial p}{\partial x}\right) \quad \text { and } \quad L_{5}=(u+c)\left(\frac{\partial p}{\partial x}+\rho c \frac{\partial u}{\partial x}\right) \quad \text { and } \quad L_{1}=\frac{\sigma}{\rho c}\left[p-\rho c\left(f_{d}+g_{x}\right)-p_{\infty}\right]+2 \frac{\partial g_{x}}{\partial t}
$$

$$
\frac{\partial T}{\partial t}+\frac{T}{\rho c^{2}}\left[-u\left(c^{2} \frac{\partial \rho}{\partial x}-\frac{\partial p}{\partial x}\right)+\frac{1}{2}(\gamma-1)\left(L_{5}+L_{1}\right)\right]=0
$$

$$
\frac{\partial T}{\partial t}-\frac{u c^{2} T}{\rho c^{2}} \frac{\partial \rho}{\partial x}+\frac{u T}{\rho c^{2}} \frac{\partial p}{\partial x}+\frac{T(\gamma-1)}{2 \rho c^{2}}\left(L_{5}+L_{1}\right)=0
$$

$$
\frac{\partial T}{\partial t}-\frac{u T}{\rho}\left(\frac{\rho}{p} \frac{\partial p}{\partial x}-\frac{\rho}{T} \frac{\partial T}{\partial x}\right)+\frac{u T}{\rho c^{2}} \frac{\partial p}{\partial x}+\frac{T(\gamma-1)}{2 \rho c^{2}}\left(L_{5}+L_{1}\right)=0
$$

$$
\frac{\partial T}{\partial t}-\frac{u T}{p} \frac{\partial p}{\partial x}+u \frac{\partial T}{\partial x}+\frac{u T}{\rho c^{2}} \frac{\partial p}{\partial x}+\frac{T(\gamma-1)}{2 \rho c^{2}}\left(L_{5}+L_{1}\right)=0
$$

$$
\frac{\partial T}{\partial t}+u \frac{\partial T}{\partial x}+u\left(\frac{T}{\rho c^{2}}-\frac{T}{p}\right) \frac{\partial p}{\partial x}+\frac{T(\gamma-1)}{2 \rho c^{2}}\left(L_{5}+L_{1}\right)=0
$$

$$
\frac{\partial T}{\partial t}+u \frac{\partial T}{\partial x}+u \frac{1-\gamma}{\rho R \gamma} \frac{\partial p}{\partial x}+\frac{\gamma-1}{2 \rho R \gamma}\left(L_{5}+L_{1}\right)=0
$$

数值化：
$$
\frac{T_{\text {face }}^{n+1}-T_{\text {face }}^{n}}{d t}+u \frac{T_{\text {face }}^{n+1}-T_{\text {centre }}^{n+1}}{d x}+u \frac{1-\gamma}{\rho R \gamma} \frac{\partial p}{\partial x}+\frac{\gamma-1}{2 \rho r \gamma}\left(L_{5}-L_{1}\right)=0
$$

$$
T_{\text {face }}^{n+1}-T_{\text {face }}^{n}+\frac{u d t}{d x}\left(T_{\text {face }}^{n+1}-T_{\text {centre }}^{n+1}\right)+u d t \frac{1-\gamma}{\rho R \gamma} \frac{\partial p}{\partial x}+\frac{(\gamma-1) d t}{2 \rho R \gamma}\left(L_{5}+L_{1}\right)=0
$$

$$
\rightarrow T_{f a c e}^{n+1}\left(1-\frac{u d t}{d x}\right)=T_{f a c e}^{n}+\frac{u d t}{d x} T_{c e n t r e}^{n+1}-u d t \frac{1-\gamma}{\rho R \gamma} \frac{\partial p}{\partial x}-\frac{(\gamma-1) d t}{2 \rho R \gamma}\left(L_{5}+L_{1}\right)
$$

$$
\Rightarrow \quad T_{f a c e}^{n+1}=\underbrace{\frac{1}{1-\frac{u d t}{d x}}}_{f} \underbrace{\left[T_{f a c e}^{n}-\frac{(\gamma-1) d t}{2 \rho R \gamma}\left(L_{5}+L_{1}\right)\right]}_{\text {valueExpr }}+\underbrace{\frac{\frac{u d t}{d x}}{1-\frac{u d t}{d x}}}_{1-f}[T_{c e n t r e}^{n+1}+\underbrace{\frac{\gamma-1}{\rho R \gamma} \frac{\partial p}{\partial x}}_{\text {gradExpr }} d x]
$$

$$
T_{face}^{n+1}= valueFraction*refVlaue+(1-valueFraction)*(T_{centre}^{n+1}+refGrad* Delta)
$$



### 3. 更加一般化的形式推导（适用于叶轮机械）-ref2

在压气机的仿真过程中，不同于一般的边界条件处理，一般会使用总压，总温作为进口边界，这主要是为了和实验的测量结果保持一致性。但，这个边界条件的无反射条件，在目前市面上的所有仿真软件中，都是看不到的。另外，相比上面的方程，速度项被加了进来，包含方向。因此，是欧拉方程的一般化形式，甚至在燃烧🔥领域，可以把组分也考虑进来。

总压：Ps为静压，其他参数之前都提到过。
$$
P_{t}=P_{S}\left(1+\frac{\gamma-1}{2} M^{2}\right)^{\frac{\gamma}{\gamma-1}}
$$
总温：Ts为静温，其他参数之前都提到过。
$$
T_{t}=T_{S}\left(1+\frac{\gamma-1}{2} M^{2}\right)
$$


4. 从简单的波动方程----》 逐步过渡到---〉》管道的特征值求解-----〉















～～～～～～～～～～～～～～～～

其他参数的推导过程举例：

（2.63）
$$
\frac{\partial \rho}{\partial t}+\frac{1}{c^{2}}\left[L_{2}+\frac{1}{2}\left(L_{5}+L_{1}\right)\right]=0
$$
（2.65）
$$
\frac{\partial u_{1}}{\partial t}+\frac{1}{2 \rho c}\left(L_{5}-L_{1}\right)=0
$$

$$
m_{1}=\rho u_{1}
$$

$$
{\partial m_1\over\partial t} =u_1 {\partial \rho \over \partial t} + \rho {\partial u_1\over \partial t} = u_1 \frac{1}{c^{2}}\left[L_{2}+\frac{1}{2}\left(L_{5}+L_{1}\right)\right] + \rho\frac{1}{2 \rho c}\left(L_{5}-L_{1}\right) \\
=
\frac{1}{c}\left[M L_{2}+\frac{1}{2}\left\{(M-1) L_{1}+(M+1) L_{5}\right\}\right]
$$

即(2.69)





