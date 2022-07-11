//
//  ViewController.swift
//  NewsApp
//
//  Created by Muhammadjon Loves on 7/6/22.
//

import UIKit

class MainViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ourSearchBar: UISearchBar!
    
    var filtredNews = [NewsItemTableViewCellViewModel]()
    var articles = [Articles]()
    var theViewModels = [NewsItemTableViewCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ourSearchBar.delegate = self
        tableView.delegate = self  // Don't forget these two
        tableView.dataSource = self //  // Don't forget these two
        
        let nib = UINib(nibName: K.cellNibname, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.cellIdentifier)
        tableView.rowHeight = 130.0
        // Do any additional setup after loading the view.
        
        //MARK: - Recevied Data Manipulation
        NewsManager.shared.fetchNEWS { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                
                self?.theViewModels = articles.compactMap({
                    NewsItemTableViewCellViewModel(title: $0.title ?? "No title", description: $0.description ?? "No descripton", imageURL: $0.urlToImage ?? "No URL")
                })
                
                self?.filtredNews = articles.compactMap({
                    NewsItemTableViewCellViewModel(title: $0.title ?? "No title", description: $0.description ?? "No descripton", imageURL: $0.urlToImage ?? "No URL")
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    var searchBarIsEmpty: Bool {
        guard let text = ourSearchBar.text else {return false}
        return text.isEmpty
    }
 
     var isFiltering: Bool {
         return !searchBarIsEmpty
     }
}

//MARK: - UITableView Delegate & Data Source Methods

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtredNews.count

        } else {
            return theViewModels.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! NewsItemTableViewCell
        if isFiltering {
            cell.configure(with: filtredNews[indexPath.row])
        } else {
            cell.configure(with: theViewModels[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.segueIdentifier, sender: self)
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueIdentifier {
            let indexPathh = tableView.indexPathForSelectedRow
            let destinationVC = segue.destination as! NewsViewController
            destinationVC.theUrl = articles[indexPathh!.row].url
        }
    }
}
//MARK: - SearchBar Delegate Methods

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterNews(ourSearchBar.text!)
        print(searchBar.text!)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }
    private func filterNews(_ searchText: String) {
        filtredNews = theViewModels.filter({ (news: NewsItemTableViewCellViewModel ) -> Bool in
            return (news.title.lowercased().contains(searchText.lowercased()))
        })
        self.tableView.reloadData()
    }
}





