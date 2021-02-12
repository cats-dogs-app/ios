import Foundation

class FilesManager {
    enum Error: Swift.Error {
        case fileAlreadyExists
        case invalidDirectory
        case writtingFailed
        case fileNotExists
        case readingFailed
    }
    let fileManager: FileManager
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    public func save(fileNamed: String, data: Data) throws {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        print(url)
        print("step = 1")
        if fileManager.fileExists(atPath: url.absoluteString) {
            throw Error.fileAlreadyExists
        }
        print("step = 2")
        do {
            try data.write(to: url)
            print("save successful \(fileNamed)")
        } catch {
            debugPrint(error)
            throw Error.writtingFailed
        }
    }
    private func makeURL(forFileNamed fileName: String) -> URL? {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(fileName)
    }
    
    public func read(fileNamed: String) throws -> Data {
           guard let url = makeURL(forFileNamed: fileNamed) else {
               throw Error.invalidDirectory
           }
/*        print(url)
        print(url.absoluteString)
           guard fileManager.fileExists(atPath: url.absoluteString) else {
               throw Error.fileNotExists
           }*/
           do {
               return try Data(contentsOf: url)
           } catch {
               debugPrint(error)
               throw Error.readingFailed
           }
       }

}

