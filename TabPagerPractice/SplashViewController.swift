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
    var aa:UIView!
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
        aa = CustomView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        aa.center = self.view.center
        aa.backgroundColor = .white
        
//        aa.backgroundColor = .white
        aa.alpha = 1
        aa.addSubview(label)
        
                        //viewに追加
                        self.view.addSubview(aa)
        self.label.textColor = .orange
        self.view.backgroundColor = .white
        
        UIView.animate(withDuration: 1,
                       delay: 1.1,
                               options: UIView.AnimationOptions.curveEaseOut,
                               animations: { () in
                                self.aa.transform = CGAffineTransform(scaleX: 8.0, y: 8.0)
                                self.aa.alpha = 0
                }, completion: { (Bool) in
                    //で、アニメーションが終わったらimageViewを消す
                    self.aa.removeFromSuperview()
                })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let s = CustomTabBarController()
            s.modalPresentationStyle = .fullScreen
            s.modalTransitionStyle = .crossDissolve
            self.present(s, animated: true, completion: nil)
        }

    }
    weak var shapeLayer: CAShapeLayer?
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
           return CGRect(x: x, y: y, width: width, height: height)
       }
    
    class CustomView:UIView{
        override func draw(_ rect: CGRect) {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 198.5, y: 150))
            path.addLine(to: CGPoint(x: 302, y: -3))
            path.close()
            path.lineWidth = 24
            UIColor.red.setStroke()
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor = UIColor.orange.cgColor
            shapeLayer.lineWidth = 24
            shapeLayer.path = path.cgPath

            self.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 1
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            let path2 = UIBezierPath()
            path2.move(to: CGPoint(x: 198.5, y: 150))
            path2.addLine(to: CGPoint(x: 95, y: 303))
            path2.close()
            path2.lineWidth = 24
            UIColor.red.setStroke()
            
            let shapeLayer2 = CAShapeLayer()
            shapeLayer2.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer2.strokeColor = UIColor.orange.cgColor
            shapeLayer2.lineWidth = 24
            shapeLayer2.path = path2.cgPath

            // animate it

            self.layer.addSublayer(shapeLayer2)
            let animation2 = CABasicAnimation(keyPath: "strokeEnd")
            animation2.fromValue = 0
            animation2.duration = 1
            shapeLayer2.add(animation2, forKey: "MyAnimation2")

        }
        }    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


