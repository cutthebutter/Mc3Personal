//
//  CategorySelectFile.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/23.
//

import SwiftUI

struct CategorySelectView: View {
    @EnvironmentObject var store : MemoStore
    @State var sortedCategories: [String] = []
    @State private var stt : String? = nil
    @Binding var selectedCategory : String?
    @State private var content : String = ""
    @State var wathchToiOSMemo : [String : Any] = ["a" : "b"]
    @State private var moveToMainView = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            List {
                ForEach(sortedCategories, id: \.self) { item in
                    Button {
                        selectedCategory = item
                        dismiss()
                    } label: {
                        Text(item)
                    }
                    
                }
                
            }
            
        }
        .navigationTitle("사건 선택")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            sortedCategories = store.getSortedCategories()
            print(sortedCategories)
        }
    }
    
    
}

//struct CategorySelectFile_Previews: PreviewProvider {
//    static var previews: some View {
//        CategorySelectView(, selectedCategory: <#Binding<String?>#>)
//    }
//}
