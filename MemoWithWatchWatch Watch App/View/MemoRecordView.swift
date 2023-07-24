//
//  MemoRecordView.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/19.
//

import SwiftUI
import WatchKit

struct MemoRecordView: View {
    @EnvironmentObject var store : MemoStore
    @State private var content : String = ""
    @State var wathchToiOSMemo : [String : Any] = ["a" : "b"]
    @State private var selectedCategory : String?
    @State private var showVoiceRecordView = false
    @State private var stt : String = "None"
    @State private var count = 0
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationView{
            ZStack{
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
                .onChange(of: scenePhase) { (phase) in
                    switch phase {
                    case .active :
                        presentDictation()
                        
                    default : break
                        
                        
                    }
                }

            }
            
            .navigationTitle("사건록")
            .navigationBarTitleDisplayMode(.inline)
            
            .sheet(isPresented: $showVoiceRecordView) {
                CategorySelectView(selectedCategory: $selectedCategory)
                    .onDisappear {
                        
                        if let category = selectedCategory{
                            let memo = Memo(category: category, content: stt)
                            saveMemo(memo)
                        }
                    }
            }
            
            
            
            
        }
        
        
        
    }
    
    
    func presentDictation() {
        let hapticType = WKHapticType.start
        WKInterfaceDevice.current().play(hapticType)
        let root = WKExtension.shared().rootInterfaceController
        root?.presentTextInputController(withSuggestions: nil, allowedInputMode: .plain) { result in
            if let result = result as? [String], !result.isEmpty {
                let result0 = result[0].replacingOccurrences(of: " ", with: "")
                if result0 != "" {
                    stt = result0
                    showVoiceRecordView = true
                }
            }else {return}
            root?.dismissTextInputController()
        }
    }
    
    func saveMemo(_ memo: Memo) {
        store.memoList.insert(memo, at: 0)
        wathchToiOSMemo = ["id" : memo.id.uuidString,
                           "category" : memo.category,
                           "content" : memo.content,
                           "insertDate" : Int(memo.insertDate.timeIntervalSince1970)] as [String : Any]
        print("Sending message: \(wathchToiOSMemo)")
        self.store.session.sendMessage(["watchToIOS": wathchToiOSMemo], replyHandler: nil) {(error) in
            print(error.localizedDescription)
            self.store.session.transferUserInfo(["watchToIOS": wathchToiOSMemo])
        }
    }
    
}
//struct MemoRecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemoRecordView()
//            .environmentObject(store)
//    }
//}
