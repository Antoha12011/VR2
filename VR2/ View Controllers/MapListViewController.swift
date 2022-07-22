

import UIKit

class MapListViewController: UITableViewController, UISearchBarDelegate {
    
    
    let complex = ["Гарантия на Карякина", "Лучший", "Москва", "Кубанский", "Тургенев", "Большой", "Ривьера", "Оскар" , "Сказка", "Оникс", "Феникс"]
        .sorted(by: <)
    
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        filteredData = complex
        
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
            filteredData = complex
        }
        else {
            for list in complex {
                
                if list.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(list)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    /// Работа сигвея
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        _ = complex[indexPath.row]
        
        performSegue(withIdentifier: "complex", sender: complex)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "complex" {
            
        }
    }
}


