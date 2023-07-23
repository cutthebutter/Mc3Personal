//
//  Memo.swift
//  MemoWithWatch
//
//  Created by semini on 2023/07/19.
//

import Foundation
import SwiftUI

class Memo : Identifiable, ObservableObject {
    let id : UUID
    @Published var content : String
    let insertDate : Date
    let category : String
    
    init(id : UUID = UUID(), category : String = "None", content : String , insertDate : Date = Date.now){
        self.id = id
        self.category = category
        self.content = content
        self.insertDate = insertDate
    }
}
