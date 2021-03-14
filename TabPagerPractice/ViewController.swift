//
//  ViewController.swift
//  TabPagerPractice
//
//  Created by 松尾淳平 on 2021/03/13.
//

import UIKit
import Alamofire
import PromiseKit

class ViewController: UIViewController {
    
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        SwinjectAware().initialSetup()
        var person:Person = container.resolve(PetOwner.self)!
        print(person.eat())
    }
    override func viewWillAppear(_ animated: Bool) {
        let parameters: [String: String] = [
            "name": "bar",
            "password": "a"
        ]
        
//        firstly {
//            Alamofire
//                .request("http://localhost:8080", method: .post, parameters: parameters)
//                .responseDecodable(Response.self)
//        }.done { foo in
//
//            print("成功したらここに来るよ\(foo)")
//        }.catch { error in
//            print("失敗したらここに来るよ\(error)")
//        }
            LoginAPI.request(parameters: parameters) { (login) in
                print(login)
            } failureHandler: { (eror) in
                print(eror)
            }
}
}

struct Login: Encodable,Decodable {
    let name: String
    let password: String
}
struct Response: Encodable,Decodable {
    let error: String
    let status: String
    let message: String
}

protocol APIMixin {
    associatedtype ResponseEntity:Codable
    static var path:String{get}
    static func request(parameters:Dictionary<String, Any>,completion: ((ResponseEntity) -> ())?,successHandler: ((ResponseEntity) -> ())?,failureHandler: ((Error) -> ())?)
}
struct LoginAPI: APIMixin {
    typealias ResponseEntity = Response
    static let path = "http://localhost:8080/login"
}

extension APIMixin {
    static func request(parameters:Dictionary<String, Any>,completion: ((ResponseEntity) -> ())? = nil,successHandler: ((ResponseEntity) -> ())?,failureHandler: ((Error) -> ())?){
        firstly {
            Alamofire
                .request(Self.path, method: .post, parameters: parameters)
                .responseDecodable(ResponseEntity.self)
        }.done { foo in
            successHandler!(foo)
        }.catch { error in
            failureHandler!(error)
        }
        Alamofire.request(Self.path).response(completionHandler: { response in
            guard let data = response.data,
            let entity = try? JSONDecoder().decode(ResponseEntity.self, from: data) else {
            return
        }
            completion?(entity)
    })
}
}




