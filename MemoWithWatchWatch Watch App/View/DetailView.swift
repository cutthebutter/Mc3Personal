//
//  DetailView.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/19.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var store : MemoStore
    @State var memo : Memo
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd HH:mm"
        return formatter
    }()
    
    
    var body: some View {
        VStack{
            Text(memo.category)
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
                Text(dateFormatter.string(from: memo.insertDate))
            }
        }
        
    }

}
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(memo: Memo(content: "hi"))
//            .environmentObject(MemoStore())
//    }
//}
