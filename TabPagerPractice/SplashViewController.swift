//
//  SplashViewController.swift
//  TabPagerPractice
//
//  Created by 松尾淳平 on 2021/03/14.
//

import UIKit
import RxSwift

class SplashViewController: UIViewController {
//    var imageView: UIImageView!
    var label:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.imageView = UIImageView(frame: CGRectMake(0, 0, 300, 300))
//                //中央寄せ
//                self.imageView.center = self.view.center
//                //画像を設定
//                self.imageView.image = UIImage(named: "splash")
//                //viewに追加
//                self.view.addSubview(self.imageView)
                self.label = UILabel(frame: CGRectMake(0, 0, 300, 300))
                        
                        //画像を設定
                        self.label.text = "EX"
        self.label.font = UIFont(name: "Arial-BoldMT", size: 150)
        self.label.textAlignment = .center
        let aa = CustomView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        aa.center = self.view.center
        aa.backgroundColor = .white
        
//        aa.backgroundColor = .white
        aa.alpha = 1
        aa.addSubview(label)
        
                        //viewに追加
                        self.view.addSubview(aa)
        self.label.textColor = .orange
        self.view.backgroundColor = .white
    }
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
           return CGRect(x: x, y: y, width: width, height: height)
       }
    
    class CustomView:UIView{
        override func draw(_ rect: CGRect) {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: rect.midX + 14, y: rect.maxY - 99))
            path.addLine(to: CGPoint(x: rect.midX + 83, y: rect.minY + 94))
            path.close()
            path.lineWidth = 10
            UIColor.red.setStroke()
            path.stroke()
        }
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
