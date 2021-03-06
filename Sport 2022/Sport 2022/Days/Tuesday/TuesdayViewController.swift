//
//  TuesdayViewController.swift
//  Sport 2022
//
//  Created by Марк Киричко on 25.12.2021.
//

import UIKit
import RealmSwift


class ToDoListItem2: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}

class TuesdayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
    @IBOutlet var table2: UITableView!
    

    private let realm2 = try! Realm()

    var items2 : Results<ToDoListItem2>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.items2 = realm2.objects(ToDoListItem2.self)
        table2.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        table2.delegate = self
        table2.dataSource = self
    }

    // Mark: Table

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items2!.count
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            if let item = items2?[indexPath.row] {
                try! realm2.write {
                    realm2.delete(item)
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = items2![indexPath.row].item
        return cell
    }
    
    @IBAction func didTapAddButton2(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "tuesday") as? EntryViewController2 else {
            return
        }
        vc.completionHandler2 = { [weak self] in
            self?.refresh2()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func refresh2() {
        self.items2 = realm2.objects(ToDoListItem2.self)
        table2.reloadData()
    }

}
