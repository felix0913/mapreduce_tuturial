object SimpleObjectApp {
    def main(args: Array[String]): Unit = {
        val person = new People()
        person.name = "Messi"
        println(person.name + ".." + person.age)

        person.printInfo()

    }
}

class People {
    // var: 对应的对象有get与set方法
    var name:String = _
    // val：对应的对象有get方法，没有set方法
    val age:Int = 10

    private [this] val gender = "male"

    def printInfo(): Unit = {
        println("gender: " + gender)
    }

    def eat():String = {
        name + " eat..."
        }
    
    def watchFootball(teamName: String) : Unit = {
        println(name + " is watching match of " + teamName)
        }
    
    }