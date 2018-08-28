import UIKit
import PlaygroundSupport
import GalleryCore_iOS

/// A Boid.
struct Boid {
 
    // A 0 to 360 value indicating the direction this boid is moving.
    let direction: Double

    /// The current point at which this boid is located.
    let position: CGPoint
    
}


/// The view which can render a BoidLand value on screen.
public class BoidView: ArtView {

    /// The BoidLand instance (constantly replacing it's self when we call the mutating `advanceToNextFrame` method).
    private var boidLand = BoidLand()

    /// Renders the BoidLand value on screen.
    @objc func render() {
        for subview in subviews {
            subview.removeFromSuperview()
        }

        boidLand.advanceToNextFrame()
        print("rendering frame: \(boidLand.frameNumber)")
        
        for boid in boidLand.boids {
            let boidView = UIView(frame: CGRect(x: boid.position.x,
                                            y: boid.position.y,
                                            width: 50,
                                            height: 50))
            let image = UIImage(named: "Triangle", in: Bundle(for: A565zView.self), compatibleWith: nil)
            let imageView = UIImageView(image: image)
            boidView.addSubview(imageView)
            imageView.autolayoutFill(parent: boidView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalTo: boidView.widthAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: boidView.heightAnchor).isActive = true
            imageView.centerXAnchor.constraint(equalTo: boidView.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: boidView.centerYAnchor).isActive = true
            
            boidView.transform = CGAffineTransform(rotationAngle: CGFloat(boid.direction / 360.0))
            
            addSubview(boidView)
        }
    }
    
    public required init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        super.init(frame: frame, artPieceMetadata: artPieceMetadata)
        
        backgroundColor = .white
        
        boidLand.addBoid(at: CGPoint(x: 100, y: 100))
        
        boidLand.addBoid(at: CGPoint(x: 200, y: 100))

        render()
        
        _ = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(render), userInfo: nil, repeats: true)
        
        addSingleTapGestureRecognizer { [weak self] tapGestureRecognizer in
            guard let sself = self else { return }
            sself.boidLand.addBoid(at: tapGestureRecognizer.location(in: sself))
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MyViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cyan
        let metadata = ArtMetadata(id: "boids",
                                   author: "wvdk",
                                   prettyPublishedDate: "tbd",
                                   description: nil,
                                   price: nil,
                                   viewType: BoidView.self,
                                   thumbnail: nil)
        let boidsView = BoidView(frame: CGRect(x: 10, y: 10, width: 300, height: 600), artPieceMetadata: metadata)
        view.addSubview(boidsView)
        boidsView.autolayoutFill(parent: view)
        
        
        
        
    }
    
}

PlaygroundPage.current.liveView = MyViewController()
