//
//  ThursdayViewController.swift
//  Sport 2022
//
//  Created by Марк Киричко on 25.12.2021.
//

import UIKit
import RealmSwift
import AVFoundation



class ThursdayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
    @IBOutlet var table4: UITableView!
    
    private let realm4 = try! Realm()

    var player: AVAudioPlayer!
    
    var items4 : Results<ExercisesDB>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.items4 = realm4.objects(ExercisesDB.self)
        table4.register(UITableViewCell.self, forCellReuseIdentifier: "cell4")
        table4.delegate = self
        table4.dataSource = self
        refresh4()
    }

    func playAudio() {
        let url = Bundle.main.url(forResource: "complete", withExtension: "mp3")
        
        guard url != nil else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.play()
        } catch {
            print("\(error)")
        }
    }
    
    func playAudio2() {
        let url = Bundle.main.url(forResource: "delete", withExtension: "mp3")
        
        guard url != nil else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.play()
        } catch {
            print("\(error)")
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        playAudio()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items4!.count
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            if let item = items4?[indexPath.row] {
                try! realm4.write {
                    realm4.delete(item)
                    playAudio2()
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath)
        cell.textLabel?.text = items4![indexPath.row].name
        return cell
    }
    
    @IBAction func didTapAddButton4(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "thursday") as? EntryViewController4 else {
            return
        }
        vc.completionHandler4 = { [weak self] in
            self?.refresh4()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func refresh4() {
        items4 = realm4.objects(ExercisesDB.self)
        table4.reloadData()
    }

}
