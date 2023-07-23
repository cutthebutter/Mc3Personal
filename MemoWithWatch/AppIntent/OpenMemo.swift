//
//  OpenMemo.swift
//  MemoWithWatch
//
//  Created by semini on 2023/07/22.
//

import Foundation
import AppIntents

struct OpenMemo : AppIntent {
    //밖에 보이는 타이틀
    static var title : LocalizedStringResource = "앱 바로가기"
    
    static var description: IntentDescription = IntentDescription("This action will open the selected book in the Booky app or navigate to the home library.")
    
    static var openAppWhenRun = true
    //내부에 보이는 작동 타이틀
    static var parameterSummary: some ParameterSummary {
        Summary("앱 열기")
    }
    
    @MainActor
    func perform() async throws -> some IntentResult {
        MemoStore.shared.navigateToMain()
        return .result()
    }
    
}
