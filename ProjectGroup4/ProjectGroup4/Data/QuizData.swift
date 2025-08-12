//
//  QuizData.swift
//  ProjectGroup4
//
//  Created by 황동혁 on 8/12/25.
//

import Foundation

struct QuizData {
    // 동물 카테고리
    static let animals_easy: [String: String] = [
        "개": "개",
        "고양이": "고양이",
        "거북": "거북",
        "기린": "기린",
        "돼지": "돼지",
        "사자": "사자",
        "소": "소",
        "여우": "여우",
        "원숭이": "원숭이",
        "호랑이": "호랑이"
    ]
    
    static let animals_medium: [String: String] = [
        "나무늘보": "나무늘보",
        "당나귀": "당나귀",
        "라마": "라마",
        "물소": "물소",
        "알파카": "알파카",
        "염소": "염소",
        "울버린": "울버린",
        "카피바라": "카피바라",
        "쿼카": "쿼카",
        "흑염소": "흑염소"
    ]
    
    static let animals_hard: [String: String] = [
        "두공": "두공",
        "라쿤독": "라쿤독",
        "사올라": "사올라",
        "아르마딜로": "아르마딜로",
        "아이아이": "아이아이",
        "오셀롯": "오셀롯",
        "오카피": "오카피",
        "카카포": "카카포",
        "테이퍼": "테이퍼",
        "팡골린": "팡골린"
    ]
    
    // 연예인 카테고리
    static let celebrities_easy: [String: String] = [
        "뷔": "뷔",
        "손예진": "손예진",
        "송중기": "송중기",
        "아이유": "아이유",
        "윤아": "윤아",
        "전지현": "전지현",
        "제니": "제니",
        "지드래곤": "지드래곤",
        "차은우": "차은우",
        "태연": "태연"
    ]
    
    static let celebrities_medium: [String: String] = [
        "류준열": "류준열",
        "민지": "민지",
        "박보검": "박보검",
        "박형식": "박형식",
        "안유진": "안유진",
        "윈터": "윈터",
        "주지훈": "주지훈",
        "카리나": "카리나",
        "박신혜": "박신혜",
        "혜리": "혜리"
    ]
    
    static let celebrities_hard: [String: String] = [
        "공명": "공명",
        "김재중": "김재중",
        "닝닝": "닝닝",
        "리즈": "리즈",
        "붐": "붐",
        "안보현": "안보현",
        "옥택연": "옥택연",
        "유준상": "유준상",
        "정용화": "정용화",
        "한예슬": "한예슬"
    ]
    
    // 브랜드 카테고리
    static let brands_easy: [String: String] = [
        "구글": "구글",
        "나이키": "나이키",
        "맥도날드": "맥도날드",
        "스타벅스": "스타벅스",
        "애플": "애플",
        "삼성": "삼성",
        "유튜브": "유튜브",
        "인스타그램": "인스타그램",
        "페이스북": "페이스북",
        "펩시": "펩시"
    ]
    
    static let brands_medium: [String: String] = [
        "노브랜드": "노브랜드",
        "라코스테": "라코스테",
        "르꼬끄": "르꼬끄",
        "엔비디아": "엔비디아",
        "챔피언": "챔피언",
        "카파": "카파",
        "테슬라": "테슬라",
        "퓨마": "퓨마",
        "프링글스": "프링글스",
        "KFC": "KFC"
    ]
    
    static let brands_hard: [String: String] = [
        "구찌": "구찌",
        "루이비통": "루이비통",
        "버베리": "버베리",
        "벤츠": "벤츠",
        "빈폴": "빈폴",
        "샤넬": "샤넬",
        "아우디": "아우디",
        "입생로랑": "입생로랑",
        "페라리": "페라리",
        "하메스": "하메스"
    ]
    

    enum Category: CaseIterable {
        case animals, celebrities, brands
        
        var name: String {
            switch self {
            case .animals: return "동물"
            case .celebrities: return "연예인"
            case .brands: return "브랜드"
            }
        }
    }
    
    enum Difficulty: CaseIterable {
        case easy, medium, hard
        
        var name: String {
            switch self {
            case .easy: return "하"
            case .medium: return "중"
            case .hard: return "상"
            }
        }
    }
    
    static func getData(category: Category, difficulty: Difficulty) -> [String: String] {
        switch (category, difficulty) {
        case (.animals, .easy): return animals_easy
        case (.animals, .medium): return animals_medium
        case (.animals, .hard): return animals_hard
        case (.celebrities, .easy): return celebrities_easy
        case (.celebrities, .medium): return celebrities_medium
        case (.celebrities, .hard): return celebrities_hard
        case (.brands, .easy): return brands_easy
        case (.brands, .medium): return brands_medium
        case (.brands, .hard): return brands_hard
        }
    }
}

