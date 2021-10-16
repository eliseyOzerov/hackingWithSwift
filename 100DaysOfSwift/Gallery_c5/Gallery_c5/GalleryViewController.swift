//
//  ViewController.swift
//  Gallery_c5
//
//  Created by Elisey Ozerov on 16/10/2021.
//

import UIKit

class GalleryViewController: UITableViewController {
    
    var images = [UserImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(takePhoto))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Photo") else { fatalError() }
        cell.textLabel?.text = images[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PhotoDetails") as? PhotoDetailsViewController {
            let userImage = images[indexPath.row]
            
            guard let image = UIImage(contentsOfFile: userImage.path) else {
                fatalError()
            }
            
            vc.image = image
            vc.title = userImage.title
            
            present(vc, animated: true)
        }
    }


}

extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func takePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let img = image.jpegData(compressionQuality: 0.8) {
            try? img.write(to: imagePath)
        }
        
        images.insert(UserImage(title: imageName, path: imagePath.description), at: 0)
        
        let ac = UIAlertController(title: "Name your photo", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            if let text = ac.textFields![0].text {
                self?.images[0].title = text
                self?.tableView.reloadData()
                self?.dismiss(animated: true)
            }
        })
        picker.present(ac, animated: true)
        
    }
    
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct UserImage: Codable {
    var title: String
    var path: String
}
