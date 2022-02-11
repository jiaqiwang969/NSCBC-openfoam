$$
\begin{array}{lll}
\hline \begin{array}{l}
\text { Boundary } \\
\text { condition }
\end{array} & \begin{array}{l}
\text { Transverse } \\
\text { Waves } \mathcal{L}_{3} \text { and } \mathcal{L}_{4}
\end{array} & \begin{array}{l}
\text { Axial } \\
\text { Wave } \mathcal{L}_{5}
\end{array} \\
\hline \text { NSCBC } & \mathcal{L}_{3}=-\frac{\partial v^{t}}{\partial t} \text { and } \mathcal{L}_{4}=-\frac{\partial w^{t}}{\partial t} & \frac{\mathcal{L}_{5}}{\rho c}=-2 \frac{\partial u_{a}^{t}}{\partial t}-2 \frac{\partial u_{v}^{t}}{\partial t} \\
& & +2 K\left[u-\left(\bar{u} \bar{u}+u_{a}^{t}+u_{v}^{t}\right)\right] \\
\text { NRI-NSCBC } & \mathcal{L}_{3}=-\frac{\partial v^{t}}{\partial t} \text { and } \mathcal{L}_{4}=-\frac{\partial w^{t}}{\partial t} & \frac{\mathcal{L}_{5}}{\rho c}=-2 \frac{\partial u_{a}^{t}}{\partial t}-\frac{\partial u_{v}^{t}}{\partial t} \\
& & +2 K\left[u-\left(\bar{u}+u_{a}^{t}+u_{v}^{t}+u_{-}\right)\right] \\
\hline
\end{array}
$$

$$
\frac{\partial p}{\partial t}+\frac{1}{2}\left(L_{5}+L_{1}\right)=0
$$

$$
L_{1}=(u-c)\left[\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right]
$$

$$
\begin{aligned}
&\frac{\mathcal{L}_{5}}{\rho c}=-2 \frac{\partial u_{a}^{t}}{\partial t}-\frac{\partial u_{v}^{t}}{\partial t} \\
&+2 K\left[u-\left(\bar{u}+u_{a}^{t}+u_{v}^{t}+u_{-}\right)\right]
\end{aligned}
$$

我们尝试将ref-13的公式与ref1的进行统一。

写法变化：
$$
给定的激励： u_{a}^{t} -->f_x \\
涡波：u_{v}^{t} -->0 \\
均匀流：\bar{u} --> u_t\\
反射的声波：u_{-} --> -g_u \\
$$
In ref-1:
$$
g_u =\frac{1}{2}\left(\frac{\langle p-\bar{p}\rangle}{\bar{\rho} \bar{c}}-\langle u-\bar{u}\rangle\right)
$$
In ref-13: (采用)
$$
u_{-}=\frac{1}{2 \rho c} \int_{0}^{t} (u-c)\left[\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right] d t
$$


系数上面有一些差别：

得到：
$$
\begin{aligned}
& \mathcal{L}_{5}=-2 \rho c \frac{\partial f_{x}^{t}}{\partial t} \\
&+2 \rho c K\left[u-\left(\bar{u}+u_{a}^{t}+u_{-}\right)\right]
\end{aligned}
$$
代入整理过程:
$$
\frac{\partial p}{\partial t}+\frac{1}{2}\left(2 \rho c K\left[u-\left(\bar{u}+u_{a}^{t}+u_{-}\right)\right] -2 \rho c \frac{\partial f_{x}^{t}}{\partial t} +(u-c)\left[\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right]\right)=0
$$

$$
\frac{\partial p}{\partial t}+\frac{1}{2}\left(2 \rho c K\left[u-\left(u_t+f_x+u_{-}\right)\right] -2 \rho c \frac{\partial f_{x}^{t}}{\partial t} +(u-c)\left[\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right]\right)=0
$$

$$
\frac{\partial p}{\partial t}+ \rho c K\left[u-\left(u_t+f_x+u_{-}\right)\right] - \rho c \frac{\partial f_{x}^{t}}{\partial t} +\frac{(u-c)}{2}\left[\frac{\partial p}{\partial x}-\rho c \frac{\partial u}{\partial x}\right]=0
$$

$$
\frac{\partial p}{\partial t} + \frac{(u-c)}{2} \frac{\partial p}{\partial x}+
\rho c K\left[u-\left(u_t+f_x+u_{-}\right)\right] - \rho c \frac{\partial f_{x}^{t}}{\partial t} - \frac{(u-c)}{2}\rho c \frac{\partial u}{\partial x}=0
$$

$$
\frac{P_{\text {face }}^{n+1}-P_{f a c e}^{n}}{d t} + \frac{u-c}{2} \frac{P_{\text {face }}^{n+1}-P_{\text {centre }}^{n+1}}{d x} \\ + \rho cK(u-u_t) - \rho cK (f_x + u_{-})- \frac{(u-c)}{2}\rho c \frac{\partial u}{\partial x} - \rho c \frac{\partial f_{x}^{t}}{\partial t} =0
$$

$$
P_{\text {face }}^{n+1}\left(1+\frac{u-c}{2} \frac{d t}{d x}\right) = 
P_{\text {face }}^{n}+\frac{u-c}{2} \frac{d t}{d x} P_{\text {centre }}^{n+1} \\
- \rho cK dt (u-u_t) + \rho cK dt (f_x + u_{-}) + \frac{(u-c)}{2}\rho c dt\frac{\partial u}{\partial x} +dt \rho c \frac{\partial f_{x}^{t}}{\partial t}
$$

$$
\Rightarrow \quad P_{\text {face }}^{n+1}= 
\underbrace{\frac{1}{1+\frac{u-c}{2} \frac{d t}{d x}}}_{f} [P_{\text {face }}^{n}- \rho cK dt (u-u_t) + \rho cK dt (f_x + u_{-}) + dt \rho c \frac{\partial f_{x}^{t}}{\partial t}]  \\
+ \underbrace{\frac{\frac{u-c}{2} \frac{d t}{d x}}{1+\frac{u-c}{2} \frac{d t}{d x}}}_{1-f}[P_{\text {centre }}^{n+1} + \underbrace{\rho c \frac{\partial u}{\partial x}}_{g r a d E x p r} d x]
$$

问题1: 如何将不同的边界条件整合到一起？ fx为速度。

问题2: 如何计算u-？
$$
-\rho c K dt--> 0.5K dt \rho c
$$


InletNSCBC:
$$
\frac{\partial T}{\partial t}+\frac{T}{\rho c^{2}}\left[-L_{2}+\frac{1}{2}(\gamma-1)\left(L_{5}+L_{1}\right)\right]=0
$$




