object ConstructorApp {
    def main(args: Array[String]): Unit = {
        val person = new Person("zhangsan", 30)
    }
}

class Person(val name:String, val age:Int) {
    println("Person constructor enter...")

    val school = "ustc"

    println("Person constructor leave...")

}