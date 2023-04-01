//
//  SearchLandingViewController.swift
//  HashMemo
//
//  Created by Bhavin Bhadani on 10/03/23.
//

import UIKit

class SearchLandingViewController: UIViewController {

    // MARK: - Proprty Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Proprties
    
    lazy var datasource = makeDataSource()

    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
}
