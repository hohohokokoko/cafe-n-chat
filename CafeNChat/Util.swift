//
//  Util.swift
//  CafeNChat
//
//  Created by Yutong Zhang on 12/5/21.
//

import Foundation
import UIKit

class DataModel {
    static let ids = Array(0..<20)
    static let names = ["Super Student", "Perfect Blue", "Coffee King", "Cat Guy",
                        "Green Monster", "Fluffy Cat", "Blade Runner", "Cute People",
                        "Friendly Cat", "Sleepy Cat", "Great Chatter", "Bule Angel",
                        "Friendly Deer", "Sleepy Sheep", "Great Person", "Bule Rabbit",
                        "Friendly Flower", "Sleepy Kitty", "Great Unicorn", "Bule Bird",].shuffled()
    static let pictures = [UIImage(named: "boy1"), UIImage(named: "boy2"), UIImage(named: "boy3"),
                           UIImage(named: "boy4"), UIImage(named: "girl1"), UIImage(named: "girl2"),
                           UIImage(named: "girl3"), UIImage(named: "girl4"), UIImage(named: "girl5"),
                           UIImage(named: "cat"), UIImage(named: "dog"), UIImage(named: "logo"),
                           UIImage(named: "pig"), UIImage(named: "sheep"), UIImage(named: "dk"),
                           UIImage(named: "rbt"), UIImage(named: "hs"), UIImage(named: "kitty"),
                           UIImage(named: "giraffe"), UIImage(named: "ck")].shuffled()
    static let cells = [3, 5, 10, 15, 20, 45, 50, 60,
                        90, 95, 100, 105, 19, 13, 66, 77,
                        89, 120, 7, 8].sorted()
    static let subs = ["Academic", "Career", "Emotion", "Academic",
                       "Life", "Career", "Emotion", "Academic",
                       "Career", "Emotion", "Life", "Emotion",
                       "Academic", "Career", "Emotion", "Academic",
                       "Life", "Career", "Emotion", "Academic"]
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL1 = DocumentsDirectory.appendingPathComponent("DataFile")
    static let ArchiveURL2 = DocumentsDirectory.appendingPathComponent("LocDataFile")
    
    static func saveData(_ achieveDatesList: [Int]) -> Bool {
        var outputData = Data()
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(achieveDatesList) {
            if let items = String(data: encoded, encoding: .utf8) {
                print(items.count) // print json detaion with print(json)
                outputData = encoded
            }
            else { return false }
            
            do {
                try outputData.write(to: ArchiveURL1)
            } catch let error as NSError {
                print (error)
                return false
            }
            return true
        }
        else { return false }
    }
    
    static func loadData() -> [Int]? {
        let decoder = JSONDecoder()
        var achieveDatesList = [Int]()
        let tempData: Data
        
        do {
            tempData = try Data(contentsOf: ArchiveURL1)
        } catch let error as NSError {
            print(error)
            return nil
        }
        if let decoded = try? decoder.decode([Int].self, from: tempData) {
            for i in 0...decoded.count - 1 {
                print("ID \(decoded[i]) LOADED!")
            }
            achieveDatesList = decoded
        }
        return achieveDatesList
    }
    
    static func saveLoc(_ achieveDatesList: [String]) -> Bool {
        var outputData = Data()
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(achieveDatesList) {
            if let items = String(data: encoded, encoding: .utf8) {
                print(items.count) // print json detaion with print(json)
                outputData = encoded
            }
            else { return false }
            
            do {
                try outputData.write(to: ArchiveURL2)
            } catch let error as NSError {
                print (error)
                return false
            }
            return true
        }
        else { return false }
    }
    
    static func loadLoc() -> [String]? {
        let decoder = JSONDecoder()
        var achieveDatesList = [String]()
        let tempData: Data
        
        do {
            tempData = try Data(contentsOf: ArchiveURL2)
        } catch let error as NSError {
            print(error)
            return nil
        }
        if let decoded = try? decoder.decode([String].self, from: tempData) {
            for i in 0...decoded.count - 1 {
                print("Location \(decoded[i]) LOADED!")
            }
            achieveDatesList = decoded
        }
        return achieveDatesList
    }
}

// for resizing UIImage
public extension UIImage {
    // resize image
    func getResizedImage(newSize: CGSize, retina: Bool = true) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            /* size: */ newSize,
            /* opaque: */ false,
            /* scale: */ retina ? 0 : 1
        )
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
     
    // scale image
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let newSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return getResizedImage(newSize: newSize)!
    }
    
    // compress the image
    func compressImage()->UIImage {
        if (self.size.width > 144 || self.size.height > 144) {
            let scale = min(144.0/self.size.width, 144.0/self.size.height)
            return scaleImage(scaleSize: scale)
        }
        return self
    }
}

public extension UIImage {
    func copy(newSize: CGSize, retina: Bool = true) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            /* size: */ newSize,
            /* opaque: */ false,
            /* scale: */ retina ? 0 : 1
        )
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
