

import UIKit

class MapListViewController: UITableViewController, UISearchBarDelegate {

    
let data = ["Гарантия на Карякина", "Лучший", "Москва", "Кубанский", "Тургенев", "Большой", "Ревьера", "Оскар" , "Сказка", "Оникс"]
    
    
    
    
@IBOutlet weak var searchBar: UISearchBar!
    
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        filteredData = data
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cello = tableView.dequeueReusableCell(withIdentifier: "cello")! as UITableViewCell
        
        cello.textLabel?.text = filteredData[indexPath.row]
        
        return cello
    }
    
    // Этот код отвечает за работу поисковика
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
    filteredData = []
        
        if searchText == "" {
         filteredData = data
        }
        else {
        for list in data {
            
            if list.lowercased().contains(searchText.lowercased()) {
            filteredData.append(list)
            }
        }
        }
        self.tableView.reloadData()
    }
}


