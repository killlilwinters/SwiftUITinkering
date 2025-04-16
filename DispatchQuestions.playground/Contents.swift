import UIKit

let serialQueue = DispatchQueue(label: "com.example.serial")

serialQueue.async {
    print("A")
}

serialQueue.async {
    print("B")
}

serialQueue.async {
    print("C")
}

print("D")
