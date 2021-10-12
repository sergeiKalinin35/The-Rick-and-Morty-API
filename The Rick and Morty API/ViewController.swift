//
//  ViewController.swift
//  The Rick and Morty API
//
//  Created by Sergey on 10.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        setupNavigationBar()
        
        tableView.rowHeight = 100
        fetchRM()
    }
    
    func fetchRM() {
        guard let url = URL(string: URLS.jsonURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) {(data, _, _) in
            guard let data = data else { return }
            
            do {
                self.character = try JSONDecoder().decode(Character.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            
        } .resume()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = .black// темный фон бара
        
        //  navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]//заголовок белый все темное часы и тд
        navigationController?.navigationBar.tintColor = .white // кнопка назад белая
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)// убираем фон бара он берет фон вью
        navigationController?.navigationBar.shadowImage = UIImage() //убираем полоску в баре серую
        
        
        // MARK: - Logo Nav.Bar
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! FullViewController
        detailVC.chracter = sender as? Result
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RMTableViewCell
        let name = character?.results[indexPath.row]
        cell.configure(with: name!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rmVC = character?.results[indexPath.row]
        performSegue(withIdentifier: "RandM", sender: rmVC)
    }
}


  
