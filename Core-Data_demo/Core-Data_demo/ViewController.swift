//
//  ViewController.swift
//  Core-Data_demo
//
//  Created by Павел Анплеенко on 20/06/16.
//  Copyright © 2016 Pavel Anpleenko. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
	
	//пустой строковый массив
	var cars = [NSManagedObject]()
	
	@IBOutlet weak var tableView: UITableView!
	
	//viewDidLoad метод который срабатывает один раз
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "The List"
		
		//зарегистрируем класс на ячеек
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}
	
	//viewWillAppear метод который срабатывает каждый раз когда есть какие то изменения в интерфейсе
	override func viewWillAppear(animated: Bool) {
		//перезаписывание класса viewWillAppear
		super.viewWillAppear(animated)
		
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let context = appDelegate.managedObjectContext
		
		//создаем запрос к entity Car
		let fetchRequest = NSFetchRequest(entityName: "Car")
		
		do{
			//смотрим какие результаты там появились
			let results = try context.executeFetchRequest(fetchRequest)
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
	
	// что должно отображаться в каждой ячейки
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		//создаем ячейку
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
		
		let car = cars[indexPath.row]
		cell!.textLabel!.text = car.valueForKey("mark") as? String
		
		return cell!
	}

	@IBAction func addButtonPressed(sender: AnyObject) {
		
		//создаем алерт
		let alert = UIAlertController(title: "New item", message: "Add new item", preferredStyle: .Alert)
		
		let saveAction = UIAlertAction(title: "save", style: .Default) { (UIAlertAction) -> Void in
			
		//создать переменная с текстовым полем
		let textField = alert.textFields?.first
		
		//в текствое поле добавить
		self.saveMark(textField!.text!)
		
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

	//функция для чтобы сохранялись значение в saveMark
	func saveMark(mark: String) {
		
		// обращение к файлу AppDelegate.swift
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		
		//находим контексту
		let context = appDelegate.managedObjectContext
		
		//обращение к сущности Car
		let entity = NSEntityDescription.entityForName("Car", inManagedObjectContext: context)
		
		//создаем экземпляр
		let car = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: context)
		
		//добавляем значения в марк
		car.setValue(mark, forKey: "mark")
		
		//сохранить внесенные изменения
		do {
			try context.save()
			cars.append(car)
		} catch let error as NSError {
			print("Localized error \(error.localizedDescription)")
		}
	}
	
	
}

