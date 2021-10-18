//
//  PhotoDetailsViewController.swift
//  Gallery_c5
//
//  Created by Elisey Ozerov on 16/10/2021.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var imagePath: URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageData = try? Data(contentsOf: imagePath) {
            imageView.image = UIImage(data: imageData)
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
