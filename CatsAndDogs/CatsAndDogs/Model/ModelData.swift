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
    @Published var pets: [Pet] = loadPets()// = load("pets.json")
    
}

func loadPets() -> [Pet]{
    print("let the load begin !!!! ")
    
    do {
        let data: Data = try FilesManager().read(fileNamed:"petx.json")
        print(String(decoding: data, as: UTF8.self))
        return loadWithData(data)
    }catch FilesManager.Error.fileNotExists{
        print(" file not exits ")
        let data = Data("[]".utf8)
                
        print("dude we did it")
        do {
            try FilesManager().save(fileNamed: "petx.json", data: data)
            
        }
        catch{
            print(error)
        }
        return loadWithData(data)
        
    }catch {
        print(error)
    }
    let data = Data("[]".utf8)
    return loadWithData(data)
}

func load<T: Decodable>(_ filename: String) -> T {
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
