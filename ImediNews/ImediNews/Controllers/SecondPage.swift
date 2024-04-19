//
//  SecondPage.swift
//  ImediNews
//
//  Created by Default on 19.04.24.
//

import UIKit

class SecondPage: UIViewController {

    let viewForDetails: UIView = {
       let vm = UIView()
        vm.translatesAutoresizingMaskIntoConstraints = false
        return vm
    }()
    
    let textForDetails: UILabel = {
        let txt = UILabel()
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let imageForDetails: UIImageView = {
        let im = UIImageView()
        im.translatesAutoresizingMaskIntoConstraints = false
        return im
    }()
    
    let textForDate: UILabel = {
        let txt = UILabel()
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let textBoxForDetails: UITextView = {
        let tx = UITextView()
        tx.translatesAutoresizingMaskIntoConstraints = false
        return tx
    }()
    
    var newsItem: imediNewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintForviewForDetails()
        updateUI()
    }

    func updateUI() {
            guard let newsItem = newsItem else { return }
            textForDetails.text = newsItem.Title
            textForDate.text = newsItem.Time
        if let photoURL = newsItem.PhotoUrl {
            URLSession.shared.dataTask(with: photoURL) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.imageForDetails.image = image
                    }
                } else {
                    print("Error downloading image:", error?.localizedDescription ?? "Unknown error")
                }
            }.resume()
        } else {
            imageForDetails.image = UIImage(named: "Image")
        }
        }
    func constraintForviewForDetails() {
        self.view.addSubview(viewForDetails)
        viewForDetails.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        viewForDetails.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        viewForDetails.backgroundColor = UIColor.white
        viewForDetails.addSubview(textForDetails)
        constraintForTextForDetails()
        viewForDetails.addSubview(imageForDetails)
        constraintForImageForDetails()
        viewForDetails.addSubview(textForDate)
        constraintForTextForDate()
        viewForDetails.addSubview(textBoxForDetails)
        constrainttextBoxForDetails()
    }
    
    
    func constraintForTextForDetails() {
        textForDetails.widthAnchor.constraint(equalToConstant: 80).isActive = true
        textForDetails.heightAnchor.constraint(equalToConstant: 31).isActive = true
        textForDetails.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        textForDetails.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        textForDetails.font = UIFont(name: "SpaceGrotesk-Bold", size: 24)
        textForDetails.textAlignment = .center
        textForDetails.numberOfLines = 0
        textForDetails.textColor = UIColor.black
        //textForDetails.backgroundColor = UIColor.blue
        textForDetails.text = "Details"
    }
    
    func constraintForImageForDetails() {
        imageForDetails.widthAnchor.constraint(equalToConstant: 327).isActive = true
        imageForDetails.heightAnchor.constraint(equalToConstant: 190).isActive = true
        imageForDetails.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 111).isActive = true
        imageForDetails.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        //imageForDetails.backgroundColor = UIColor.yellow
        imageForDetails.layer.cornerRadius = 15
    }
    
    func constraintForTextForDate() {
        textForDate.widthAnchor.constraint(equalToConstant: 50).isActive = true
        textForDate.heightAnchor.constraint(equalToConstant: 19).isActive = true
        textForDate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 314).isActive = true
        textForDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 313).isActive = true
        textForDate.font = UIFont(name: "FiraGO", size: 16)
        textForDate.textAlignment = .right
        textForDate.numberOfLines = 0
        textForDate.lineBreakMode = .byWordWrapping
        //textForDate.backgroundColor = UIColor.gray
    }
    
    func constrainttextBoxForDetails() {
        textBoxForDetails.widthAnchor.constraint(equalToConstant: 303).isActive = true
        textBoxForDetails.heightAnchor.constraint(equalToConstant: 287).isActive = true
        textBoxForDetails.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 359).isActive = true
        textBoxForDetails.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36).isActive = true
        textBoxForDetails.font = UIFont(name: "FiraGO", size: 16)
        textBoxForDetails.textAlignment = .right
        textBoxForDetails.textColor = UIColor.black
        //textBoxForDetails.backgroundColor = UIColor.brown
    }
}
