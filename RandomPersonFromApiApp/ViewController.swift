//
//  ViewController.swift
//  RandomPersonFromApiApp
//
//  Created by Egor Yakovin on 28.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var getPersonButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    var personn: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func getPerson() {
        guard let url = URL(string: "https://randomuser.me/api/") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no error description")
                return
            }
            do {
                let person = try JSONDecoder().decode(Person.self, from: data)
                print(person)
                DispatchQueue.main.async {
                    self.updateUI(with: person)
                    self.updateImage(with: person)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    @IBAction func getPersonButtonPressed() {
        if getPersonButton.currentTitle == "Get random person" {
            getPersonButton.setTitle("Get another person", for: .normal)
        }
        getPerson()
    }
    private func updateUI(with person: Person) {
        self.genderLabel.text = person.results[0].gender
        self.emailLabel.text = person.results[0].email
        self.nameLabel.text = "\(person.results[0].name.first) \(person.results[0].name.last)"
        self.locationLabel.text = "\(person.results[0].location.city), \(person.results[0].location.country)"
    }
    
    private func updateImage(with person: Person) {
        guard let url = URL(string: person.results[0].picture.large) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "no error desription")
                return }
            print(response)
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }.resume()
    }
}

