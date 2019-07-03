//
//  SavedConfigurationsTableView.swift
//  IntervalTimer
//
//  Created by David Hakanson on 7/26/17.
//  Copyright © 2017 David Hakanson. All rights reserved.
//

import UIKit
import CoreData

class SavedConfigurationsTableView: UITableView {

    let cellIdentifier = "SavedConfigurationTableViewCell"
    var configurations: [TimerConfig] = []
    var configurationSelected: ((TimerConfig) -> Void)?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.tableFooterView = UIView()
        self.layer.borderColor = ApplicationColors.grey2.cgColor
        self.layer.borderWidth = 1
        
        self.dataSource = self
        self.delegate = self
        
        self.loadData()
    }
    
    func loadData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TimerConfigModel")
        
        do {
            let rawConfigurations = try managedContext.fetch(fetchRequest)
            var configurations: [TimerConfig] = []
            for rawConfiguration in rawConfigurations {
                guard let configuration = TimerConfig(context: rawConfiguration) else { continue }
                configurations.append(configuration)
            }
            self.configurations = configurations
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func add(timerConfig: TimerConfig, reload: Bool) {
        self.configurations.append(timerConfig)
        if reload {
            self.reloadData()
        }
    }
    
}

extension SavedConfigurationsTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.configurations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? SavedConfigurationTableViewCell else {
            fatalError("The dequeued cell is not an instance of \(self.cellIdentifier).")
        }
        cell.configurationLabel.text = self.configurations[indexPath.row].toString()
        cell.selectionStyle = .none
        return cell
    }
    
}

extension SavedConfigurationsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let configurationSelected = self.configurationSelected else { return }
        let configuration = self.configurations[indexPath.row]
        configurationSelected(configuration)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            guard let context = self.configurations.remove(at: indexPath.row).context else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            managedContext.delete(context)
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print(error)
            }
            
            self.reloadData()
        }
    }
    
}









