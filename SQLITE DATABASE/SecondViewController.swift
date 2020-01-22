//
//  SecondViewController.swift
//  SQLITE DATABASE
//
//  Created by Syed.Reshma Ruksana on 18/12/19.
//  Copyright © 2019 Syed.Reshma Ruksana. All rights reserved.
//

import UIKit
import SQLite

class SecondViewController: UIViewController {

    var values = [String]()
    
    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var mailIDTF: UITextField!
    
    @IBOutlet weak var mobileNumTF: UITextField!
    
    
    
    var path:String!
    var dbConnection:Connection!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTF.keyboardType = .asciiCapable
        lastNameTF.keyboardType = .asciiCapable
        mailIDTF.keyboardType = .emailAddress
        mobileNumTF.keyboardType = .namePhonePad
        
        if(ViewController.isContactButtonTapped)
        {
            firstNameTF.text = ViewController.firstName[ViewController.contactButtonTapped]
            
            lastNameTF.text = ViewController.lastName[ViewController.contactButtonTapped]
            mailIDTF.text = ViewController.mailID[ViewController.contactButtonTapped]
            mobileNumTF.text = ViewController.mobileNum[ViewController.contactButtonTapped]
        }
        
        
        //getting path and creating database and table

        
        path = NSSearchPathForDirectoriesInDomains(
                   .documentDirectory, .userDomainMask, true
               ).first!

               do
               {
                   dbConnection = try Connection("\(path!)/db.sqlite3")
                   print(path!)

                   
                   try dbConnection.run("create table IF NOT EXISTS CONTACTS(ID INTEGER PRIMARY KEY AUTOINCREMENT,FirstName,Lastname,age,email,phonenumber)")
                   
               }
               catch
               {
                   print("Connection not Established")
               }

  }
    
//SAVE BUTTON FUNCTION
    @IBAction func saveBtn(_ sender: UIButton) {
        if(ViewController.isContactButtonTapped)
               {
                
                do
                       {
                        try dbConnection!.run("UPDATE CONTACTS SET firstName = '\(firstNameTF.text!)', lastName = '\(lastNameTF.text!)' , mailID = '\(mailIDTF.text!)' WHERE mobileNumber = '\(mobileNumTF.text!)'")
                        print("data updated")
                    }
                    catch
                    {
                    print("data not updated")
                    }
                }
                else
                {
        do{
                 
            try dbConnection!.run("INSERT INTO CONTACTS(FirstName,lastName,Mailid,MobileNum) VALUES (?,?,?,?)", firstNameTF.text!,lastNameTF.text!,mailIDTF.text!,mobileNumTF.text!)
            
            
            firstNameTF.text = " "
            lastNameTF.text = " "
            mailIDTF.text = " "
            mobileNumTF.text = " "

                 
         }
        catch
        {
         print("unable to catch")
         }
        
        }
      
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
