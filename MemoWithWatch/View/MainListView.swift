//
//  MainListView.swift
//  MemoWithWatch
//
//  Created by semini on 2023/07/19.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var store : MemoStore
    @State private var showComposer : Bool = false
    var body: some View {
        NavigationView{
            List(store.list){memo in
                NavigationLink{
                    DetailView(memo: memo)
                } label: {
                    VStack(alignment : .leading){
                        Text(memo.content)
                        Text(memo.insertDate, style: .date)
                    }
                }
                
                
            }
            .navigationTitle("내메모")
            .toolbar {
                Button{
                    showComposer = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showComposer) {
                ComposeView()
            }
        }
        
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
            .environmentObject(MemoStore())
    }
}
