# 风扇控制

[文档](https://docs.radxa.com/cubie/a7a/hardware-use/fan) | [社区 Q&A](https://forum.radxa.com/t/radxa-cubie-a7a-fan-control/28814)

## 配置
```bash
rsetup
# RSETUP > Hardware > Thermal governor
# PWM 风扇 选 step_wise
```

## 检查

```bash
for z in /sys/class/thermal/thermal_zone*; do echo "$(basename $z): $(cat $z/type) = $(( $(cat $z/temp) / 1000 ))°C"; done # 查看温度
```
