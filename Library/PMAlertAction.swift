//
//  PMAlertAction.swift
//  PMAlertController
//
//  Created by Paolo Musolino on 07/05/16.
//  Copyright © 2018 Codeido. All rights reserved.
//

import UIKit

@objc public enum PMAlertActionStyle : Int {
    
    case `default`
    case cancel
}

@objc open class PMAlertAction: UIButton {
    
    fileprivate var action: (() -> Void)?

    open var defaultButtonFont = UIFont.boldSystemFont(ofSize: 17)
    open var cancelButtonFont = UIFont.systemFont(ofSize: 17)
    open var defaultTitleColor = UIColor(red: 86.0/255.0, green: 181.0/255.0, blue: 240.0/255.0, alpha: 1.0)
    open var cancelTitleColor = UIColor(red: 86.0/255.0, green: 181.0/255.0, blue: 240.0/255.0, alpha: 1.0)
    open var actionStyle : PMAlertActionStyle
    
    open var separator = UIImageView()
    
    init(){
        self.actionStyle = .cancel
        super.init(frame: CGRect.zero)
    }
    
    @objc public convenience init(title: String?, style: PMAlertActionStyle, action: (() -> Void)? = nil){
        self.init()
        
        self.action = action
        self.addTarget(self, action: #selector(PMAlertAction.tapped(_:)), for: .touchUpInside)

        self.setTitle(title, for: UIControl.State())
        self.actionStyle = style
        style == .default ? (self.titleLabel?.font = defaultButtonFont) : (self.titleLabel?.font = cancelButtonFont)
        style == .default ? (self.setTitleColor(defaultTitleColor, for: UIControl.State())) : (self.setTitleColor(cancelTitleColor, for: UIControl.State()))

        self.addSeparator()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapped(_ sender: PMAlertAction) {
        //Action need to be fired after alert dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.action?()
        }
    }
    
    @objc fileprivate func addSeparator(){
        separator.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        self.addSubview(separator)
        
        // Autolayout separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        separator.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 8).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -8).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
}
