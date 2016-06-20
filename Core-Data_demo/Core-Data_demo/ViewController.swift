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
		
		
	}

}

