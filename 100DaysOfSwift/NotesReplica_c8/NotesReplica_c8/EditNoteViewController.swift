//
//  NoteViewController.swift
//  NotesReplica_c8
//
//  Created by Elisey Ozerov on 12/11/2021.
//

import UIKit

class EditNoteViewController: UIViewController {
    var editingNote: Note!
    var otherNotes: [Note]!
    
    var textView: UITextView!
    
    var saveTimer: Timer?
    
    var vc: NotesListViewController!
    
    init(note: Note?, otherNotes: [Note], vc: NotesListViewController) {
        super.init(nibName: nil, bundle: nil)
        self.editingNote = note
        self.otherNotes = otherNotes
        self.vc = vc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Setup Views
extension EditNoteViewController {
    func setupViews() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(presentTextViewOptions))
        ]
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        setupTextView()
    }
    
    func setupTextView() {
        textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        textView.text = editingNote.text
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        ])
        textView.becomeFirstResponder()
    }
}

// MARK: - Selectors
extension EditNoteViewController {
    @objc func presentTextViewOptions() {
       
    }
    
    @objc func stopEditingNote() {
        textView.resignFirstResponder()
    }
    
    func saveNote() {
        print("Save note")
        let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = docUrl.appendingPathComponent("notes")
        if editingNote == nil {
            editingNote = Note()
        }
        editingNote?.lastChanged = Date(timeIntervalSinceNow: 0)
        editingNote?.text = textView.text
        otherNotes.insert(editingNote!, at: 0)
        guard let jsonData = try? JSONEncoder().encode(otherNotes) else {
            fatalError("Failed to encode provided Note array.")
        }
        do {
            try jsonData.write(to: url)
        } catch {
            fatalError("Failed to save data to url [\(url)]. Error: \(error)")
        }
        vc.notes.insert(editingNote!, at: 0)
        vc.tableView.reloadData()
    }
}

// MARK: - TextViewDelegate
extension EditNoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItems?.insert(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(stopEditingNote)), at: 0)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItems?.remove(at: 0)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        saveTimer?.invalidate()
        saveTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] timer in
            self?.saveNote()
        }
    }
}
