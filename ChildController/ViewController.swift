//
//  ViewController.swift
//  ChildController
//
//  Created by Henrique Valcanaia on 2020-04-17.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import UIKit

protocol ControlDatasource {
    func getChild(at indexPath: IndexPath) -> UIViewController
}

protocol ControlDelegate {
    func didTapControl(at indexPath: IndexPath)
}

protocol ControlProtocol: (ControlDelegate&ControlDatasource) {
    var delegate: ControlDelegate? { get set }
}

class ChildController: UIViewController {
    private var childViewController: UIViewController? {
        didSet {
            // show full screen alongside the control somehow.
            // maybe we can inject a closure here to decide how to position the control and child?
            // does this sound like SwiftUI Geometry reader??? :thinking_intesifies:
            // https://developer.apple.com/documentation/swiftui/geometryreader
        }
    }
    
    var dataSource: ControlDatasource?
    var control: ControlProtocol? {
        didSet {
            self.control?.delegate = self
        }
    }
    
    convenience init(control: ControlProtocol?, dataSource: ControlDatasource?) {
        self.init()
        self.control = control
        self.dataSource = dataSource
    }
}

extension ChildController: ControlDelegate {
    func didTapControl(at indexPath: IndexPath) {
        self.childViewController = self.dataSource?.getChild(at: indexPath)
    }
}

extension ChildController: ControlDatasource {
    func getChild(at indexPath: IndexPath) -> UIViewController {
        return self.children[indexPath.row]
    }
}
