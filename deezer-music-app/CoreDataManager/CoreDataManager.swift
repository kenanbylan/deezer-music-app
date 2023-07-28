//
//  CoreDataManager.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.
//

import Foundation
import CoreData


final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init(){  }
    
    let entityName = "Favorites"
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: entityName) // CoreData modelinizin adını buraya yazın
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                print("Core Data Error: \(error)")
            }
        })
        return container
    }()
    
    
    func isTrackFavorite(id: Int64) -> Bool {
        let fetchRequest = NSFetchRequest<Favorites>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let existingTracks = try context.fetch(fetchRequest)
            return existingTracks.first != nil
        } catch {
            print("Error fetching existing tracks: \(error)")
            return false
        }
    }

    
    
}

//MARK: Favorite add Tracks.

extension CoreDataManager {
    
    func addFavoriteTrack(data: AlbumDetailTrackListData, completion: @escaping (Result<String, Error>) -> Void) {
        guard let id = data.trackId else { return }
        
        if isTrackFavorite(id: Int64(id) ) {
            let errorMessage = "Already Favorites list."
            let error = NSError(domain: "Error:", code: 1001, userInfo: [NSLocalizedDescriptionKey: errorMessage])
            completion(.failure(error))
            
        } else {
            let favoriteTrack = Favorites(context: context)
        
            favoriteTrack.id = Int64(id)
            favoriteTrack.albumName = data.title
            favoriteTrack.artistName = data.artistName
            favoriteTrack.image = data.albumImage
            favoriteTrack.duration = data.duration?.formatDuration() //MARK: will be look.
            favoriteTrack.link = data.link
            favoriteTrack.preview = data.preview
            favoriteTrack.title = data.title
            
            saveContext()
            print("Favorite eklenen bilgiler:",favoriteTrack)
            completion(.success("success track to favorite."))
        }
    }
}

//MARK: -Remove Favorite Tracks.

extension CoreDataManager {
    
    func removeFavoriteTrack(id: Int,completion: @escaping (Result<String, Error>) -> Void) {
        
        let fetchRequest = NSFetchRequest<Favorites>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        
        if isTrackFavorite(id: Int64(id)) {
            
            do {
                let favoriteTracks = try context.fetch(fetchRequest)
                for favoriteTrack in favoriteTracks {
                    context.delete(favoriteTrack)
                }
                saveContext()
                completion(.success("Favorite removed successfully."))
                print("Core datadan success remove", id)
            } catch {
                completion(.failure(error))
                print("Silinirken bir hata çıtkı: ", error)
            }
        } else {
            print("Not deleted: iD: ", id)
            
            let errorMessage = "Already not exist this music in the favorite list."
            let error = NSError(domain: "Error: ", code: 1001, userInfo: [NSLocalizedDescriptionKey: errorMessage])
            completion(.failure(error))
        }
    }
}

//MARK: -Fetch Favorite Tracks.

extension CoreDataManager {
    
    //MARK: Convert Favorites to AlbumDetailTrackListData and Fetch Data
    
    func fetchFavoriteTracks() -> [AlbumDetailTrackListData] {
        var favoritesList: [AlbumDetailTrackListData] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let favoriteTracks = try context.fetch(fetchRequest)
            for fav in favoriteTracks as! [NSManagedObject] {
                favoritesList.append(AlbumDetailTrackListData(
                    id: fav.value(forKey: "id") as! Double,
                    albumImage: fav.value(forKey: "image") as? String,
                    trackId: fav.value(forKey: "id") as? Int,
                    title: fav.value(forKey: "title") as? String,
                    duration: (fav.value(forKey: "duration") as? Int),
                    preview: fav.value(forKey: "preview") as? String ,
                    artistName: fav.value(forKey:"artistName") as? String,
                    albumName: (fav.value(forKey:"albumName") as? String),
                    link: (fav.value(forKey: "link") as? String)))
            }
        } catch {
            print("Error fetching favorite tracks: \(error)")
            return []
        }
        return favoritesList
    }
}

//MARK: SaveContext

extension CoreDataManager {
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}
