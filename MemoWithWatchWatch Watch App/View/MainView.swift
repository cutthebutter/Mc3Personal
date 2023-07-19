//
//  MainView.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/19.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MemoRecordView()
                .tag(0)
                .navigationTitle("Memo")
            
            MemoListView()
                .tag(1)
                .navigationTitle("Idea List")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
