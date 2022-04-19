//
//  PhotosView.swift
//  PhotoCollection
//
//  Created by Aliaksandr Chekushkin on 4/17/22.
//

import UIKit

protocol PhotosViewDelegate {
    func cellAppeared(id: String?)
    func requestModelEntries()
}

class PhotosView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let cellEdgeConstraint: CGFloat = 0
    private let cellSpacing: CGFloat = 0
    
    private var model: [ImageEntry] = []
    var delegate: PhotosViewDelegate?
    
    static func loadViewFromNib() -> PhotosView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "PhotosView", bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as! PhotosView
    }
    
    func configureView(model: [ImageEntry]) {
        self.model = model
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCollectionViewCell.nib(), forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)

        
        let layout = PinterestViewLayout()
        layout.delegate = self
        collectionView.setCollectionViewLayout(layout, animated: false) // animated=false resolves clunky addition of new cells. Should be resolved with changing X/Y positions in Pinterest Layout
    }
    
    func updateCellAt(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
            self.collectionView.reloadItems(at: [indexPath])
    }

}

extension PhotosView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.configureCell(entry: model[indexPath.row])
        
        //Cell has been drawn, but lacks image. Requests manager to provide it with the image
        if model[indexPath.row].image == nil {
            delegate?.cellAppeared(id: model[indexPath.row].id)
        }
        
        //Sends request for manager to provide collection view with more entries
        if indexPath.row + 5 >= model.count {
            delegate?.requestModelEntries()
        }
        
        return cell
    }

}

extension PhotosView: PinterestLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
      guard let height = model[indexPath.row].height, let width = model[indexPath.row].width else { return 200 }
      
      let aspectRatio = Double(height) / Double(width)
      let outputWidth = (collectionView.bounds.width - cellEdgeConstraint - cellEdgeConstraint) / 2
   
      return outputWidth * aspectRatio
      
  }
}
