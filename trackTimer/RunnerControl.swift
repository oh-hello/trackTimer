//
//  RunnerControl.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/22/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class RunnerControl: UIStackView, UITextFieldDelegate{

    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTextFields(0)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setupTextFields(0)
    }
    
    //MARK: Properties
    var runFields = [UIStackView]()
    
    //MARK: Private Methods
    private func setupTextFields(_ number: Int) {
        // clear any existing text fields
        for view in runFields {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        runFields.removeAll()
       
        for _ in 0..<number {
            //create sub array
            var nameArray = [UITextField]()
            
            //create textfields
            let nameFirst = UITextField()
            nameFirst.delegate = self
            nameFirst.backgroundColor = UIColor.lightGray
            nameFirst.placeholder = "First Name"
            nameFirst.borderStyle = UITextBorderStyle.bezel
            nameFirst.font = UIFont(name: "OpenSans-Regular", size: 20)
            
            let nameLast = UITextField()
            nameLast.delegate = self
            nameLast.backgroundColor = UIColor.lightGray
            nameLast.placeholder = "Last Name"
            nameLast.borderStyle = UITextBorderStyle.bezel
            nameLast.font = UIFont(name: "OpenSans-Regular", size: 20)

            
            //add constraints
            nameFirst.translatesAutoresizingMaskIntoConstraints = false
            nameLast.translatesAutoresizingMaskIntoConstraints = false
        
            //add to array
            nameArray.append(nameFirst)
            nameArray.append(nameLast)
            
            //create horizontal subview
            let nameStack = UIStackView(arrangedSubviews: nameArray)
            nameStack.axis = .horizontal
            nameStack.distribution = .fillEqually
            nameStack.alignment = .fill
            nameStack.spacing = 5
            
            //add stack to runFields
            runFields.append(nameStack)
            
            //add fields to the stack
            nameStack.addArrangedSubview(nameFirst)
            nameStack.addArrangedSubview(nameLast)
            
            //add stack to stack
            addArrangedSubview(nameStack)
        }
    }
    
    //MARK: Public Methods
    
    func updateNumberOfTextfields(_ number: Int){
        self.setupTextFields(number)
    }

}
