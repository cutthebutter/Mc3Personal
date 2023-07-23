//
//  MemoStoreW.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/19.
//

import Foundation
import SwiftUI
import WatchConnectivity

class MemoStore : NSObject, WCSessionDelegate, ObservableObject {
    
    static let shared = MemoStore()
    @Published var path : [Memo] = []
    //    @Published var sortedCategories : [String]
    
    func navigateToMain() {
        path = []
    }
    
    var recieveMemo : [String : Any]
    @Published var memoList: [Memo]
    
    var session : WCSession
    
    private init(session:WCSession = .default){
        memoList = [
            Memo(content: "hi", insertDate: Date.now - TimeInterval(3600*24)),
            Memo(content: "hi2",insertDate: Date.now - TimeInterval(3600*48))
        ]
        
        self.session = session
        self.recieveMemo = ["id": UUID().uuidString, "category" : "nullCategory",  "content" : "nullContents", "insertDate" : Int(Date().timeIntervalSince1970)]
        super.init()
        self.session.delegate = self
        session.activate()
        //        updateCategories()
        //        sortedCategories = []
    }
    
    
    func getSortedCategories() -> [String] {
        var categories = Set(memoList.map { $0.category })
        return Array(categories).sorted()
    }
    
//
//    var sortedCategories : [String] {
//        var categories = Set(memoList.map { $0.category })
//        return Array(categories).sorted()
//    }
//


    func insert(category : String, content: String) {
        memoList.insert(Memo(category : category, content: content), at : 0)
    }
    
    func session(_ session : WCSession, activationDidCompleteWith activationState : WCSessionActivationState, error : Error?){
        
    }
    
    func session(_ session : WCSession, didReceiveMessage message : [String:Any]){
        DispatchQueue.main.async {
            print("Received message: \(message)")
            self.recieveMemo = message["iOSToWatch"] as? [String:Any] ?? ["id": UUID().uuidString, "category": "nullCategory", "content" : "nullContents2", "insertDate" : Int(Date().timeIntervalSince1970)]
            let newMemo = Memo(id : UUID(uuidString: self.recieveMemo["id"] as! String)!,
                               category: self.recieveMemo["category"] as! String,
                               content: self.recieveMemo["content"] as! String,
                                insertDate: Date(timeIntervalSince1970: Double(self.recieveMemo["insertDate"] as! Int)))
            print("Adding memo: \(newMemo)")
            self.memoList.insert(newMemo, at :0)
        }


    }
    
    
    
    
    

    
}
