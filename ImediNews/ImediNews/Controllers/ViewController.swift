//
//  ViewController.swift
//  ImediNews
//
//  Created by Default on 19.04.24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let titleForNews: UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    let itemsTableView: UITableView = {
        let table = UITableView()
        table.register(NewsCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var news = [imediNewsModel]()
    
    var url: String = "https://imedinews.ge/api/categorysidebarnews/get"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        constraintForTitle()
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        fetchData()
    }
    
    func fetchData() {
            NetworkService().getData(urlString: url) { (result: [imediNewsModel]?, error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                if let result = result {
                    self.news = result
                    DispatchQueue.main.async {
                        self.itemsTableView.reloadData()
                    }
                }
            }
        }

    func constraintForTitle() {
        self.view.addSubview(titleForNews)
        titleForNews.widthAnchor.constraint(equalToConstant: 158).isActive = true
        titleForNews.heightAnchor.constraint(equalToConstant: 31).isActive = true
        titleForNews.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        titleForNews.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        titleForNews.textColor = UIColor.black
        titleForNews.font = UIFont(name: "SpaceGrotesk-Bold", size: 24)
        titleForNews.text = "NEWS"
        titleForNews.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleForNews.textAlignment = .center
        
    }
    
    func addTableView() {
        view.addSubview(itemsTableView)
        itemsTableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 20).isActive = true
        itemsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        itemsTableView.frame = view.bounds
    }
    
    //table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsCell
        let newsItem = news[indexPath.row]
        cell.configure(with: newsItem)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        itemsTableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    var selectedNewsItem: imediNewsModel?

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNewsItem = news[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let destinationVC = segue.destination as? SecondPage {
                destinationVC.newsItem = selectedNewsItem
            }
        }
    }
    
   
}




