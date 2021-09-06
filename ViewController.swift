//
//  ViewController.swift
//  SampleMVVMApp
//
//  Created by Hammad Zafar on 05/09/2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: -
    // MARK: Properties
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: -
    // MARK: Class Properties
    
    var sections : [String] = []
    var dataList = [TypiCodeDataModel]() {
        didSet {
            DispatchQueue.main.async {
                self.sections = self.getSections(from: self.dataList)
                self.tableView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    // MARK: -
    // MARK: -
    // MARK: Methods
    // MARK: -
    
    
    // MARK: -
    // MARK: UIViewController Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: Constants.TypiCodeDataCellNibName, bundle: nil), forCellReuseIdentifier: TypiCodeDataCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        let results = Storage.shared.getSavedData()
        self.dataList.append(contentsOf: results)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.activityIndicatorView.startAnimating()
        self.fetchDataFromAPI()
    }
    
    // MARK: -
    // MARK: Accessory Methods
    
    func getSections(from dataList : [TypiCodeDataModel]) -> [String] {
        var sections : [String] = []
        
        for model in dataList {
            if !sections.contains("\(model.albumId)") {
                sections.append("\(model.albumId)")
            }
        }
        
        return sections
    }
    
    func fetchDataFromAPI() {
        guard let url = URL(string: APIService.urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode([TypiCodeDataModel].self, from: data)
                        Storage.shared.clearAndSaveData(from: response)
                        self.dataList.removeAll()
                        self.dataList.append(contentsOf: response)
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            else {
                print(error?.localizedDescription ?? "")
            }
        }.resume()
    }
}

// MARK: -
// MARK: UITableView Delegate and DataSource

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Album ID: \(self.sections[section])"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.black
        let sectionLabel = UILabel(frame: CGRect(x: 8, y: 8, width:
                                                    tableView.bounds.size.width, height: tableView.bounds.size.height))
        sectionLabel.font = UIFont(name: "Helvetica", size: 18)
        sectionLabel.textColor = UIColor.white
        sectionLabel.text = "Album ID \(self.sections[section])"
        sectionLabel.textAlignment = .center
        
        sectionLabel.sizeToFit()
        headerView.addSubview(sectionLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        let sectionAlbumId = self.sections[section]
        
        let filteredModels = dataList.filter { (data) -> Bool in
            return "\(data.albumId)" == sectionAlbumId
        }
        
        return filteredModels.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TypiCodeDataCell.identifier, for: indexPath) as? TypiCodeDataCell
        else {
            return UITableViewCell()
        }
        
        // let sections = getSections(from: dataList)
        
        let sectionAlbumId = self.sections[indexPath.section]
        
        let filteredModels = dataList.filter { (data) -> Bool in
            return "\(data.albumId)" == sectionAlbumId
        }
        
        let model = filteredModels[indexPath.row]
        cell.configure(with: TypiCodeDataCellViewModel(with: model))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

