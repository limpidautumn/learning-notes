# 时钟树

只记了 System Clock，没记 RTC Clock / Master Clock Output。

## 时钟源
1. HSI 高速内部时钟源
2. HSE 高速外部时钟源
3. PLL 锁相环

## 时钟线
1. HCLK：位于 AHB 上，连接 CPU,SRAM,DMA,Flash；
2. PCLK1：位于 APB1 上；
3. PCLK2：位于 APB2 上；
4. FCLK：与 HCLK 同步，用于休眠时的中断采样。

APB1 / APB2 上连接的具体外设参考 [数据手册](https://www.st.com/resource/en/datasheet/stm32f103c8.pdf) 上的系统框架图。

## 时钟树
描述从时钟源开始，经过倍频、分频、选择开关等环节，最终供给 CPU 内核、存储器、外设和总线的完整路径。

手动调整：`HCLK`, `APB1/APB2 Prescaler`.
