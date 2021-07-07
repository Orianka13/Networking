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
    }
    
}

