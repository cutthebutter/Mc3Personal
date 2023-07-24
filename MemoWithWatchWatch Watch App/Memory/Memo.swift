//
//  MemoW.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/19.
//

import Foundation

struct Memo : Identifiable {
    let id  : UUID
    let content : String
    let insertDate : Date
    let category : String
    
    init(id : UUID = UUID(), category : String = "None", content:String, insertDate : Date = Date.now){
        self.id = id
        self.content = content
        self.insertDate = insertDate
        self.category = category
    }
}
