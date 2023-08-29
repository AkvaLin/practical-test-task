//
//  CustomImageView.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 26.08.2023.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    private var task: URLSessionDataTask!
    private let spinner = UIActivityIndicatorView(style: .medium)
    
    func loadImage(from url: URL?) {
        
        image = nil
        
        addSpinner()
        
        guard let url = url else { return }
        
        if let task = task {
            task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            image = imageFromCache
            removeSpinner()
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data,
                  let newImage = UIImage(data: data)
            else {
                return
            }
            
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
        }
        
        task.resume()
    }
    
    private func addSpinner() {
        addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        spinner.startAnimating()
    }
    
    private func removeSpinner() {
        spinner.removeFromSuperview()
    }
}
