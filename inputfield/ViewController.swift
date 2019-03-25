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

    let view = UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
    view.tintColor = .green
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
    actionSheetButton.reactive.pressed = CocoaAction<UIButton>(Action<Void, Void, NoError> {
      UIAlertController.present(in: self,
                                title: nil /*"支出"*/,
                                message: "支出",
                                style: .actionSheet,
                                actions: [
                                  .action(title: "週間"),
                                  .action(title: "月間"),
                                  .action(title: "年間"),
                                  .action(title: "キャンセル", style: .cancel),
                                  ])
        .take(duringLifetimeOf: self)
        .observeValues { (index: Int) in
          print("index:\(index)")
      }
      return SignalProducer.empty
    })
  }

}

