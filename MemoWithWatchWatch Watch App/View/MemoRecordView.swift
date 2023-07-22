//
//  MemoRecordView.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/19.
//

import SwiftUI

struct MemoRecordView: View {
    @EnvironmentObject var store : MemoStore
    @State private var content : String = ""
    @State var wathchToiOSMemo : [String : Any] = ["a" : "b"]
    
    var body: some View {
        NavigationView{
            VStack {
                Button {
                    presentDictation()
                } label: {
                    Image(systemName: "mic.fill")
                        .font(.title)
                        .padding(15)
                        .background(Color.gray)
                        .mask(Circle())
                    
                }
                .buttonStyle(PlainButtonStyle())
                
                Text("기록시작")
            }
            .navigationTitle("Memo")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                presentDictation()
                
            })
        }
        
        
        
        
    }
    
    
    func presentDictation() {
        let root = WKExtension.shared().rootInterfaceController
        root?.presentTextInputController(withSuggestions: nil, allowedInputMode: .plain) { result in
            if let result = result as? [String], !result.isEmpty {
                let result0 = result[0].replacingOccurrences(of: " ", with: "")
                if result0 != ""{
                    let memo = Memo(content: result[0])
                    store.memoList.insert(memo, at: 0)
                    wathchToiOSMemo = ["id" : memo.id.uuidString,
                                           "content" : memo.content,
                                           "insertDate" : Int(memo.insertDate.timeIntervalSince1970)] as [String : Any]
                    print("Sending message: \(wathchToiOSMemo)")
                    self.store.session.sendMessage(["watchToIOS": wathchToiOSMemo], replyHandler: nil) {(error) in
                        print(error.localizedDescription)
                    }
                }
                
                
            }else {return}
            
            root?.dismissTextInputController()
        }
    }
    
}
struct MemoRecordView_Previews: PreviewProvider {
    static var previews: some View {
        MemoRecordView()
            .environmentObject(MemoStore())
    }
}
