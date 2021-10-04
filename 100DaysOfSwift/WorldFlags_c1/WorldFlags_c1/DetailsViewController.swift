//
//  DetailsViewController.swift
//  WorldFlags_c1
//
//  Created by Elisey Ozerov on 04/10/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var imagePath: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
        // Do any additional setup after loading the view.
        if let imagePath = imagePath {
            title = imagePath
            imageView.image = UIImage(named: imagePath)
        }
    }
    
    @objc func share() {
        if let imagePath = imagePath {
            let vc = UIActivityViewController(activityItems: [UIImage(named: imagePath), imagePath], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
