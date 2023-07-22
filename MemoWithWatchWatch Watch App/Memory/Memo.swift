//
//  MemoW.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/19.
//

import Foundation

class Memo : Identifiable,ObservableObject,Codable {
    let id : UUID
    let content : String
    let insertDate : Date
    
    init(id : UUID = UUID(), content:String, insertDate : Date = Date.now){
        self.id = id
        self.content = content
        self.insertDate = insertDate
    }
}
