//
//  AddStudentHomeViewController.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/18/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import  Firebase
import FirebaseAuth
import Photos

class AddStudentHomeViewController: UIViewController {

    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var AddProfileImage: UIButton!
    @IBOutlet weak var FName: UITextField!
    @IBOutlet weak var LName: UITextField!
    @IBOutlet weak var City: UITextField!
    @IBOutlet weak var PhoneNumber: UITextField!
    @IBOutlet weak var FBURL: UITextField!
    @IBOutlet weak var Save: UIButton!
    @IBOutlet weak var Clear: UIButton!
    
    // Image access variables
    var profImgPicker: UIImagePickerController!
    var imgURL: String = ""
    var orginalImg = ""
    var dbRef: DatabaseReference!
    
    // Student data variable
    var fName: String = ""
    var lName: String = ""
    var city: String = ""
    var fbURL: String = ""
    var phoneNumber: Int = 0
    
    // wait till to generate the url from firebase to prevent delay 
    var imgSet = 0 {
        didSet{
            self.StudentDataSave()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add profile image picker
        profImgPicker = UIImagePickerController()
        profImgPicker.allowsEditing = true
        profImgPicker.sourceType = .photoLibrary
        profImgPicker.delegate = self
        //end
        
        //self.profileImage = UIImage.init(named: "logo")

        //image view configuration
        let profImgTap = UITapGestureRecognizer(target: self, action: #selector(openProfImgPicker))
        ProfileImage.isUserInteractionEnabled = true
        ProfileImage.addGestureRecognizer(profImgTap)
        AddProfileImage.addTarget(self, action: #selector(openProfImgPicker), for: .touchUpInside)
        
        self.ProfileImage.layer.cornerRadius = self.ProfileImage.bounds.height / 2
        self.Save.layer.cornerRadius = self.Save.bounds.height / 4
        self.Clear.layer.cornerRadius = self.Clear.bounds.height / 4
       
    }
    
    // start object image picker function
    @objc func openProfImgPicker(_ sender: Any){
        
        self.present(profImgPicker,animated: true,completion:  nil)
        
    }
    
    
    // Image upload
    func imageUpload()
    {
        
        let storageRef = Storage.storage().reference()
        
        //data in to memory
        guard let data = self.ProfileImage.image!.jpegData(compressionQuality: 0.75) else {return}
        let profImage: UIImage = self.ProfileImage.image!
        print("Profile Image Data:\(profImage)")
        
        //Create a reference to the image path"images/www.jpeg"
    
        let tempReverseRef = storageRef.child("images/\(orginalImg)")
        //  / root
        //  \placeholder variable
        
        
        //upload the file to the path "images/www.jpg"
        let uploadImg = tempReverseRef.putData(data,metadata: nil){
            (metadata,error) in
            guard let metadata = metadata else{
                // Error occured!!!!!!
                return
            }
            
            print("MetaData: \(metadata)")
            // Metadata contains file metadata such as size, content-type
            
            let size = metadata.size
            
            //You can also access to download URL after upload
            let url = tempReverseRef.downloadURL{(url, error)in
                
                guard let downloadURL = url else{
                    
                    //print("Erro Image:\(error)")
                    return
                    
                }
                
                self.imgURL = downloadURL.absoluteString
                
                if self.imgURL != ""{self.imgSet = 1}
                print("Download Image URL\(self.imgURL)")
            }
            
            
        }
        
    }
    
    //End Image Upload
    
    // Save Function
    
    func StudentDataSave(){
        
        dbRef = Database.database().reference().child("StudentDB/Student").childByAutoId()
        
        let student = [
            "firstName": self.fName,
            "lastName": self.lName,
            "ciy": self.city,
            "fbProfile": self.fbURL,
            "profUrl": self.imgURL,
            "tel": self.phoneNumber
            ] as [String: Any]
       
        print(student)
        
        self.dbRef!.setValue(student){error,ref in
            
            if error != nil{
                
                let alert = UIAlertController(title: "Failed to Save", message: error?.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            } else{
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //End Save Function
    
    
    
    @IBAction func AddProfileImage(_ sender: Any) {
    }
    @IBAction func Save(_ sender: Any) {
      //
        self.fName = self.FName.text!
        self.lName = self.LName.text!
        self.city = self.City.text!
        self.fbURL = self.FBURL.text!
        
        // to convert to int
        self.phoneNumber = Int(self.PhoneNumber.text!)!
        
        
        self.imageUpload()
        print(fName, lName, city, fbURL, phoneNumber)
    }
    @IBAction func Clear(_ sender: Any) {
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

// delegates

extension AddStudentHomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func  imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let profImgURL = info[UIImagePickerController.InfoKey.imageURL]as? URL{
            
            let profImageName = profImgURL.lastPathComponent
            print("Image Name: \(profImageName)")
            self.orginalImg = profImageName
            let imageExtension = profImgURL.pathExtension
            print("Image Name: \(imageExtension)")
            
        }
        
        if let imagePicked = info[UIImagePickerController.InfoKey.editedImage]as? UIImage{
            
            self.ProfileImage.image = imagePicked
            
        }
        //print information of image
        //print("information: "info)
        
        picker.dismiss(animated: true, completion: nil)
        
    }
}
