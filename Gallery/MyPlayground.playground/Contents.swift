//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import ArtKit_iOS

extension UIView {
    
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
    
    func loopInSuperview() {
        for i in 2...5 {
            // We start with an index of 2 - which seems weird but if very deliberate. If we use a starting index of 0, then multiply the origin points by that 0 index, it would bring the new view to the top left corner. Similarly if we start with 1, it will cover the original view.
            
            let newView = self.copyView()
            newView.frame = CGRect(x: frame.origin.x * CGFloat(i), y: frame.origin.y * CGFloat(i), width: frame.width, height: frame.height)
            
            self.superview?.addSubview(newView)
            newView.backgroundColor = .blue
        }        
        
    }
    
    
    
}



class MyViewController : UIViewController {
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let box = UIView()
        box.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        box.backgroundColor = .red
        
        view.addSubview(box)
        
        box.loopInSuperview()
        
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
