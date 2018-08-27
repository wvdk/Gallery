import UIKit
import PlaygroundSupport
import GalleryCore_iOS


struct Obstical {
    
    // position
    // radius
    
}

struct Boid {
 
    // direction
    // position
    
    // Optional:
    // size
    // color
    // created on frame number
    
}

/// A struct which holds the current frame state of a Boid enviroment - and can advance that state one frame at a time based on *the rules*.
struct BoidLand {
    
    /// An ever increasing count of the frames rendered so far (in practice this means the number of times `advanceToNextFrame()` has been called).
    var frameNumber: Int = 0
    
    /// Updates the properties of each element in Boid Land by one from according to *the rules*.
    mutating func advanceToNextFrame() {
        frameNumber += 1
        
    }
    
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
        
        let boid = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        let image = UIImage(named: "Triangle", in: Bundle(for: A565zView.self), compatibleWith: nil)
        let imageView = UIImageView(image: image)
        boid.addSubview(imageView)
        imageView.autolayoutFill(parent: boid)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: boid.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: boid.heightAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: boid.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: boid.centerYAnchor).isActive = true

        addSubview(boid)
    }
    
    public required init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        super.init(frame: frame, artPieceMetadata: artPieceMetadata)
        
        backgroundColor = .white
        
        render()
        
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(render), userInfo: nil, repeats: true)
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
