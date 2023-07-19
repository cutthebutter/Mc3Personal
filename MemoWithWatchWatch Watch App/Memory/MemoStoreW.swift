//
//  MemoStoreW.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/19.
//

import Foundation
import SwiftUI
import WatchConnectivity

class MemoStoreW : NSObject, WCSessionDelegate, ObservableObject {
    
    
    var recieveMemo : [String : Any]
    @Published var memoList: [MemoW]
    var session : WCSession
    
    init(session:WCSession = .default){
        memoList = [
            MemoW(content: "hi"),
            MemoW(content: "hi2")
        ]
        
        self.session = session
        self.recieveMemo = ["id": UUID().uuidString, "content" : "nullContents", "insertDate" : Int(Date().timeIntervalSince1970)]
        super.init()
        self.session.delegate = self
        session.activate()
        

    }

    func insert(memo: String) {
        memoList.insert(MemoW(content: memo), at : 0)
    }
    
    func session(_ session : WCSession, activationDidCompleteWith activationState : WCSessionActivationState, error : Error?){
        
    }
    
    func session(_ session : WCSession, didReceiveMessage message : [String:Any]){
        DispatchQueue.main.async {
            print("Received message: \(message)")
            self.recieveMemo = message["iOSToWatch"] as? [String:Any] ?? ["id": UUID().uuidString, "content" : "nullContents2", "insertDate" : Int(Date().timeIntervalSince1970)]
            let newMemo = MemoW(id : UUID(uuidString: self.recieveMemo["id"] as! String)!,
                                content: self.recieveMemo["content"] as! String,
                                insertDate: Date(timeIntervalSince1970: Double(self.recieveMemo["insertDate"] as! Int)))
            print("Adding memo: \(newMemo)")
            self.memoList.insert(newMemo, at :0)
        }


    }
    
    
    

    
}
