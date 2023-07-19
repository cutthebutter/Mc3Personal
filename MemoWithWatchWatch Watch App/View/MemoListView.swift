//
//  MemoListView.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/19.
//

import SwiftUI

struct MemoListView: View {
    @EnvironmentObject var store : MemoStoreW

    var body: some View {
        NavigationView{
            List{
                ForEach(store.memoList){ memo in
                    NavigationLink{
                        DetailView(memo: memo)
                    } label :{
                        Text(memo.content)
                            .lineLimit(3)
                    }
                    
                }
            }
            .navigationTitle("Idea List")
            .navigationBarTitleDisplayMode(.inline)
        }


    }
}

struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
            .environmentObject(MemoStoreW())
    }
}
