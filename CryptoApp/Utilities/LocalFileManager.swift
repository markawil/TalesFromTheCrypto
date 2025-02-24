//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/23/25.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() {}
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        // create the folder if needed to store images
        createFolderIfNeeded(folderName: folderName)
        
        // get the data and the url needed to save the image to the folder
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName)
                else { return }
        
        // save the image data to a file
        do {
             try data.write(to: url)
        } catch (let error) {
            print("Error saving image: \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName),
            !FileManager.default.fileExists(atPath: url.path) else {
            return
        }
        
        do {
            try FileManager.default.createDirectory(at: url,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
        } catch (let error) {
            print("Error creating folder for: \(folderName) with error: \(error)")
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let url = getURLForFolder(folderName: folderName) else {
            return nil
        }
        
        return url.appendingPathComponent(imageName + ".png")
    }
}
