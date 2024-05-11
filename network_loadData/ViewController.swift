//
//  ViewController.swift
//  network_loadData
//
//  Created by Евгений Сабина on 11.05.24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let networkService = ApiManager.shared
    var todos: [todos] = []
    var tableView: UITableView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
             tableView = UITableView(frame: view.bounds, style: .plain)
             tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
             tableView.dataSource = self
             tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false //
        view.addSubview(tableView)
             
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
                tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])

             loadTodos()
    }
    
    private func loadTodos() {
        networkService.getTodos { result in
            switch result {
            case .success(let posts):
                posts.forEach({ post in
                    print(post.userId)
                    print(post.id)
                    print(post.title)
                    print(post.completed)
                    print("--------------")
                })
                
                DispatchQueue.main.async {
                self.todos = posts
                self.tableView.reloadData()
                                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return todos.count
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                let todo = todos[indexPath.row]
                cell.textLabel?.text = "ID: \(todo.id) // User ID: \(todo.userId) // Title: \(todo.title)"
                cell.textLabel?.numberOfLines = 0 // Разрешить многострочный текст
                cell.textLabel?.lineBreakMode = .byWordWrapping // Переносить текст по словам
                if todo.completed {
                    cell.backgroundColor = UIColor.yellow
                } else {
                    cell.backgroundColor = UIColor.white
                }
                return cell
        }
    
}


