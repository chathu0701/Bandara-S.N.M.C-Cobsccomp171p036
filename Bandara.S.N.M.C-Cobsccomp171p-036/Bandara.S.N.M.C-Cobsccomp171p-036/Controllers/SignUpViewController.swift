//
//  SignUpViewController.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/19/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Photos

class SignUpViewController: UIViewController {

    @IBOutlet weak var profImg: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var birthdate: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var cinfirmpw: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    // Image access variables
    var profImgPicker: UIImagePickerController!
    var imgURL: String = ""
    var orginalImg = ""
    var dbRef: DatabaseReference!
    
     // Student data variable
    var sName: String = ""
    var sImage: String = ""
    var sAge: Int = 0
    var sbdate: String = ""
    var sphonenum: Int = 0
    var semail: String = ""
    var spassword: String = ""
    var scnfrmpword: String = ""
    
    // wait till to generate the url from firebase to prevent delay
    var imgSet = 0 {
        didSet{
            self.userSignUp()
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
        profImg.isUserInteractionEnabled = true
        profImg.addGestureRecognizer(profImgTap)
        addImage.addTarget(self, action: #selector(openProfImgPicker), for: .touchUpInside)
        
        
        // ------
        self.profImg.layer.cornerRadius = self.profImg.bounds.height / 2
        self.signup.layer.cornerRadius = self.signup.bounds.height / 4
        self.cancel.layer.cornerRadius = self.cancel.bounds.height / 4

        
    }
    
    // start object image picker function
    @objc func openProfImgPicker(_ sender: Any){
        
        self.present(profImgPicker,animated: true,completion:  nil)
        
    }
    
    
    //sign up  save function
    
    func userSignUp(){
        
        
        print("//////////////////////////////////////\(self.semail)////////////////\(self.spassword)//////////")
       
        Auth.auth().createUser(withEmail: self.semail, password: self.spassword) { authResult, error in
            
            print (error)
            print (authResult)
            // ...
        
        
            // get user id as th unique id
            
            if error == nil && authResult != nil {
                guard let userId = Auth.auth().currentUser?.uid else
                {
                    return

                }
            
                self.dbRef = Database.database().reference().child("users/user/\(userId)")



                let user = [
                    "name": self.sName,
                    "age": self.sAge,
                    "birthDate": self.sbdate,
                    "phoneNumber": self.sphonenum,
                    "profileImg": self.imgURL
//                    "password": self.spassword
                ] as [String: Any]

                //save error = errorS
                self.dbRef.setValue(user){errorS, ref in

                    if errorS != nil{
                        let alert = UIAlertController(title: "Sign up failed!", message: errorS?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                        self.present(alert, animated: true, completion: nil)
                    }
                    else{

                        if error != nil{
                            let alert = UIAlertController(title: "Sign up failed!", message: errorS?.localizedDescription, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }

        }
    }
    
    //end sign up
    // Image upload
    func imageUpload()
    {
        
        let storageRef = Storage.storage().reference()
        
        //data in to memory
        guard let data = self.profImg.image!.jpegData(compressionQuality: 0.75) else {return}
        let profImage: UIImage = self.profImg.image!
        print("Profile Image Data:\(profImage)")
        
        //Create a reference to the image path"images/www.jpeg"
        
        let tempReverseRef = storageRef.child("user/\(orginalImg)")
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
    
    
    
    
    @IBAction func addImage(_ sender: Any) {
    }
    @IBAction func signup(_ sender: Any) {
        
        
//        @IBOutlet weak var profImg: UIImageView!
//        @IBOutlet weak var name: UITextField!
//        @IBOutlet weak var age: UITextField!
//        @IBOutlet weak var birthdate: UIDatePicker!
//        @IBOutlet weak var phone: UITextField!
//        @IBOutlet weak var password: UITextField!
//        @IBOutlet weak var cinfirmpw: UITextField!
//        @IBOutlet weak var email: UITextField!
//        @IBOutlet weak var addImage: UIButton!
//        @IBOutlet weak var signup: UIButton!
//        @IBOutlet weak var cancel: UIButton!
        
        self.sName = self.name.text!
        self.sAge = Int(self.age.text!)!
        self.sbdate = self.birthdate.text!
        self.sphonenum = Int(self.phone.text!)!
        self.semail = self.email.text!
        self.spassword = self.password.text!
        self.scnfrmpword = self.cinfirmpw.text!
        
        if self.spassword == self.scnfrmpword {
            self.imageUpload()
        }else{
            print("Confirm password is not valid...!")
        }
        
        //print(sName)
        //self.imageUpload()
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
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

//delegate

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
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
            
            self.profImg.image = imagePicked
            
        }
        //print information of image
        //print("information: "info)
        
        picker.dismiss(animated: true, completion: nil)
        
    }
}
