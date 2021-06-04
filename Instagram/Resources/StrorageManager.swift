//
//  StrorageManager.swift
//  Instagram
//
//  Created by Jitesh gamit on 26/05/21.
//


import FirebaseStorage

public class StorageManager{
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error{
         case FailedToDownload
    }
    
    // Mark: Public
     
    public func uploadUserPhotoPost(model: UserPost, completion: (Result<URL, Error>) -> Void) {
        
    }
    
    public func download(with reference: String, completion: @escaping (Result <URL, IGStorageManagerError>) -> Void){
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else{
                completion(.failure(.FailedToDownload))
                return
            }
            
            completion(.success(url))
        })
}
}




