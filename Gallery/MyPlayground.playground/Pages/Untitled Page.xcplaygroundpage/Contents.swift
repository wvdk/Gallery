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
        
        box.loopInSuperview(duplicationCount: 3, with: [.moveHorizontallyWithIncrement(60), .rotateByDegrees(0.3)])
        
        let line = UIView(frame: CGRect(x: 200, y: 200, width: 1, height: 200))
        view.addSubview(line)
        line.backgroundColor = .blue
        line.loopInSuperview(duplicationCount: 2, with: [.rotateByDegrees(0.35), .updateOpacityRandomly])
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

PlaygroundPage.current.liveView = MyViewController()
