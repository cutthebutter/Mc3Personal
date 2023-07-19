//
//  DetailView.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/19.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var store : MemoStoreW
    @ObservedObject var memo : MemoW
    var body: some View {
        VStack{
            ScrollView{
                HStack{
                    Text(memo.content)
                        .padding()
                    Spacer()
                }
                
            }
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color.gray))

            HStack{
                Spacer()
                Text(memo.insertDate, style: .date)
            }
        }
        
    }
}
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(memo: MemoW(content: "hi"))
            .environmentObject(MemoStoreW())
    }
}
