//
//  CustomCollectionViewCell.swift
//  PhotoCollection
//
//  Created by Aliaksandr Chekushkin on 4/17/22.
//

import UIKit

protocol CustomCollectionViewCellDelegate {
    func cellAppeared(id: String?)
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelViewContainer: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let cornerRadius: CGFloat = 10
    
    static let identifier = "CustomCollectionViewCell"
    
    var delegate: CustomCollectionViewCellDelegate?
    
    static func nib() -> UINib {
        return UINib(nibName: CustomCollectionViewCell.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(entry: ImageEntry?) {
        configureBackgroundContainer()
        label.text = entry?.authorUsername
        imageView.image = entry?.image
        
        if entry?.image != nil {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        
    }
    
    
    private func configureBackgroundContainer() {
        backgroundContainer.layer.cornerRadius = cornerRadius
        
        //need to increase the background constraint to increase/decrease the shadow for future changes
        let cgColor = CGColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        self.layer.shadowColor = cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        self.layer.shadowRadius = 1
    }
}


