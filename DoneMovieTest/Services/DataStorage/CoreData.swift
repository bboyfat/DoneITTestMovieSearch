//
//  CoreData.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContiner:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DoneMovieTest")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error{
                fatalError("Loading of stroe Failed with \(error)")
            }
        }
        return container
    }()
    
}

class CorDataWorker {
    private init() {}
    static let instance = CorDataWorker()
    private let context = CoreDataManager.shared.persistentContiner.viewContext
    var favoriteDidRemoved: () -> () = {}
    
    func fetch() -> [Favorite]{
        let fetchRequset = NSFetchRequest<Favorite>(entityName: "Favorite")
        do{
            let favorite = try context.fetch(fetchRequset)
            return favorite
            
        } catch let fetchErr{
            print("failed, when tried to fetch \(fetchErr)")
        }
        
        return []
    }
    
    func updateFavorites(handler: @escaping(Bool) -> (), m: MovieResponse?){
        isContain(m: m) ? delete(handler: { (bool) in handler(bool)}, m: m) : save(handler: { (bool) in handler(bool)}, m)
    }
    
    private func save(handler: @escaping(Bool) -> (), _ m: MovieResponse?) {
        let favorite = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context) as! Favorite
        favorite.setValue(m?.id, forKey: "id")
        favorite.setValue(m?.title, forKey: "title")
        favorite.setValue(m?.overview, forKey: "overview")
        favorite.setValue(m?.original_title, forKey: "original_title")
        favorite.setValue(m?.poster_path, forKey: "poster_path")
        do{
            try context.save()
            handler(true)
        } catch let saveIncErr {
            print("Failed to save \(saveIncErr)")
        }
    }
    
    func isContain(m: MovieResponse?) -> Bool {
        return self.fetch().map({Int($0.id)}).contains(m?.id)
    }
    
    private func delete(handler: @escaping(Bool) -> (), m: MovieResponse?) {
        guard self.fetch().map({Int($0.id)}).contains(m?.id) else { return }
        self.fetch().filter({Int($0.id) == m?.id}).forEach { (obj) in
            self.context.delete(obj)
            do{
                try context.save()
                self.favoriteDidRemoved()
                handler(false)
            } catch let saveIncErr {
                print("Failed to delete \(saveIncErr)")
            }
        }
        
    }
}

