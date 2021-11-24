//
//  ViewController.swift
//  SelfieShare_p25
//
//  Created by Elisey Ozerov on 24/11/2021.
//

import UIKit
import MultipeerConnectivity

// connection drops when having the "didReceiveCertificate" callback
// MCAdvertiserAssistant doesn't show the invitation popup, had to use MCNearbyServiceAdvertiser

class ViewController: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,
                      MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Invitation Received"

        let ac = UIAlertController(title: appName, message: "'\(peerID.displayName)' wants to connect.", preferredStyle: .alert)
        let declineAction = UIAlertAction(title: "Decline", style: .cancel) { [weak self] _ in invitationHandler(false, self?.mcSession) }
        let acceptAction = UIAlertAction(title: "Accept", style: .default) { [weak self] _ in invitationHandler(true, self?.mcSession) }
        
        ac.addAction(declineAction)
        ac.addAction(acceptAction)
        
        present(ac, animated: true)
    }
    
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            print("Not Connected: \(peerID.displayName)")
        case .connecting:
            print("Connecting: \(peerID.displayName)")
        case .connected:
            print("Connected: \(peerID.displayName)")
            
        @unknown default:
            print("Unknown state received: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async { [weak self] in
            if let image = UIImage(data: data) {
                self?.images.insert(image, at: 0)
                self?.collectionView.reloadData()
            }
        }
    }
    
    
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("streamName")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print(peerID.displayName)
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print(peerID.displayName)
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    var images = [UIImage]()
    
    var peerId = MCPeerID(displayName: UIDevice.current.name)
    var mcSession: MCSession?
    var mcNearbyServiceAdvertiser: MCNearbyServiceAdvertiser?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SelfieShare"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        
        mcSession = MCSession(peer: peerId, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }
    
    func startHosting(action: UIAlertAction) {
        mcNearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerId, discoveryInfo: nil, serviceType: "eoz-selfieShare")
        mcNearbyServiceAdvertiser?.delegate = self
        mcNearbyServiceAdvertiser?.startAdvertisingPeer()
    }
    
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        let mcBrowser = MCBrowserViewController(serviceType: "eoz-selfieShare", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageView", for: indexPath)
        
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.item]
        }
        
        return cell
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        
        images.insert(image, at: 0)
        collectionView.reloadData()
        
        guard let mcSession = mcSession else { return }
        
        if !mcSession.connectedPeers.isEmpty {
            if let imageData = image.pngData() {
                do {
                    try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .default))
                    present(ac, animated: true)
                }
            }
        }

    }
    
    @objc func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    

}

