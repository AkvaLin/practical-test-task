//
//  ViewController.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 25.08.2023.
//

import UIKit
import Combine

class AdvertisementsViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    private let viewModel = AdvertisementsViewModel()
    private var storage: Set<AnyCancellable> = []
    
    private let sectionInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 20.0, right: 16.0)
    private let minimumItemSpacing: CGFloat = 8
    private let itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupCollectionView()
        binding()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AdvertisementCell.self, forCellWithReuseIdentifier: AdvertisementCell.reuseID)
        collectionView.backgroundColor = .clear
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupSpinner() {
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        spinner.startAnimating()
    }
    
    private func removeSpinner() {
        spinner.removeFromSuperview()
    }
    
    private func binding() {
        viewModel.$state
            .sink { [weak self] state in
                guard let strongSelf = self else { return }
                switch state {
                case .idle:
                    strongSelf.viewModel.fetchData()
                case .loading:
                    strongSelf.setupSpinner()
                case .loaded:
                    strongSelf.collectionView.reloadData()
                    strongSelf.removeSpinner()
                    strongSelf.stopRefreshing()
                case .failed(let error):
                    strongSelf.stopRefreshing()
                    DispatchQueue.main.async {
                        let alert = Alerts.getAlert(for: error)
                        
                        alert.addAction(UIAlertAction(title: "Отмена",
                                                      style: .cancel))
                        
                        alert.addAction(UIAlertAction(title: "Обновить",
                                                      style: .default,
                                                      handler: { _ in
                            strongSelf.viewModel.fetchData()
                        }))
                        
                        strongSelf.present(alert, animated: true)
                    }
                }
            }
            .store(in: &storage)
    }
    
    @objc private func refresh() {
        viewModel.fetchData()
    }
    
    private func stopRefreshing() {
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - CollectionViewDataSource

extension AdvertisementsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.advertisementsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertisementCell.reuseID,
                                                            for: indexPath) as? AdvertisementCell
        else {
            return UICollectionViewCell()
        }
        
        let item = viewModel.advertisementsData[indexPath.row]
        cell.configure(imageURL: item.imageURL,
                       title: item.title,
                       price: item.price,
                       location: item.location,
                       date: item.date)
        return cell
    }
}

// MARK: - CollectionViewDelegate

extension AdvertisementsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailsViewController(id: viewModel.advertisementsData[indexPath.row].id),
                                                 animated: true)
    }
}

// MARK: - CollectionViewDelegateFlowLayout

extension AdvertisementsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsPerRow - 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumItemSpacing
    }
}
