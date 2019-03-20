//
//  FlexTextField.swift
//  inputfield
//
//  Created by makoto.kaneko on 2019/03/13.
//  Copyright © 2019 makoto.kaneko. All rights reserved.
//

import UIKit

@IBDesignable
class FlexTextField: UITextField {

  @IBInspectable var marginTop: CGFloat = 0 {
    didSet {
//      setNeedsLayout()
//      setNeedsDisplay()
    }
  }

  @IBInspectable var marginLeft: CGFloat = 0 {
    didSet {
//      setNeedsLayout()
//      setNeedsDisplay()
    }
  }

  @IBInspectable var marginBottom: CGFloat = 0 {
    didSet {
//      setNeedsLayout()
//      setNeedsDisplay()
    }
  }

  @IBInspectable var marginRight: CGFloat = 0 {
    didSet {
//      setNeedsLayout()
//      setNeedsDisplay()
    }
  }

  // MARK: -

  private var insets: UIEdgeInsets {
    var edgeInsets = UIEdgeInsets(top: marginTop,
                                  left: marginLeft,
                                  bottom: marginBottom,
                                  right: marginRight)
    if let leftView = leftView {
      edgeInsets.left += leftView.frame.maxX
    }
    if let rightView = rightView {
      edgeInsets.right += rightView.bounds.width
    }
    return edgeInsets
  }

  // MARK: -

  override func awakeFromNib() {
    superview?.awakeFromNib()
  }
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */

  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
  }
  
//  override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
//    var rect = super.leftViewRect(forBounds: bounds)
//    //rect.origin.x += insets.left
//    return rect
//  }
//  
//  override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
//    var rect = super.rightViewRect(forBounds: bounds)
//    rect.origin.x -= insets.right
//    return rect
//  }

  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: insets)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: insets)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: insets)
  }

}
