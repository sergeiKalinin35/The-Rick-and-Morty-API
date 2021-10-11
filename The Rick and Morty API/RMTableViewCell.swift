//
//  RMTableViewCell.swift
//  The Rick and Morty API
//
//  Created by Sergey on 10.10.2021.
//

import UIKit

class RMTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var imageRM: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var episodLabel: UILabel!
    
    
    func configure(with char: Result) {
        
        nameLabel.text = char.name
        episodLabel.text = char.species
       
        
        
        DispatchQueue.global().async {
            
          //  guard let stringURL = character.results.image else { return }
            
            guard let imageURL = URL(string: char.image ?? "" ) else { return }

            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            // фоновый режим
            DispatchQueue.main.async {
                
                self.imageRM.image = UIImage(data: imageData)
                
                
            }
        }
    
        
       }
    
}



