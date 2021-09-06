//
//  Storage.swift
//  SampleMVVMApp
//
//  Created by Hammad Zafar on 06/09/2021.
//

import Foundation
import RealmSwift

class Storage {
    
    private var realm : Realm!
    
    static let shared = Storage()
    
    private init() {
        do {
            self.realm = try Realm()
        }
        catch  {
            fatalError()
        }
    }
    
    func invalidate() {
        self.realm = nil
    }
    
    func clearAndSaveData(from sequence : [TypiCodeDataModel]) {
        self.deleteAllFromStorage()
        self.saveData(from: sequence)
    }
    
    func getSavedData() -> [TypiCodeDataModel] {
        var results : [TypiCodeDataModel] = []
        let data = self.realm!.objects(TypiCodeDataModel.self)
        
        for item in data {
            results.append(item)
        }
        return results
    }
    
    func saveData(from dataModel: TypiCodeDataModel) {
        DispatchQueue.main.async {
            do {
                self.realm!.beginWrite()
                self.realm!.add(dataModel)
                try self.realm!.commitWrite()
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func saveData(from sequence: [TypiCodeDataModel]) {
        DispatchQueue.main.async {
            do {
                self.realm!.beginWrite()
                self.realm!.add(sequence)
                try self.realm!.commitWrite()
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAllFromStorage() {
        DispatchQueue.main.async {
            do {
                self.realm!.beginWrite()
                self.realm!.deleteAll()
                try self.realm!.commitWrite()
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
   
}

