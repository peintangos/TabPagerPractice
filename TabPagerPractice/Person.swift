//
//  Persion.swift
//  TabPagerPractice
//
//  Created by 松尾淳平 on 2021/03/13.
//

import Foundation
protocol Person {
    func eat()
    func sleep()
    func play()
}

protocol Animal {
    func sleep()
    func play()
}

class PetOwner:Person{
    func eat() {
        
    }
    
    func sleep() {
        print("おやすみ")
    }
    
    func play() {
        print("遊び")
    }
    
    var pet:Animal
    init(pet:Animal){
        self.pet = pet
    }
}
class Cat:Animal{
    var name:String?
    init(name:String) {
        self.name = name
    }
    func sleep() {
        print("おやすみ")
    }
    
    func play() {
        print("遊び")
    }
    
    
}
