# 并发

[Concurrency support library](https://en.cppreference.com/cpp/thread) | [zh](https://zh.cppreference.com/cpp/thread)

## Latches and Barriers

### std::barrier
[std::barrier](https://en.cppreference.com/cpp/thread/barrier) | [zh](https://zh.cppreference.com/cpp/thread/barrier)

阻塞一组已知数量的线程，直到所有线程都到达屏障。适合分阶段并行计算。
- 可重复使用：一个阶段完成后，进入下一个阶段。
- 可以在每个阶段完成时执行一个完成函数。

**用法**

```cpp
// 构造
std::barrier sync_point(count, completion);
std::barrier sync_point(count);  // 使用默认空完成函数
// 要求 completion 无参数调用合法，且 noexcept。

// 同步
// a. 到达并等待
sync_point.arrive_and_wait();

// b. 先到达，再等待
auto token = sync_point.arrive();
sync_point.wait(std::move(token));

// c. 到达后离开
sync_point.arrive_and_drop();

```

一般步骤 (按时间顺序)：
1. 构造 `barrier`，明确需要等待的线程数量 `count` 及阶段完成时调用的函数 `completion`。
2. 线程工作。
3. 完成当前阶段后调用 `arrive_and_wait()`，通知 `barrier` 并阻塞式等待。
4. `barrier` 统计当前到达的线程数，直到其与 `count` 一致。
5. `barrier` 执行 `completion`。
6. `barrier` 解除第 3 步等待，线程回到第 2 步……

通俗地：
1. Alice 签到记人数，要等 N 个人。Bob 等人齐全后汇总结果。
2. Worker 1, Worker 2, ..., Worker N 独立执行任务。
3. Worker i 完成后，找 Alice 签到并等待放行。
4. Alice 记满 N 个人。
5. Alice 通知 Bob 收取结果。
6. Bob 任务完成后通知 Alice，Alice 放行 Workers。Workers 回归工作……

说明：
- "3.": 线程可以执行 `arrive_and_wait()`；也可以在阶段完成后先执行 `token = arrive()`，期间完成收尾工作，最后执行 `wait(token)` 等待下一阶段；还可以在阶段完成后执行 `arrive_and_drop()`，通知 `barrier` 离开，并使后续阶段的初始期望计数 `count -= 1`。
- "5.": 完成函数结束 = 当前阶段结束 = 等待结束 = 下一阶段开始。完成步骤结束强先行于所有被解除阻塞的调用返回。

**示例**

见 [barrier - cppreference](https://en.cppreference.com/cpp/thread/barrier#Example)。
