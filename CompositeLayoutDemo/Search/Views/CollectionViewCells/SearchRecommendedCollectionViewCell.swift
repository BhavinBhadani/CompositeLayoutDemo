//
//  SearchRecommendedCollectionViewCell.swift
//  HashMemo
//
//  Created by Bhavin Bhadani on 10/03/23.
//

import UIKit

class SearchRecommendedCollectionViewCell: UICollectionViewCell {

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
