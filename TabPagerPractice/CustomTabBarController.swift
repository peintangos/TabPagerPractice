
//
//  CustomTabBarController.swift
//  TabPagerPractice
//
//  Created by 松尾淳平 on 2021/03/14.
//

import UIKit
import PromiseKit
import Alamofire

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var viewControllers = [UIViewController]()
        let first = FirstViewControler()
        first.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        let second = SecondViewController()
        second.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        viewControllers.append(first)
        viewControllers.append(second)
        self.viewControllers = viewControllers.map{ UINavigationController(rootViewController: $0)}
        self.setViewControllers(viewControllers, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
class FirstViewControler:UIViewController{
    override func viewWillLayoutSubviews() {
        print("d")
        fetch2().done {
            print($0)
        }.catch {
            print($0)
        }
        fetch().done {
            print($0)
        }.catch {
            print($0)
        }
    }
    func fetch() -> Promise<[LoginMessage]>{
        let defaultHeader = [
            "Content-Type": "application/json"
        ]
        return Promise { seal in
            Alamofire.request("http://localhost:8080/allList", method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: defaultHeader).responseJSON { (data) in
                switch data.result {
                case .success:
                    let decoder = JSONDecoder()
                        do {
                            let decodedData = try decoder.decode([LoginMessage].self, from: data.data!)
                            seal.fulfill(decodedData)
                        } catch {
                            print("aa")
                            print(error)
                        }
                case .failure(let error):
                seal.reject(error)
                }
            }
        }
}

    func fetch2()-> Promise<LoginRsopnse>{
        let defaultHeader = [
            "Content-Type": "application/json"
        ]
        return Promise { seal in
            Alamofire.request("http://localhost:8080/allList2", method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: defaultHeader).responseJSON { (data) in
                switch data.result {
                case .success:
                    let decoder = JSONDecoder()
                        do {
                            let decodedData = try decoder.decode(LoginRsopnse.self, from: data.data!)
                            seal.fulfill(decodedData)
                        } catch {
                            print("aa")
                            print(error)
                        }
                case .failure(let error):
                seal.reject(error)
                }
            }
        }
    }
}
struct LoginMessage: Encodable,Decodable{
    let name:String
    let password:String
}
struct LoginRsopnse:Decodable,Encodable{
    let title:String
    let users:[User]
    struct User:Decodable,Encodable {
        let name:String
        let password:String
    }
}




class SecondViewController:UIViewController{
    
}
