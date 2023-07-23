//
//  CategorySelectFile.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/23.
//

import SwiftUI

struct CategorySelectFile: View {
    @EnvironmentObject var store : MemoStore
//    var sortedCategoriesList = store.sortedCategories

    
    var body: some View {
        VStack {
//            Picker("category", selection: <#T##Binding<SelectionValue>#>)
        }
    }
    
    
}

struct CategorySelectFile_Previews: PreviewProvider {
    static var previews: some View {
        CategorySelectFile()
            .environmentObject(MemoStore())
    }
}
