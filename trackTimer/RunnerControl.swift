//
//  RunnerControl.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/22/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class RunnerControl: UIStackView {

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
    var runFields = [UITextField]()
    
    //MARK: Private Methods
    private func setupTextFields(_ number: Int) {
        // clear any existing text fields
        for text in runFields {
            removeArrangedSubview(text)
            text.removeFromSuperview()
        }
        runFields.removeAll()
       
        for _ in 0..<number {
            //create textfields
            let nameFirst = UITextField()
            nameFirst.backgroundColor = UIColor.lightGray
            nameFirst.placeholder = "First Name"
            nameFirst.borderStyle = UITextBorderStyle.bezel
            
            //add constraints
            nameFirst.translatesAutoresizingMaskIntoConstraints = true
            nameFirst.heightAnchor.constraint(equalToConstant: 50).isActive = true
            nameFirst.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
            //add field to array 
            runFields.append(nameFirst)
        
            //add field to the stack
            addArrangedSubview(nameFirst)
        }
    }
    
    //MARK: Public Methods
    
    func updateNumberOfTextfields(_ number: Int){
        self.setupTextFields(number)
    }

}
