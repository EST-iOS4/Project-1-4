//
//  HistoryList.swift
//  ProjectGroup4
//
//  Created by 김민우 on 8/13/25.
//
import SwiftUI


// MARK: View
struct HistoryList: View {
    let suite: ResultSuite
    
    var body: some View {
        List(suite.results) { result in
            ResultItemView(result: result)
        }
    }
}
