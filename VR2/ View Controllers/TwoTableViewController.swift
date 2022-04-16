//
//  TwoTableViewController.swift
//  VR2
//
//  Created by Anton Pavlov on 11.04.2022.
//

import UIKit

class TwoTableViewController: UITableViewController, UISearchBarDelegate {

    
let data = ["Как продать квартиру?", "Как безопасно купить квартиру?", "Как получить налоговой вычет в 2022?", "Топ районов для жизни в Краснодаре", "Почему стоит переезжать в Краснодар?", "Как безопастно сдать жильё?", "Как купить квартиру без риэлтора", "Почему не стоит доверять агентствам недвижимости", "Какой должен быть торг, чтобы квартиру купили?", "Как арендодателю обезопасить себя сдавая квартиру?", "Как правильно просить скидку?", "Покупка квартиры без посредников", "Обратная сторона работы риэлтором", "Так ли хорошо жить в Краснодаре?", "Как оформить ипотеку в 2022?", "Где лучше всего купить квартиру своим родителям?", "Насколько важна инфраструктура?"]


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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = filteredData[indexPath.row]
        
        return cell
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


