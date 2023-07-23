//
//  ComposeView.swift
//  MemoWithWatch
//
//  Created by semini on 2023/07/19.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store : MemoStore
    @Environment(\.dismiss) var dismiss
    @State private var content : String = ""
    @State var iOStoWatchMemo : [String : Any] = ["a" : "b"]
    @State var newMemo : Memo = Memo(content: "hi")
    @State private var category : String = "None"
    
    var memo : Memo?
    var body: some View {
        NavigationView{
            VStack{
                Text("category")
                    .padding()
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                TextEditor(text:$category)
                    .padding()
                    .onAppear{
                        if let memo = memo{
                            category = memo.category
                        }
                    }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                Text("contents")
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                TextEditor(text: $content)
                    .padding()
                    .onAppear{
                        if let memo = memo{
                            content = memo.content
                        }
                    }
                Spacer()
            }
            .navigationTitle(memo != nil ? "메모편집" : "새 메모")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement : .navigationBarLeading){
                    Button {
                        dismiss()
                    } label :{
                        Text("취소")
                    }
                }
                
                ToolbarItemGroup(placement : .navigationBarTrailing){
                    Button {
                        if let memo = memo{
                            store.update(memo: memo, content: content)
                        } else{
                            newMemo = Memo(category : category, content: content)
                            self.store.list.insert(newMemo, at : 0)
                            iOStoWatchMemo = [
                                "id" : newMemo.id.uuidString,
                                "category" : newMemo.category,
                              "content" : newMemo.content,
                              "insertDate" : Int(newMemo.insertDate.timeIntervalSince1970)] as [String : Any]
                            print("Sending message: \(iOStoWatchMemo)")
                            self.store.session.sendMessage(["iOSToWatch": iOStoWatchMemo], replyHandler: nil) {(error) in
                                print(error.localizedDescription)
                            }
                            dismiss()
                            
                        }
                        
                    } label :{
                        Text("저장")
                    }
                }
            }
        }
    }
}

struct ComposeView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeView()
            .environmentObject(MemoStore())
    }
}
