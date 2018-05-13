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
    var allNameFields = [[UITextField]]()
    
    //MARK: Private Methods
    private func setupTextFields(_ number: Int) {
        if number < runFields.count{
            for x in stride(from: runFields.count, through: number + 1, by: -1){
                print("First: \(runFields.count), \(number), \(allNameFields.count)")
                removeArrangedSubview(runFields[x - 1])
                runFields[x-1].removeFromSuperview()
                runFields.remove(at: x - 1)
                allNameFields.remove(at: x - 1)
                print("Second: \(runFields.count), \(number), \(allNameFields.count)")
            }
        }
        
        else {
            for _ in runFields.count..<number {
                //create sub array
                var nameArray = [UITextField]()
            
                //create textfields
                let nameFirst = UITextField()
                nameFirst.delegate = self
                nameFirst.backgroundColor = UIColor.lightGray
                nameFirst.placeholder = "First Name"
                nameFirst.borderStyle = UITextBorderStyle.bezel
                nameFirst.font = UIFont(name: "OpenSans-Regular", size: 20)
                nameFirst.autocorrectionType = .no
            
                let nameLast = UITextField()
                nameLast.delegate = self
                nameLast.backgroundColor = UIColor.lightGray
                nameLast.placeholder = "Last Name"
                nameLast.borderStyle = UITextBorderStyle.bezel
                nameLast.font = UIFont(name: "OpenSans-Regular", size: 20)
                nameLast.autocorrectionType = .no

                //add constraints
                nameFirst.translatesAutoresizingMaskIntoConstraints = false
                nameLast.translatesAutoresizingMaskIntoConstraints = false
        
                //add to array
                nameArray.append(nameFirst)
                nameArray.append(nameLast)
                allNameFields.append(nameArray)
            
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
    }
    
    //MARK: Public Methods
    
    func updateNumberOfTextfields(_ number: Int){
        self.setupTextFields(number)
    }

}
