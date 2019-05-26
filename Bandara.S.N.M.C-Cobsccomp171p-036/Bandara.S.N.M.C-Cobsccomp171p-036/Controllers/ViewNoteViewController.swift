//
//  ViewNoteViewController.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/26/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class ViewNoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    
    @IBOutlet weak var noteview: UITableView!
    
    var note:[String] = []
    var noteSelected: Int = -1
    var noteAdd: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.noteview.dataSource = self
        self.noteview.delegate = self
        
        self.title = "HOME WORK"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        load()
        // Do any additional setup after loading the view.
    }
    

    @objc func addNote() {
        
        if noteview.isEditing {
            
            return
        }
        
        let noteName: String = ""
        note.insert(noteName, at: 0)
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        noteview.insertRows(at: [indexPath], with: .automatic)
        noteview.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "notepath", sender: nil)
        
        
    }
    
    func save(){
        
        UserDefaults.standard.set(note, forKey: "dt")
    }
    
    func load(){
        
        if let loadData = UserDefaults.standard.value(forKey: "dt") as? [String] {
            
            note = loadData
            noteview.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return note.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteView")!
        print("Cell : \(note)")
        cell.textLabel?.text = note[indexPath.row]
        print("Cell : \(note[indexPath.row])")
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        noteview.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        note.remove(at: indexPath.row)
        noteview.deleteRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "notepath", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addNote: NoteAddViewController = segue.destination as! NoteAddViewController
        noteSelected = noteview.indexPathForSelectedRow!.row
        addNote.NoteAddViewCon = self
        addNote.setTexts(t: note[noteSelected])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if noteSelected == -1{
            return
        }
        
        if noteAdd.isEmpty {
            return
        }
        note[noteSelected] = noteAdd
        
        if noteAdd == "" {
            
            note.remove(at: noteSelected)
            
           
        }
        noteview.reloadData()
        save()
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
