//
//  AddTask.swift
//  To-do App
//
//  Created by Akel Barbosa on 7/07/22.
//

import UIKit

class AddTask: UIViewController {
    
    var titleForActivity: String?
    var indexForActivity: Int?
    

    private let listTask: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func reloadData() {
            DispatchQueue.main.async {
            self.listTask.reloadData()

        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        title = titleForActivity
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Agregar" , style: .done, target: self, action: #selector(addTasks))
        
        listTask.dataSource = self
        listTask.delegate = self
        listTask.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        
        view.addSubview(listTask)
        
    }
    
    
    @objc func addTasks() {
    
        let addTask = UIAlertController(title: "Tarea", message: "Ingrese el nombre de la tarea a realizar", preferredStyle: .alert)
        
        addTask.addTextField { field in
            field.placeholder = "Agregue la tarea"
        }
        
        
        addTask.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { action in
            print("Cancelaste")
        } ))
        
        addTask.addAction(UIAlertAction(title: "Agregar", style: .default, handler: { action in
            print("Guardaste")
            guard let fields = addTask.textFields, fields.count == 1 else {return}
            let activityField = fields[0]
            guard let activity = activityField.text, !activity.isEmpty else {return}
            
            let newTask = Task(name: activity, make: false)
            listActivity[self.indexForActivity!].tasks.append(newTask)

            DispatchQueue.main.async {
                self.listTask.reloadData()

            }
            print(listActivity[self.indexForActivity!])
            
        
        } ))
        
        present(addTask, animated: true)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listTask.frame = view.bounds
    }
    
    
    func configure(activity: Activities, index: Int) {
        self.titleForActivity = activity.name
        self.indexForActivity = index
    }
    
}

extension AddTask: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = indexForActivity ?? 0
        return listActivity[index].tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else {return UITableViewCell()}
        let index = indexForActivity ?? 0
        cell.configure(Task: listActivity[index].tasks[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexForActivity ?? 0
        listActivity[index].tasks[indexPath.row].make = !listActivity[index].tasks[indexPath.row].make
        reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexForActivity ?? 0
        if editingStyle == .delete {
            listActivity[index].tasks.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.listTask.reloadData()

            }

        }
    }
    
}






