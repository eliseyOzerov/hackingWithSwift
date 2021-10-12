//
//  ViewController.swift
//  Project1
//
//  Created by Elisey Ozerov on 28/09/2021.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after lo ading the view.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        DispatchQueue.global().async { [ weak self ] in
            let items = try! fm.contentsOfDirectory(atPath: path)
            for item in items {
                if item.hasPrefix("nssl") {
                    // this is a picture to load
                    self?.pictures.append(item)
                }
            }
            
            DispatchQueue.main.async { [ weak self ] in
                self?.pictures.sort { $0 < $1 }
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StormCell", for: indexPath) as? StormCell else {
            fatalError("Couldn't load a StormCell")
        }
        let title = pictures[indexPath.item]
        cell.title?.text = title
        cell.image.image = UIImage(named: title)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.totalImages = pictures.count
            vc.selectedIndex = indexPath.row
            vc.selectedTitle = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

