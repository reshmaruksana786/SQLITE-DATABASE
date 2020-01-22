//
//  ViewController.swift
//  SQLITE DATABASE
//
//  Created by Syed.Reshma Ruksana on 18/12/19.
//  Copyright © 2019 Syed.Reshma Ruksana. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    
    //declaration of variables

    var path:String!
    var dbConnection:Connection!

    
    var allContactButton = [UIButton]()
           
    var allButtons = [UIButton]()
       
       
          static var firstName = [String]()
          static var lastName = [String]()
          static var mailID = [String]()
          static var mobileNum = [String]()
          static var id = [Int]()
    
       
          static var isContactButtonTapped = false
       
          static var contactButtonTapped:Int!
       

    @IBOutlet weak var stackView1: UIStackView!
    
    
    @IBOutlet weak var stackView2: UIStackView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        stackView1.spacing = 30
        
        stackView2.spacing = 30

        
        database()
        // Do any additional setup after loading the view.
    }


    //conenction for database

    func database()
    {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
               
               do {
           
                   dbConnection = try Connection("\(path)/db.sqlite3")
                   print(path)


               }catch {
                   print("Unable to Connect/Open database")
                   
        }
    }
    
    //displaying and fetching data

    override func viewWillAppear(_ animated: Bool) {
        
        
        for (x,y) in zip(allContactButton, allButtons)
        {
            x.removeFromSuperview()
            y.removeFromSuperview()
        
        }
              
            allContactButton = [UIButton]()
                
             allButtons = [UIButton]()
        
        do{
            let x = try! dbConnection!.run("SELECT * FROM CONTACTS")

            for(i,row) in x.enumerated()
            {
                var text = String()
                for(index,name) in x.columnNames.enumerated()
                {
                    print("\(name):\(row[index]!)")
                    
                    if(name == "FirstName")
                    {
                        ViewController.firstName.append(row[index]! as! String)
                        text = (row[index]! as! String)
                    }
                    else if(name == "lastName")
                    {
                        ViewController.lastName.append(row[index]! as! String)

                        text += " " + (row[index]! as! String)
                    }else if(name == "Mailid")
                    {
                        ViewController.mailID.append(row[index]! as! String)
                        text += " " + (row[index]! as! String)
                    }else if(name == "MobileNum")
                    {
                        ViewController.mobileNum.append(row[index]! as! String)
                        text += " " + (row[index]! as! String)
                    }else if(name == "ID")
                    {
                        ViewController.id.append(Int(row[index]! as! Int64))
                    }
                    
                }
                
                //button for details and update

                let contactButton = UIButton()
                contactButton.setTitle(text, for: UIControl.State.normal)
                contactButton.backgroundColor = .red
                contactButton.titleLabel?.numberOfLines = 0
                contactButton.addTarget(self, action: #selector(onButtonContactTap(button: )), for: UIControl.Event.touchUpInside)
                contactButton.tag = i
                contactButton.translatesAutoresizingMaskIntoConstraints = false
                contactButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
                allContactButton.append(contactButton)
                stackView1.addArrangedSubview(contactButton)
                
                
                //delete button

                let button = UIButton()
                button.setTitle("DELETE", for: UIControl.State.normal)
                button.backgroundColor = .green
                button.titleLabel?.numberOfLines = 0
//                button.layer.cornerRadius = 80
                button.setTitleColor(UIColor.black, for: UIControl.State.normal)
                button.tag = i
                button.addTarget(self, action: #selector(button_tap), for: UIControl.Event.touchUpInside)
                
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: 90).isActive = true
                allButtons.append(button)
                stackView2.addArrangedSubview(button)
                
            }
            
            
        }
        catch{
            print("not connected")
        }

        
    }
    
    
    //update button Event handler
    @objc func onButtonContactTap(button:UIButton)
    {
    
        ViewController.isContactButtonTapped = true
        
        ViewController.contactButtonTapped = button.tag
        
        
        let targetVC = self.storyboard?.instantiateViewController(identifier: "secondVC") as! SecondViewController
        
        for (button1,button2) in zip(allContactButton,allButtons)
        {
            button1.removeFromSuperview()
            
            button2.removeFromSuperview()
        }
        
        
        allContactButton = [UIButton]()
        allButtons = [UIButton]()
        
    
        self.navigationController?.pushViewController(targetVC, animated: true)
            
    }
    
    //delete button event handler

     @objc func button_tap(button:UIButton)
{
    
    print("Delete Button Tag", button.tag)
               
               button.removeFromSuperview()
               
               allContactButton[button.tag].removeFromSuperview()
               
               
       do
        {
           print("data : ",ViewController.id[button.tag])
            let query = "DELETE FROM CONTACTS WHERE ID = \(ViewController.id[button.tag])"
                           
            
            try dbConnection.run(query)
            
            
            print(query)
         }
        catch
        {
            print("data not deleted")
        }

                      
           }
        
        
    
    //add contact button

    @IBAction func onContactBtnTap(_ sender: Any) {
        
     for (a,b) in zip(allContactButton, allButtons)
    {
        a.removeFromSuperview()
        b.removeFromSuperview()
    
    }
          
        allContactButton = [UIButton]()
            
         allButtons = [UIButton]()
        
        
        let secondViewController = storyboard?.instantiateViewController(withIdentifier: "secondVC") as! SecondViewController
           
           navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
    

}
    
    


