//
//  ViewController.swift
//  YandexDict
//
//  Created by Dmitry on 09.01.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YandexSessionDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var langsButton: UIButton!
    @IBOutlet weak var langsLabel: UILabel!
    @IBOutlet weak var langView: UIView!
    
    var currentLang = ""
    var langsArray: [String] = []
    var resultsArray: [JSON] = []
    var yandexSession = YandexSession()
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBAction func unwindSegue (segue: UIStoryboardSegue) {
        guard let svc = segue.source as? LangsTableViewController else {return}
        guard let indexCurrentLang = svc.indexCurrentLang else {return}
        self.langsLabel.text = langsArray[indexCurrentLang]
        self.currentLang = svc.currentLang
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.yandexSession.delegate = self
        self.yandexSession.getLangs()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap))
        
        langView.addGestureRecognizer(recognizer)
        self.mainTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    @IBAction func langAction(_ sender: Any) {
        searchBar.showsCancelButton = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keyword = searchBar.text?.lowercased()
        yandexSession.getURL(text: keyword!, lang: currentLang)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let keyword = searchBar.text?.lowercased()
        yandexSession.getURL(text: keyword!, lang: currentLang)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func didTap() {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func VC_getLangs(langsArray: Array<String>) {
        self.langsArray = langsArray
        self.langsLabel.text = langsArray[28]
        self.currentLang = langsArray[28]
    }
    
    func VC_lookUp(json: JSON) {
        self.resultsArray = json["def"][0]["tr"].arrayValue
        self.mainTableView.reloadData()
    }
    
    func VC_error(ac: UIAlertController) {
        present(ac, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MainTableViewCell
        
        cell.langLabel.text = self.resultsArray[indexPath.row]["text"].stringValue
        cell.meanKey.text = "Значение:"
        cell.synKey.text = "Синоним:"
        let synText = self.resultsArray[indexPath.row]["syn"][0]["text"].stringValue
        let meanText = self.resultsArray[indexPath.row]["mean"][0]["text"].stringValue
        
        if synText == "" {
            cell.synValue.text = "-----------"
        }else {
            cell.synValue.text = self.resultsArray[indexPath.row]["syn"][0]["text"].stringValue
        }
        
        if meanText == "" {
            cell.meanValue.text = "-----------"
        }else {
            cell.meanValue.text = self.resultsArray[indexPath.row]["mean"][0]["text"].stringValue
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mainTableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLangs" {
            let dvc = segue.destination as! LangsTableViewController
            dvc.langsArray = self.langsArray
        }
        if segue.identifier == "ShowDetail" {
            let dvc = segue.destination as! DetailTableViewController
            if let indexPath = self.mainTableView.indexPathForSelectedRow {
                dvc.results = self.resultsArray[indexPath.row]
                
                
            }
        }        
    }
    
}

