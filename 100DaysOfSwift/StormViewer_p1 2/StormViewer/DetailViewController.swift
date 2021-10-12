//
//  DetailViewController.swift
//  Project1
//
//  Created by Elisey Ozerov on 29/09/2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var totalImages: Int?
    var selectedIndex: Int?
    var selectedTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let total = totalImages, let selected = selectedIndex {
            title = "Image \(selected) of \(total)"
        }
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))

        // Do any additional setup after loading the view.
        if let imageToLoad = selectedTitle {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func share() {
        let vc = UIActivityViewController(activityItems: ["You should try out this app I'm using lmao"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
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
