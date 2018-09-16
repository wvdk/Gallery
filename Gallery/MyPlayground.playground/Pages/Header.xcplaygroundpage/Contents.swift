import UIKit
import PlaygroundSupport
import ArtKit_iOS

class HeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupLineAnimation()
    }
    
    override required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLineAnimation() {
        let line = UIView(frame: CGRect(x: 200, y: 200, width: 2, height: 100))
        line.backgroundColor = .blue
        self.addSubview(line)
        line.loopInSuperview(duplicationCount: 3, with: [
            .rotateByDegrees(0.3),
            .moveHorizontallyWithIncrement(10.0),
            .updateOpacityIncreasingly
        ])
        
        var index = 0.0
        for subview in self.subviews {
            let duration = 10.0 + index
            subview.rotate(duration: duration)            
            index += 2
        }
    }
    
}

let headerView = HeaderView(frame: CGRect(origin: .zero, size: CGSize(width: 600, height: 600)))

PlaygroundPage.current.liveView = headerView
