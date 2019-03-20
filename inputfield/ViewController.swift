//
//  ViewController.swift
//  inputfield
//
//  Created by makoto.kaneko on 2019/03/12.
//  Copyright © 2019 makoto.kaneko. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift
import ReactiveCocoa

class ViewController: UIViewController {

  @IBOutlet var textFieldRightImageView: UIImageView!
  @IBOutlet weak var textField: FlexTextField!
  @IBOutlet weak var actionSheetButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    bind()
  }

  private func configure() {
    textFieldRightImageView.isUserInteractionEnabled = true
    textField.rightView = textFieldRightImageView
    textField.rightViewMode = .whileEditing
    textField.isSecureTextEntry = true
  }

  private func bind() {
    textFieldRightImageView.addGestureRecognizer({ (gesture: UIGestureRecognizer) -> UIGestureRecognizer in
      gesture.reactive.stateChanged
        .take(duringLifetimeOf: self)
        .observeValues { [weak self] (gesture: UIGestureRecognizer) in
          guard let isHighlighted = self?.textFieldRightImageView.isHighlighted else { return }
          self?.textFieldRightImageView.isHighlighted = !isHighlighted
          self?.textField.isSecureTextEntry = isHighlighted
      }
      return gesture
    } (UITapGestureRecognizer()))
  }

}

