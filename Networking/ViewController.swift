//
//  ViewController.swift
//  Networking
//
//  Created by Alexey Efimov on 25/07/2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func getRequest(_ sender: Any) {
        //проверим валидность нашего адреса
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")  else { return }
        //создаем сессию
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let response = response, let data = data else { return }
            print(response)
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
            
        } .resume()
    }
    
    @IBAction func postRequest(_ sender: Any) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")  else { return }
        //в отличие от гет запроса где мы просто считываем данные в пост запросе мы должны осуществить передачу данных.
        // создаем словарь с данными которые мы и будем передавать на сервер
        let userData = ["Course": "Networking", "Lesson": "Get and Post requests"]
        var request = URLRequest(url: url)
        //прежде чем поместить данные в тело запроса необходимо указать тип запроса
        request.httpMethod = "POST"
        //преобразовываем данные в json формат
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        //есть данные, помещаем их в тело запроса
        request.httpBody = httpBody
        //создаем правило добавления новых записей
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // создаем сессию с задачей для отправки данных на сервер
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response else { return }
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

