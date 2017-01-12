//
//  DetailTableViewController.swift
//  YandexDict
//
//  Created by Dmitry on 12.01.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailTableViewController: UITableViewController {
    
    var results: JSON = []
    let headersName = ["Перевод", "Синонимы", "Значения", "Примеры"]
    var translateArray: [String] = []
    var mainArray:[[String]] = []
    var synArray: [String] = []
    var meanArray: [String] = []
    var exArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translate = self.results["text"].stringValue
        self.translateArray.append(translate)
        let synCount = self.results["syn"].count
        let meanCount = self.results["mean"].count
        let exCount = self.results["ex"].count
        
        for i in 0...synCount {
            self.synArray.append(self.results["syn"][i]["text"].stringValue)
        }
        for i in 0...meanCount {
            self.meanArray.append(self.results["mean"][i]["text"].stringValue)
        }
        for i in 0...exCount {
            self.exArray.append(self.results["ex"][i]["text"].stringValue)
        }
        
        mainArray.append(translateArray)
        mainArray.append(synArray)
        mainArray.append(meanArray)
        mainArray.append(exArray)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.headersName.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headersName[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.mainArray[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        let text = mainArray[indexPath.section][indexPath.row]
        if text == "" {
            cell.textLabel?.text = "----------------"
        }else {
            cell.textLabel?.text = mainArray[indexPath.section][indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
