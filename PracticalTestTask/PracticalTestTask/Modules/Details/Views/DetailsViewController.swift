//
//  DetailsViewController.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 25.08.2023.
//

import UIKit
import Combine

class DetailsViewController: UIViewController {
    
    private let spinner = UIActivityIndicatorView(style: .large)
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var imageView: CustomImageView = {
        let view = CustomImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 22)
        return lbl
    }()
    private lazy var priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return lbl
    }()
    private lazy var locationLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        return lbl
    }()
    private lazy var dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        return lbl
    }()
    private lazy var mainDescriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Описание"
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return lbl
    }()
    private lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    private lazy var contactInfoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Контактная информация"
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return lbl
    }()
    private lazy var emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        return lbl
    }()
    private lazy var phoneLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        return lbl
    }()
    
    private let viewModel: DetailsViewModel
    private var storage: Set<AnyCancellable> = []
    
    init(id: String) {
        self.viewModel = DetailsViewModel(id: id)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        binding()
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
                    strongSelf.setupViews()
                    strongSelf.removeSpinner()
                case .failed(let error):
                    DispatchQueue.main.async {
                        strongSelf.removeSpinner()
                        let alert = Alerts.getAlert(for: error)
                        
                        alert.addAction(UIAlertAction(title: "Отмена",
                                                      style: .cancel,
                                                      handler: { _ in
                            strongSelf.navigationController?.popViewController(animated: true)
                        }))
                        
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
}

// MARK: - UI Settings

private extension DetailsViewController {
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([imageView,
                                 titleLabel,
                                 priceLabel,
                                 locationLabel,
                                 mainDescriptionLabel,
                                 descriptionLabel,
                                 contactInfoLabel,
                                 emailLabel,
                                 phoneLabel,
                                 dateLabel])
    }
    
    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        mainDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contactInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            locationLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
            
            mainDescriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            mainDescriptionLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            mainDescriptionLabel.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: mainDescriptionLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainDescriptionLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainDescriptionLabel.trailingAnchor),
            
            contactInfoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            contactInfoLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            contactInfoLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: contactInfoLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: contactInfoLabel.trailingAnchor),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            phoneLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: phoneLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: phoneLabel.trailingAnchor)
        ])
    }
    
    func setupViews() {
        addSubviews()
        setupConstraints()
        
        imageView.loadImage(from: viewModel.detailsModel.imageURL)
        titleLabel.text = viewModel.detailsModel.title
        priceLabel.text = viewModel.detailsModel.price
        locationLabel.text = viewModel.detailsModel.location
        dateLabel.text = viewModel.detailsModel.createdDate
        descriptionLabel.text = viewModel.detailsModel.description
        emailLabel.text = viewModel.detailsModel.email
        phoneLabel.text = viewModel.detailsModel.phoneNumber
    }
}
