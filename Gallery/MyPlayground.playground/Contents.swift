import UIKit
import PlaygroundSupport
import GalleryCore_iOS

public class BoidsView: ArtView {
    
    public required init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        super.init(frame: frame, artPieceMetadata: artPieceMetadata)
        
        backgroundColor = .white
        
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
                                   viewType: BoidsView.self,
                                   thumbnail: nil)
        let boidsView = BoidsView(frame: CGRect(x: 10, y: 10, width: 300, height: 600), artPieceMetadata: metadata)
        view.addSubview(boidsView)
        boidsView.autolayoutFill(parent: view)
        
        
        
        
    }
    
}

PlaygroundPage.current.liveView = MyViewController()
print("ran playground")
