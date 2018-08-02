//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import ArtKit_iOS

extension UIView {
    
    /// The transformation options you can pass in a UIView loopInSuperView function. Uses associated values for specifiying the amounts of transformation you'd like (usually in points, if not otherwise specified).
    enum LooperOptions {
        
        /// Move each view horizontally from the previous view by the provided CGFloat.
        case moveHorizontallyWithIncrement(CGFloat)
        
        /// Move each view vertically from the previous view by the provided CGFLoat.
        case moveVerticallyWithIncrement(CGFloat)
        
    }
    
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
    
    func loopInSuperview(duplicationCount: Int, moveHorizontallyWithIncrement xMovement: Int = 0, moveVerticallyWithIncrement yMovement: Int = 0) {
        /// We start with an index of 2 - which seems weird but if very deliberate. If we use a starting index of 0, then multiply the origin points by that 0 index, it would bring the new view to the top left corner. Similarly if we start with 1, it will cover the original view.
        let startingIndex = 2
        let endingIndex = duplicationCount + startingIndex
        for i in startingIndex..<endingIndex {
            let newView = self.copyView()
            
            
            // Move
            newView.frame = CGRect(x: frame.origin.x + CGFloat((i - 1) * xMovement),
                                   y: frame.origin.y + CGFloat((i - 1) * yMovement),
                                   width: frame.width,
                                   height: frame.height)
            
            
            
            self.superview?.addSubview(newView)
            newView.backgroundColor = .blue
        }        
        
    }
    
    func loopInSuperview(duplicationCount: Int, with options: [LooperOptions]) {
        /// We start with an index of 2 - which seems weird but if very deliberate. If we use a starting index of 0, then multiply the origin points by that 0 index, it would bring the new view to the top left corner. Similarly if we start with 1, it will cover the original view.
        let startingIndex = 2
        let endingIndex = duplicationCount + startingIndex
        for i in startingIndex..<endingIndex {
            // Duplicate original view
            let newView = self.copyView()
            self.superview?.addSubview(newView)
            newView.backgroundColor = .blue

            // Apply transoforms based on options
            for option in options {
                switch option {
                case .moveVerticallyWithIncrement(let yMovement):
                    let newTransform = CGAffineTransform(translationX: 0, y: yMovement * CGFloat(i - 1))
                    newView.transform = newView.transform.concatenating(newTransform)
                case .moveHorizontallyWithIncrement(let xMovement):
                    let newTransform = CGAffineTransform(translationX: xMovement * CGFloat(i - 1), y: 0)
                    newView.transform = newView.transform.concatenating(newTransform)
                }
            }
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
        
//        box.loopInSuperview(duplicationCount: 3, moveHorizontallyWithIncrement: 60, moveVerticallyWithIncrement: -4)
        box.loopInSuperview(duplicationCount: 3, with: [.moveHorizontallyWithIncrement(60), .moveVerticallyWithIncrement(-4), .moveHorizontallyWithIncrement(60)])
        
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
