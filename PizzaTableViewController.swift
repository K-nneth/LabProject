//
//  PizzaTableViewController.swift
//  ProjectLab
//
//  Created by Putri Ardhia on 05/06/18.
//  Copyright © 2018 prk. All rights reserved.
//

import UIKit
import CoreData

class PizzaTableViewController: UITableViewController {

    var users: [Pizza] = []
    
    var selected : Pizza?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<Pizza>(entityName: "Pizza")
        
        
        do{
            users = try context.fetch(fetchReq)
        }catch{
            
        }
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pizzaCell") as! PizzaTableViewCell
        let user = users[indexPath.row]
        cell.pizzaName.text = user.value(forKey: "name") as! String
        cell.pizzaPrice.text = user.value(forKey: "price") as! String
        
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Return false if you do not want the specified item to be editable.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let delete = UITableViewRowAction(style: .default, title: "Delete"){
            (action, indexPath) in
            context.delete(self.users[indexPath.row])
            self.users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do{
                try context.save()
            }catch{}
        }
        delete.backgroundColor = .red
        
        let update = UITableViewRowAction(style: .default, title: "Update"){
            (action, indexPath) in
            self.selected = self.users[indexPath.row]
            self.performSegue(withIdentifier: "showUpdate", sender: self)
        }
        
        return [delete,update]
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showUpdate"){
            let dest = segue.destination as! InsertController
            dest.user = self.selected
        }
    }
    
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
