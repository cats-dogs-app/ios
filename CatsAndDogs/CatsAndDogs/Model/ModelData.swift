//
//  ModelData.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 8.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var pets: [Pet] = load("pets.json")
    @Published var feeds : [Feed] = load("feeds.json")
    @Published var feedings : [Feeding] = load("feedings.json")
}

func load<T:Decodable>(_ filename: String) -> T{
    
    print("let the load begin !!!! ")
    let emptyData = Data("[]".utf8)

    do {
        let data: Data = try FilesManager().read(fileNamed:filename)
        return loadWithData(data)
        
    }catch FilesManager.Error.fileNotExists{
        do {
            try FilesManager().save(fileNamed: filename, data: emptyData)
        }
        catch{
            print(error)
        }
    }catch {
        print(error)
    }
    return loadWithData(emptyData)
}

func loadFromJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func loadWithData<T: Decodable>(_ data: Data) -> T {
    print(String(decoding: data, as: UTF8.self))
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("broken data")
    }
}
