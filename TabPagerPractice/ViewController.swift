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
//    override func viewWillLayoutSubviews() {
//        let parameters = [
//            "name": "090xxxx",
//            "password": "password"
//        ]
//
//        LoginAPI.requestPost(parameters: parameters) { (login) in
//            print(login)
//            print("成功")
//        } failureHandler: { (eror) in
//            print("こっちにきたよ")
//            let alert = UIAlertController(title: "a", message: "s", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction.init(title: "a", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            print(eror)
//        }
//        LoginAPI.requetGet(parameters: nil, completion: nil, successHandler: nil, failureHandler: nil)
//    }
    override func viewWillLayoutSubviews() {
        firstly {
            fetch()
        }.done { (e) in
            print(e)
        }.catch { (e) in
            print(e)
        }
    }
    func fetch()->Promise<Void>{
        return Promise { (s) in
            print(s)
        }
    }
}

struct Login: Encodable,Decodable {
    let name: String
    let password: String
}
struct LoginAPIResponse: Encodable,Decodable {
    let title: String
    let status: String
    let message: String
}

protocol APIMixin {
    associatedtype ResponseEntity:Codable
    static var defaultHeader:HTTPHeaders {get}
    static var path:String{get}
    static var keepAlive:Bool{get set}
    static func requestPost(parameters:Dictionary<String, Any>,completion: ((ResponseEntity) -> ())?,successHandler: ((ResponseEntity) -> ())?,failureHandler: ((Error) -> ())?)
}
struct LoginAPI: APIMixin {    
    typealias ResponseEntity = LoginAPIResponse
    static let path = "http://localhost:8080/register"
//    何度もリクエストを送ってしまうことがある。
    static var keepAlive = true
    static let defaultHeader = [
        "Content-Type": "application/json"
    ]
}

extension APIMixin {
//    headerとかしっかり登録しないと怒られるよ。
    static func requestPost(parameters:Dictionary<String, Any>,completion: ((ResponseEntity) -> ())? = nil,successHandler: ((ResponseEntity) -> ())?,failureHandler: ((Error) -> ())?){
        if keepAlive {
            keepAlive = false
            firstly {
                Alamofire.request(Self.path, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: defaultHeader)
                    .responseDecodable(ResponseEntity.self)
            }.done { foo in
                print("っs")
                keepAlive = true
                successHandler!(foo)
            }.map{
                $0.self
            }.catch { error in
                keepAlive = true
                failureHandler!(error)
            }
    }
}

}




