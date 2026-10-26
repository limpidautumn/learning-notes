# 值
- 值类别: [Value categories - cppreference](https://en.cppreference.com/cpp/language/value_category) | [zh](https://zh.cppreference.com/cpp/language/value_category)
- 引用: [Reference declaration](https://en.cppreference.com/cpp/language/reference) | [zh](https://zh.cppreference.com/cpp/language/reference)
- 转发: [std::forward](https://en.cppreference.com/cpp/utility/forward) | [zh](https://zh.cppreference.com/cpp/utility/forward)
- 移动: [std::move](https://en.cppreference.com/cpp/utility/move) | [zh](https://zh.cppreference.com/cpp/utility/move)

## 值类别
- glvalue: 有身份，表达式指代某个确定实体。
  - lvalue: 有身份，通常持久存储，通常可被内建 `&` 取地址。
  - xvalue: 有身份，标记为可移动。
- prvalue (= rvalue - xvalue): 没身份，表达式只是一个值。

精确定义非常复杂，见 cppreference。下面举例：

```cpp

int a = 1;  // a: lvalue, 变量名
// 1: prvalue, 字面量
// a + 1: prvalue, 计算结果
int* pa = &a;  // pa: lvalue
int* b = &(*pa);  // *pa: lvalue
int& c = a;  // c: lvalue
int&& d = std::move(a);  // d: lvalue, 具名的右值引用
```

## 引用
- `S& D;` 将 D 声明为 S 类型的左值引用，取别名。
- `S&& D;` 将 D 声明为 S 类型的右值引用，可以搬走。

引用不是对象，所以：引用不占空间，不存在引用的数组，不存在指向引用的指针，不存在引用的引用。

```cpp
int x = 1;

// 非 const 左值引用绑定左值，建立别名
int& a = x;  // OK
// int&a = 42;  // 错误

// const 左值引用绑定左值，建立别名
// const 左值引用绑定右值，延长生命周期
const int& b = 42;  // OK

// 右值引用绑定右值，延长生命周期
int&& c = 42;  // OK
// int&& c = x;  // 错误
int&& c = std::move(x);  // OK
int&& d = std::move(c);  // c: lvalue
```

## 移动

将临时对象或即将销毁对象持有的资源搬到新对象中。

移动：形参 = 右值引用，传入右值实参。

例外：模板函数的形参 = 无 cv 限定的右值引用，此时为“转发引用”。
