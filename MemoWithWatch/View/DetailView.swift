//
//  DetailView.swift
//  MemoWithWatch
//
//  Created by semini on 2023/07/19.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var memo : Memo
    @EnvironmentObject var store : MemoStore
    @State private var showCompose = false
    
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    Text("category")
                    Text(memo.category)
                    Text("content")
                    HStack {
                        Text(memo.content)
                            .padding()
                        Spacer()
                    }
                    Text(memo.insertDate,style: .date)
                }.padding()
            }
            
        }
        .navigationTitle("내메모 보기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement : .navigationBarTrailing) {
                Button{
                    showCompose = true
                } label :{
                    Image(systemName: "sqare.and.pencil")
                }
            }
            
        }
        .sheet(isPresented: $showCompose) {
            ComposeView(memo: memo)
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(memo: Memo(content: "hi"))
                .environmentObject(MemoStore())
        }
        
    }
}
