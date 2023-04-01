//
//  SearchLandingCollectionHeaderView.swift
//  HashMemo
//
//  Created by Bhavin Bhadani on 31/03/23.
//

import UIKit

class SearchLandingCollectionHeaderView: UICollectionReusableView {
    
    //MARK: - Proprty Outlets
    
    //MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
        
    //MARK: - Configurations
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
