# 模拟退火
Simulated Annealing, SA

[OI-Wiki](https://oi-wiki.org/misc/simulated-annealing/) | [Wikipedia](https://en.wikipedia.org/wiki/Simulated_annealing)

设 $S$ 为物理系统的热力学状态，$E$ 为当前状态下的系统内能 (需要最小化的函数)。设 $T$ 为温度，初始较大，结束时接近 $0$。

每次迭代中，取邻态 $S_\text{new}$。设从 $S$ 转移到 $S_\text{new}$ 的概率为 $P$，取决于两状态的能量差 $\Delta E = E_\text{new}-E$ 及当前温度 $T$。

在标准的 Metropolis 模拟退火中：

$$
T_0,\quad T \larr \alpha T,\quad T \ge T_\text{min}
$$

$$
P(\Delta E,T)=\begin{cases}
1,& \Delta E < 0, \\
\exp(-\Delta E/T),& \text{otherwise}.
\end{cases}
$$

# 自适应模拟退火
Adaptive Simulated Annealing, ASA

## 实现1：Lam 系

TODO

## 实现2：接受率反馈（已弃用）

**发现太过复杂，实际根本不会用。**

<details>
<summary>具体过程</summary>

### 初始温度 $T_0$

现有初始状态 $S$，能量 $E$ 以及一个随机的邻态转移方法 $f$。取 $N$ 个邻态 $S_i \overset{\text{i.i.d.}}{\sim} f(S)$，其中 $i=1,\dots,N$。计算各自的能量 $E_i$ 及能量增量 $\Delta E_i = E_i - E$。

设目标初始接受率 $p_0^* \in (0,1)$，一般取 0.7 ~ 0.95。下面使用 $p_0^*$ 及 $\Delta E_i$ 校准初温 $T_0$。

定义预测接受率 $\Phi(T),\ T>0$：

$$
\Phi(T) = \hat P_N(T) = \frac{1}{N} \sum_{i=1}^N \min\{1,\ e^{-\Delta E_i / T}\}
$$

考虑浮点数精度，定义预测接受率残差 $R(T)：

$$
R(T) = \frac{1}{N}\sum_{\Delta E_i > 0} e^{-\Delta E_i / T} \\
\Phi(T) = c + R(T),\quad c = \frac{ \# \{ i \mid \Delta E_i \le 0 \} }{N}
$$

定义接受率残差空间中的浮点安全余量 $\varepsilon_r = 10^{-12}$。

$c = 1$ 时，退化为 $\forall i,\ \Delta E_i \le 0 \Rarr \Phi(T) \equiv 1$，取 $T_0=1$。  
$1 - c \le 2 \varepsilon_r$ 时，视为不安全，取 $T_0=1$。  
后续步骤假设 $1 - c > 2 \varepsilon_r$。

$\Phi(T)$ 及 $R(T)$ 在 $(0,+\infty)$ 上严格递增。

$$
\forall\ T_1 < T_2,\quad R(T_1) < R(T_2)\\
R(0^+) = 0,\quad R(+\infty) = 1-c,\quad R(T) \in (0,1-c)
$$

方程 $R(T) = r_0$ 有唯一有限正解的充要条件是 $r_0 \in (0,1-c)$。  
定义目标接受率残差 $r_0^* = p_0^* - c$，修正 $r_0 = \text{clamp}(r_0^*,\ \varepsilon_r,\ 1 - c - \varepsilon_r)$。  
然后求 $R(T) = r_0$ 的近似解 $T_0$。记修正目标接受率 $p_0 = r_0+c$，有 $p_0-p_0^* = r_0-r_0^*$。

定义样本温度尺度 $D = \max \lvert \Delta E_i \rvert > 0$。

倍增法计算初始区间 $[L,U]$：

$$
\begin{aligned}
\mathcal S_L &= \{ k \in \mathbb{N_0} \mid R(2^{-k} D) \le r_0 \} \\
\mathcal S_U &= \{ k \in \mathbb{N_0} \mid R(2^k D) \ge r_0 \}
\end{aligned} \\[0.5em]

\begin{aligned}
\because{} & \lim_{k\to\infty}R(2^{-k}D)=R(0^+)=0<r_0 \\
& \lim_{k\to\infty}R(2^kD)=R(+\infty)=1-c>r_0 \\
\therefore{} & \mathcal S_L,\ \mathcal S_U \neq \varnothing
\end{aligned} \\[0.5em]

k_L = \min \mathcal S_L,\quad k_U = \min \mathcal S_U\\
L = 2^{-k_L} D,\quad U = 2^{k_U} D
$$

取相对温度误差 $\varepsilon_T = 10^{-3}$，二分法求 $T_0$：

$$
L_0 = L,\quad U_0 = U,\quad \tau_k = \frac{L_k + U_k}{2} \\[0.5em]

(L_{k+1},U_{k+1}) = \begin{cases}
(\tau_k,U_k), &R(\tau_k) < r_0 \\
(L_k,\tau_k), &R(\tau_k) \ge r_0
\end{cases} \\[0.5em]

% \mathcal S_k = \{k \in \mathbb{N_0} \mid U_k-L_k \le \varepsilon_T U_k\} \\[0.5em]
% \begin{aligned}
% \because{} & U_{k+1} - L_{k+1} = \frac{U_k-L_k}{2},\quad U_k \ge L_0 > 0 \\
% \therefore{} & k\ge\lceil \log_2 \frac{U_0-L_0}{\varepsilon_T L_0} \rceil \rArr U_k - L_k \le \varepsilon_T L_0 \le \varepsilon_T U_k \\
% \therefore{} & \mathcal S_k \neq \varnothing \\
% \end{aligned} \\[0.5em]

\mathcal S_k = \{k \in \mathbb{N_0} \mid U_k-L_k \le \varepsilon_T U_k\},\quad \mathcal S_k \neq \varnothing \\

k^* = \min \mathcal S_k,\quad \Phi(\tau_{k^*}) \approx p_0,\quad T_0 \coloneqq \tau_{k^*}
$$

### 温度迭代与接受率反馈
- 目标接受率 $P^*$：通常取 0.3 ~ 0.5。
- 接受率反馈增益 $\eta$：从 0.05 开始，根据 $\hat P_k$ 是否震荡调整。
- 温度变化限幅因子 $\rho_\text{min},\ \rho_\text{max}$：通常取 0.9/1 ~ 0.8/1.2。

设第 $k$ 个温度阶段为 $T_k$。  
设内循环长度为 $L_k$，常用 $L_k=\max\{ L_\text{min},\ \lceil cn \rceil \}$，其中 $n$ 是问题规模。  
设接受次数为 $A_k$，通过频率统计的阶段通过概率为 $\hat P_k=A_k/L_k$。

在每个温度阶段：
- 从当前 $S$ 出发，重复 $L_k$ 次：
  - 采样 $S' \sim f(S)$，计算 $\Delta E = E'-E$；
  - 以 $P(\Delta E, T)$ 接受；
  - 若接受，则更新当前状态 $S$，可选择更新历史最优 $S^*$。
- 统计该温度阶段接受率 $\hat P_k$。
- 根据目标接受率反馈调温：

$$
T_{k+1} = T_k \exp (-\eta(\hat P_k - P^*))
$$

- 为防止震荡，做限幅：

$$
T_{k+1} \coloneqq \text{clamp}(T_{k+1},\ \rho_\text{min}T_k,\ \rho_\text{max}T_k)
$$

### 结果

不会结束，除非超出时间/迭代次数预算。

</details>

<p></p>

