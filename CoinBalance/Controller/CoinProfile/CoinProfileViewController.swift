//
//  CoinProfileViewController.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/11/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit
import Charts

class CoinProfileViewController: UIViewController {
    
    var coin: Coin?
    weak var containerSubView: UIViewController?
    
    private lazy var transactionsViewController: TransactionsTableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "TransactionsTableViewController") as! TransactionsTableViewController
        
        // Add View Controller as Child View Controller
        self.add(subViewController: viewController)
        
        return viewController
    }()
    
    private lazy var coinInfoViewController: CoinInfoTableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "CoinInfoTableViewController") as! CoinInfoTableViewController
        
        // Init Coin on Child View Controller
        viewController.coin = coin
        
        // Add View Controller as Child View Controller
        self.add(subViewController: viewController)
        
        return viewController
    }()

    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSubView()
    }
    
    @IBAction func tableSegmentedControlPressed(_ sender: UISegmentedControl) {
        updateSubView()
    }
    
    
    private func add(subViewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(subViewController)
        
        // Add Child View as Subview
        containerView.addSubview(subViewController.view)
        
        // Configure Child View
//        subViewController.view.frame = view.bounds
//        subViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        subViewController.didMove(toParentViewController: self)
    }
    
    private func remove(subViewController: UIViewController) {
        subViewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        subViewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        subViewController.removeFromParentViewController()
    }
    
    private func updateSubView() {
        if tableSegmentedControl.selectedSegmentIndex == 0 {
            remove(subViewController: coinInfoViewController)
            add(subViewController: transactionsViewController)
        } else {
            remove(subViewController: transactionsViewController)
            add(subViewController: coinInfoViewController)
        }
    }

}
