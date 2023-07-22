//
//  MemoStore.swift
//  MemoWithWatch
//
//  Created by semini on 2023/07/19.
//

import Foundation
import WatchConnectivity

class MemoStore : NSObject, WCSessionDelegate,ObservableObject {
    
    static let shared = MemoStore()
    @Published var path : [Memo] = []
    
    func navigateToMain() {
        path = []
    }
        
    var recieveMemo : [String : Any]
    @Published var list : [Memo]
    var session : WCSession
    
    init(session : WCSession = .default) {
        list = [
        Memo(content: "Hello"),
        Memo(content: "Hello1"),
        Memo(content: "Hello2")]
        
        self.session = session
        self.recieveMemo = ["id": UUID().uuidString, "content" : "nullContents", "insertDate" : Int(Date().timeIntervalSince1970)]
        super.init()
        self.session.delegate = self
        session.activate()
        

    }
    
    func insert(memo:String) {
        list.insert(Memo(content: memo), at :0)
    }
    
    func update(memo:Memo?, content:String) {
        guard let memo = memo else {
            return
        }
        memo.content = content
    }
    
    func delete(memo:Memo){
        list.removeAll {$0.id == memo.id}
    }
    
    func delete(set : IndexSet){
        for index in set{
            list.remove(at: index)
        }
    }
    
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ){
        
    }
    
    func session(_ session : WCSession, didReceiveMessage message : [String:Any]){
        DispatchQueue.main.async {
            print("Received message: \(message)")
            self.recieveMemo = message["watchToIOS"] as? [String:Any] ?? ["id": UUID().uuidString, "content" : "nullContents", "insertDate" : Int(Date().timeIntervalSince1970)]
            let newMemo = Memo(id : UUID(uuidString: self.recieveMemo["id"] as! String)!,
                               content: self.recieveMemo["content"] as! String,
                               insertDate: Date(timeIntervalSince1970: Double(self.recieveMemo["insertDate"] as! Int)))
            print("Adding memo: \(newMemo)")
            self.list.insert(newMemo, at :0)
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
}
