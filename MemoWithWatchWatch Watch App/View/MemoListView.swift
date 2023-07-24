//
//  MemoListView.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/19.
//

import SwiftUI

struct MemoListView: View {
    @EnvironmentObject var store : MemoStore
    
    var body: some View {
        NavigationView{
            List{
                ForEach(groupData(store.memoList), id: \.0) { key, values in
                    Section(header: Text("\(key)")) {
                        ForEach(values) { memo in
                            NavigationLink{
                                DetailView(memo: memo)
                            } label :{
                                Text(memo.content)
                                    .lineLimit(3)
                            }
                            
                        }
                    }
                }
                
            }
            .navigationTitle("단서록")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
    
    func groupData(_ data: [Memo]) -> [(key: String, value: [Memo])] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        
        let grouped = Dictionary(grouping: data) { (element: Memo) in
            dateFormatter.string(from: element.insertDate)
        }
        return grouped.sorted { $0.key > $1.key }
    }
    
}
//
//struct MemoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemoListView()
//            .environmentObject(MemoStore())
//    }
//}
