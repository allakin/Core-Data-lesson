//
//  ViewController.swift
//  Core-Data_demo
//
//  Created by Павел Анплеенко on 20/06/16.
//  Copyright © 2016 Pavel Anpleenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
	
	//пустой строковый массив
	var list = [String]()
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "The List"
		
		//зарегистрируем класс на ячеек
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return list.count
	}
	
	// что должно отображаться в каждой ячейки
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		//создаем ячейку
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
		
		cell!.textLabel!.text = list[indexPath.row]
		
		return cell!
	}

	@IBAction func addButtonPressed(sender: AnyObject) {
		
		//создаем алерт
		let alert = UIAlertController(title: "New item", message: "Add new item", preferredStyle: .Alert)
		
		let saveAction = UIAlertAction(title: "save", style: .Default) { (UIAlertAction) -> Void in
			
		//создать переменная с текстовым полем
		let textField = alert.textFields?.first
		
		//в текствое поле добавить
		self.list.append(textField!.text!)
		
		//обновлять значения
		self.tableView.reloadData()
			
		}
		
		//действие которое будет отменять UIAlertController
		let cancelAction = UIAlertAction(title: "cancel", style: .Default) { (UIAlertAction) -> Void in
			
		}
		
		//добавляем текстовое поле
		alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
		}
		
		//отображаем кнопки
		alert.addAction(saveAction)
		alert.addAction(cancelAction)
		
		presentViewController(alert, animated: true, completion: nil)

		
	}

}

