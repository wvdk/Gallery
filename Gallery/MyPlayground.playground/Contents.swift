//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import ArtKit_iOS


class MyViewController : UIViewController {
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let box = UIView()
        box.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        box.backgroundColor = .red
        
        view.addSubview(box)
        
//        box.loopInSuperview(duplicationCount: 3, moveHorizontallyWithIncrement: 60, moveVerticallyWithIncrement: -4)
        box.loopInSuperview(duplicationCount: 3, with: [.moveHorizontallyWithIncrement(60), .rotateByDegrees(0.3)])
        
    }
    
    
    
    
    
    
    
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
        
        
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
