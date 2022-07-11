//
//  ViewController.swift
//  To-do App
//
//  Created by Akel Barbosa on 6/07/22.
//

import UIKit

class ViewController: UIViewController {

    private let listCategories: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let addTitleCategorie: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    func setup() {
        view.backgroundColor = .systemBackground
        title = "Lista de actividades"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        let buttonAdd = UIImage(systemName: "plus.circle")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: buttonAdd, style: .done, target: self, action: #selector(addCategorie))
    }
    
    @objc func addCategorie() {

        let addCategorie = UIAlertController(title: "Actividad", message: "Ingrese el nombre de la activadad", preferredStyle: .alert)
        
        addCategorie.addTextField { field in
            field.placeholder = "Agregue la actividad"
        }
        
        addCategorie.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { action in
    
        }))
        
        addCategorie.addAction(UIAlertAction(title: "Agregar", style: .default, handler: { action in
            
            guard let fields = addCategorie.textFields, fields.count == 1 else {return}
            let activityField = fields[0]
            guard let activity = activityField.text, !activity.isEmpty else {return}
            
            let newActivity = Activities(name: activity)
            
            listActivity.append(newActivity)
            DispatchQueue.main.async {
                self.listCategories.reloadData()

            }

        } ))
        
        present(addCategorie, animated: true)
    }
    
    func constraintsElemen() {
        NSLayoutConstraint.activate([
            listCategories.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            listCategories.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listCategories.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            listCategories.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        view.addSubview(listCategories)
        
        listCategories.dataSource = self
        listCategories.delegate = self
        listCategories.register(ActivitiesCell.self, forCellReuseIdentifier: "ActivitiesCell")
        
        constraintsElemen()
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listActivity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActivitiesCell", for: indexPath) as? ActivitiesCell else { return UITableViewCell()}
        
        cell.configure(activity: listActivity[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            listActivity.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.listCategories.reloadData()

            }

        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let addTaskView = AddTask()
        addTaskView.configure(activity: listActivity[indexPath.row], index: indexPath.row)
        navigationController?.pushViewController(addTaskView, animated: true)
        
    }
    
    
}
    


