//
//  FullViewController.swift
//  The Rick and Morty API
//
//  Created by Sergey on 10.10.2021.
//

import UIKit

class FullViewController: UIViewController {
    
    
    var chracter: Result!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        navBar()
    }
    
    func navBar() {
        // MARK: - Logo Nav.Bar
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        let navController = navigationController!
        
        let image = UIImage(named: "R M") //Your logo url here
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    
    
    func setupUI() {
        
        
        nameLabel.text = chracter.name
        localLabel.text = chracter.location.name
        originLabel.text = chracter.origin.name
        statusLabel.text = chracter.status
        genderLabel.text = chracter.gender
        speciesLabel.text = chracter.species
        
        //  guard let stringURL = character.results.image else { return }
        
        guard let imageURL = URL(string: chracter.image ?? "") else { return }
        
        guard let imageData = try? Data(contentsOf: imageURL) else { return }
        
        // фоновый режим
        DispatchQueue.main.async {
            
            self.imageView.image = UIImage(data: imageData)
        }
    }
}
    
        

 





