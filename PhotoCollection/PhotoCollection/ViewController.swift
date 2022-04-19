//
//  ViewController.swift
//  PhotoCollection
//
//  Created by Aliaksandr Chekushkin on 4/17/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var containterView: UIView!
    let photosView = PhotosView.loadViewFromNib()
    
    private let manager = ImageManager()
    private var subscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerView()
        manager.getImageInfo(number: 25)
        
        setupSubscriber()
    }
    
    func setupSubscriber() {
        subscriber = manager.modelPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { model in
                self.photosView.configureView(model: model)
                if model.count >= 0 {
                    self.photosView.updateCellAt(row: model.count - 1)
                }
            })
    }
    
    func configureContainerView() {
        photosView.frame.size = containterView.frame.size
        photosView.delegate = self
        containterView.addSubview(photosView)
    }
    
}

extension ViewController: PhotosViewDelegate {
    
    func cellAppeared(id: String?) {
        manager.getImage(id: id) {
            DispatchQueue.main.async {
                let index = self.manager.model.firstIndex{ $0.id == id }
                guard let index = index else { return }
                self.photosView.updateCellAt(row: index)
            }
        }
    }
    
    func requestModelEntries() {
        manager.getImageInfo(number: 10)
    }
}

