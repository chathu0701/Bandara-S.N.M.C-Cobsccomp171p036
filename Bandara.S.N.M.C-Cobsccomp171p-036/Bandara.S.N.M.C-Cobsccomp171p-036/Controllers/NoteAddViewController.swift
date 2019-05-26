//
//  NoteAddViewController.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/26/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class NoteAddViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var text: String = ""
    var NoteAddViewCon: ViewNoteViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = text
        // Do any additional setup after loading the view.
    }
    
    
    func setTexts(t: String){
        
        text = t
        if isViewLoaded{
            
            textView.text = t
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NoteAddViewCon.noteAdd = textView.text!
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
