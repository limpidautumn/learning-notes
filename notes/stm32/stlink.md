# ST-Link
环境配置参考 [dev-env-config.md](./dev-env-config.md)

## 问题合集
### 一、No Device Found

**报错信息**：
```
Error in initializing ST-LINK device.
Reason: No ST-LINK found. Please check ST-LINK USB cable.
```

**问题原因 #1**：没有配置 Debug 接口为 Serial Wire。

**解决方法 #1**：CubeMX 中配置 Debug 重新编译，进入系统存储器启动模式，下载程序后归位。[教程](https://keysking.com/docs/stm32/FAQ/CompilationFailed)

**问题原因 #2**：玄学连接问题，USB HUB 不干活。

**解决方法 #2**：重新插拔 ST-Link 到计算机 USB 接口的每一个设备及线缆，重试。

### 二、TCP 端口被占用
**报错信息**：
```
Failed to bind to port 61235, error code -1: No error
Failure starting SWV server on TCP port: 61235
Failed to bind to port 61234, error code -1: No error
Failure starting GDB server: TCP port 61234 not available.
```

**问题原因**：上一次调试时，STLink GDB Server 未正常退出。

**解决方法**：对于 Windows 系统，任务管理器中找到进程 `ST-LINK_gdbserver.exe`，终止后重试。对于 Linux 系统，使用 `lsof -i :PORT` 命令查看占用进程，再使用 `kill PID` 终止。

## 相关工具
[STM32 ST-LINK utility](https://www.st.com/en/development-tools/stsw-link004.html)




