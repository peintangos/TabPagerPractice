//
//  SwinjectAware.swift
//  TabPagerPractice
//
//  Created by 松尾淳平 on 2021/03/13.
//

import Foundation
import Swinject

var container = Container()
class SwinjectAware{
    func initialSetup(){
        container.register(Animal.self) { _ in Cat(name: "Mimi") }
        container.register(PetOwner.self) { r in
            PetOwner(pet: r.resolve(Animal.self)!)
        }
    }
}


