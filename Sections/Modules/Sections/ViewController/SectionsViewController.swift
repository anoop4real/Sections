//
//  SectionsViewController.swift
//  Sections
//
//  Created by Anoop M on 2021-04-30.
//

import UIKit

class SectionsViewController: BaseViewController {
    private let baseCellId = "baseCellId"
    private lazy var dataStore = SectionsDataStore()
    private lazy var sectionsTableView = ViewFactory.createSimpleTableViewWith(cellClass: UITableViewCell.self, forCellWithReuseIdentifier: baseCellId)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sections"
        view.backgroundColor = .white
        setUpView()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        LoadingOverlay.shared.showOverlay(view: view)
        dataStore.fetchSections { [weak self] error in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
            if let err = error {
                DispatchQueue.main.async {
                    self?.showAlert(alertTitle: "Error", alertMessage: err.description)
                }
            } else {
                DispatchQueue.main.async {
                    self?.sectionsTableView.reloadData()
                }
            }
        }
    }

    private func setUpView() {
        view.addSubview(sectionsTableView)
        
        NSLayoutConstraint.activate([
            sectionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sectionsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            sectionsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sectionsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        ])
        sectionsTableView.delegate = self
        sectionsTableView.dataSource = self
    }
}

extension SectionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = dataStore.itemAt(index: indexPath.row) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: baseCellId, for: indexPath)
        
        cell.textLabel?.text = item.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataStore.itemAt(index: indexPath.row) else {
            return
        }
        let detailedVC = SectionDetailsViewController(with: item)
        self.navigationController?.pushViewController(detailedVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
