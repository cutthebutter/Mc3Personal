//
//  OpenApp.swift
//  iOSShortcuts
//
//  Created by semini on 2023/07/20.
//

//import Foundation
//import AppIntents
//import SwiftUI
//
//enum NavigationType : String, AppEnum, CaseDisplayRepresentable {
//    case app
//    
//    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Navigation")
//    
//    static var caseDisplayRepresentations: [Self : DisplayRepresentation] = [
//        .app : DisplayRepresentation(title: "App",
//                                     subtitle: "Return to the home page"
//                                    )
//    ]
//}
//
//struct OpenApp: AppIntent {
//    static var title: LocalizedStringResource = "메모 앱 열기"
//    
//    static var description: IntentDescription =
//        IntentDescription("이 단축어는 앱을 빠르게 열 수 있는 단축어입니다.")
//    
//    @ObservedObject var store : MemoStore
//    
//
//    
//    static var openAppWhenRun = true
//    
//    @Parameter(title: "메모앱", description: "앱을 빠르게 열 수 있습니다.", default: .app, requestValueDialog: IntentDialog("앱을 여시겠습니까?"))
//    var navigation: NavigationType
//    
//    static var parameterSummary: some ParameterSummary {
//        
//        Switch(\OpenApp.$navigation) {
//
//            Case(NavigationType.app) {
//                Summary("Open \(\.$navigation)")
//            }
//            DefaultCase {
//                Summary("Open \(\.$navigation)")
//            }
//        }
//    }
//    
//    @MainActor // <-- include if the code needs to be run on the main thread
//    func perform() async throws -> some IntentResult {
//            if navigation == .app {
//                store.navigateToMain()
//            }
//            return .result()
//        
//    }
//
//    
//    
//    
//}
