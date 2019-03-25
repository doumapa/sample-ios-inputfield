//
//  UIAlertController+.swift
//  inputfield
//
//  Created by makoto.kaneko on 2019/03/20.
//  Copyright © 2019 makoto.kaneko. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift

extension UIAlertController {

  struct AlertAction {
    var title: String?
    var style: UIAlertAction.Style
    
    static func action(title: String?, style: UIAlertAction.Style = .default) -> AlertAction {
      return AlertAction(title: title, style: style)
    }
  }

//  static func present(in viewController: UIViewController, title: String?, message: String?, style: UIAlertController.Style, actions: [AlertAction]) -> SignalProducer<Int, NoError> {
//    return SignalProducer<Int, NoError> { (observable, disposable) in
//      let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
//      actions.enumerated().forEach { index, action in
//        let action = UIAlertAction(title: action.title, style: action.style) { _ in
//          observable.send(value: index)
//          observable.sendCompleted()
//        }
//        alertController.addAction(action)
//      }
//      viewController.present(alertController, animated: true, completion: nil)
//      disposable.observeEnded {
//        alertController.dismiss(animated: true, completion: nil)
//      }
//    }
//  }

  static func present(in viewController: UIViewController, title: String?, message: String?, style: UIAlertController.Style, actions: [AlertAction]) -> Signal<Int, NoError> {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    actions.enumerated().forEach { index, action in
      let action = UIAlertAction(title: action.title, style: action.style) { _ in
        observer.send(value: index)
        observer.sendCompleted()
      }
      alertController.addAction(action)
    }
    viewController.present(alertController, animated: true, completion: nil)
    return signal
  }

}
