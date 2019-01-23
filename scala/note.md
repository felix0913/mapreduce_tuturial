Scala基本数据类型：
- Byte/Char
- Short/Int/Long/Float/Double
- Boolean

## 函数：
- asInstanceOf: 类型转换
```
scala> val g = 10.asInstanceOf[Double]
g: Double = 10.0
```

isInstanceOf: 判断是否是括号内的类型
```
scala> val h = 10.isInstanceOf[Int]
h: Boolean = true

scala> val h = 10.isInstanceOf[Double]
h: Boolean = false
```

## lazy
```
scala> lazy val a = 1
a: Int = <lazy>

scala> a
res1: Int = 1
```
lazy模式：如果一个变量或一个常量，**你声明为lazy之后，并不会立刻发生真正的计算**，只有第一次使用的时候才会返回结果。

在耗费计算或网络的时候 用的比较多。
 