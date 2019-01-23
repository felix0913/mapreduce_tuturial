object CaseClassApp {
    def main(args: Array[String]): Unit = {
        println(Dog("wangcai").name)

    }
}

// case class不用new
// case class通常用在模式匹配里
case class Dog(name:String)