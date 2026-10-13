# NTC 热敏电阻

## β 模型
$$
R(T) = R_0 \exp\left[B\left(\frac{1}{T} - \frac{1}{T_0}\right)\right]
$$

- $R(T)$: 温度 $T$ 时的电阻, 单位 $\mathrm{\Omega}$.
- $R_0$: 参考温度 $T_0$ 时的电阻, 单位 $\mathrm{\Omega}$.
- $T$, $T_0$: 绝对温度, 单位 $\mathrm{K}$.
- $B$: NTC 的 B 值常数, 单位 $\mathrm{K}$.

### B 值定义

$$
B = \frac{\ln(R_1/R_2)}{\frac{1}{T_1} - \frac{1}{T_2}}
$$

### 反解温度

$$
\frac{1}{T} = \frac{1}{T_0} + \frac{1}{B} \ln \frac{R}{R_0}
$$
