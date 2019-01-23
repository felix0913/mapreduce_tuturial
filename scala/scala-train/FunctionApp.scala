object FunctionApp {
    def main(args: Array[String]): Unit = {
        println(sum2(1, 2, 3))
    }

    def add(x: Int, y:Int): Int = {
    x + y
    }

    def sum2(numbers:Int*) : Int = {
    var result = 0
    for (number <- numbers) {
    result += number
    }
    result
    }

    var (num, sum) = (100, 0)
    while (num > 0) { // 出口
        sum = sum + num
        num = num - 1 // 步长
        }
    println(sum)
}