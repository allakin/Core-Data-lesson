//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Павел Анплеенко on 10/08/16.
//  Copyright © 2016 Pavel Anpleenko. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
	
	var cars		= [NSManagedObject]()
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		//заголовок навигайшен контроллер
		title = "The List"
		
		// регистрация класса ячейки
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
		let context = appDelegate?.managedObjectContext
		
		//задаем запрос к сущности Car
		let fetchRequest = NSFetchRequest(entityName: "Car")
		
		do{
			//смотрим какие результаты там появились
			let results = try context!.executeFetchRequest(fetchRequest)
			//приводим  results AnyObject в cars NSManagedObject
			cars = results as! [NSManagedObject]
		} catch let error as NSError {
			print("Запрос данных из CoreData не прошел \(error.localizedDescription)")
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cars.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
		
		//экзампляр класса из коредаты
		let car = cars[indexPath.row]
		cell?.textLabel?.text = car.valueForKey("mark") as? String
		return cell!
	}
	
	@IBAction func addButtonPressed(sender: AnyObject) {
		let alert = UIAlertController(title: "New item", message: "Add new item", preferredStyle: .Alert)
		let saveAction = UIAlertAction(title: "Save", style: .Default, handler: {(action: UIAlertAction) -> Void in
			let textField = alert.textFields?.first
			self.saveMark(textField!.text!)
			self.tableView.reloadData()
		})
	 
		let calcelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
		alert.addTextFieldWithConfigurationHandler {(textFiled: UITextField) -> Void in
		}
		
		alert.addAction(saveAction)
		alert.addAction(calcelAction)
		presentViewController(alert, animated: true, completion: nil)
		
	}
	
	// MARK: - func saveMark
	func saveMark(mark: String){
		//обращаемся к файлу AppDelegate.swift
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		//обращаемся к managedObjectContext
		let context = appDelegate.managedObjectContext
		//обращаемся к конкретной сущности
		let entity = NSEntityDescription.entityForName("Car", inManagedObjectContext: context)
		//создаем экземпляр NSManagedObject
		let car = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: context)
		//добавляем значения для mark
		car.setValue(mark, forKey: "mark")
		//сохраняем все внесенные изменения через do catch
		do {
			try context.save()
			cars.append(car)
		} catch let error as NSError {
			print("Localized error description \(error.localizedDescription)")
		}
		
	}
	
}