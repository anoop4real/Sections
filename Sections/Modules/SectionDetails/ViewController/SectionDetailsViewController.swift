//
//  SectionsViewController.swift
//  Sections
//
//  Created by Anoop M on 2021-05-01.
//

import UIKit

class SectionDetailsViewController: BaseViewController {

    private var selectedSection: ViaplaySection?
    private lazy var titleLabel = ViewFactory.createSimpleLabelWith(textColor: .black, font: .boldSystemFont(ofSize: 18.0))
    private lazy var descriptionTextView = ViewFactory.createASimpleTextView(with: .systemFont(ofSize: 14.0))
    private let dataStore = SectionDetailsDataStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loadData()
    }
    init(with selectedSection: ViaplaySection) {
        super.init(nibName: nil, bundle: nil)
        self.selectedSection = selectedSection
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func loadData() {
        LoadingOverlay.shared.showOverlay(view: view)
        dataStore.fetchDetailedInfoFor(section: selectedSection) {[weak self] (error) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
            if let err = error {
                DispatchQueue.main.async {
                    self?.showAlert(alertTitle: "Error", alertMessage: err.description)
                }
            } else {
                DispatchQueue.main.async {
                    self?.refreshUI()
                }
            }
        }
    }
    private func setUpView() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionTextView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0),
            descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        ])
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .center
        descriptionTextView.isEditable = false
    }
    
    private func refreshUI(){
        titleLabel.text = dataStore.getTitle()
        descriptionTextView.text = dataStore.getDescription()
    }
}
