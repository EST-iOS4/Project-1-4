//
//  QuizData.swift
//  ProjectGroup4
//
//  Created by 황동혁 on 8/12/25.
//

import Foundation

struct QuizData {
    // 동물 카테고리
    static let animals_easy: [ImageName: UserAnswer] = [
        "Dog1": "개",
        "Cat1": "고양이",
        "Turtle1": "거북",
        "Giraffe1": "기린",
        "Pig1": "돼지",
        "Lion1": "사자",
        "Cow1": "소",
        "Fox1": "여우",
        "Monkey1": "원숭이",
        "Tiger1": "호랑이"
    ]
    
    static let animals_medium: [ImageName: UserAnswer] = [
        "Tree2": "나무늘보",
        "Donkey2": "당나귀",
        "Lama2": "라마",
        "Rhino2": "물소",
        "Alpaca2": "알파카",
        "Goat2": "염소",
        "Wolverine2": "울버린",
        "Capybara2": "카피바라",
        "Quokka2": "쿼카",
        "BlackGoat2": "흑염소"
    ]
    
    static let animals_hard: [ImageName: UserAnswer] = [
        "Dugong3": "두공",
        "RaccoonDog3": "라쿤독",
        "Saola3": "사올라",
        "Armadillo3": "아르마딜로",
        "AyeAye3": "아이아이",
        "Ocelot3": "오셀롯",
        "Okapi3": "오카피",
        "Kakapo3": "카카포",
        "Tapir3": "테이퍼",
        "Pangolin3": "팡골린"
    ]
    
    // 연예인 카테고리
    static let celebrities_easy: [ImageName: UserAnswer] = [
        "V1": "뷔",
        "SonYejin1": "손예진",
        "SongJoongki1": "송중기",
        "IU1": "아이유",
        "Yuna1": "윤아",
        "JunJihyun1": "전지현",
        "Jennie1": "제니",
        "GDragon1": "지드래곤",
        "ChaEunwoo1": "차은우",
        "Taeyeon1": "태연"
    ]
    
    static let celebrities_medium: [ImageName: UserAnswer] = [
        "RyuJunyeol2": "류준열",
        "Minji2": "민지",
        "ParkBogum2": "박보검",
        "ParkHyungsik2": "박형식",
        "AnYujin2": "안유진",
        "Winter2": "윈터",
        "JuJihun2": "주지훈",
        "Karina2": "카리나",
        "ParkShinhye2": "박신혜",
        "Hyeri2": "혜리"
    ]
    
    static let celebrities_hard: [ImageName: UserAnswer] = [
        "GongMyung3": "공명",
        "KimJaejoong3": "김재중",
        "Ningning3": "닝닝",
        "Liz3": "리즈",
        "Boom3": "붐",
        "AhnBohyun3": "안보현",
        "OkTaecyeon3": "옥택연",
        "YooJunsang3": "유준상",
        "JungYonghwa3": "정용화",
        "HanYeSeul3": "한예슬"
    ]
    
    // 브랜드 카테고리
    static let brands_easy: [ImageName: UserAnswer] = [
        "Google1": "구글",
        "Nike1": "나이키",
        "McDonalds1": "맥도날드",
        "Starbucks1": "스타벅스",
        "Apple1": "애플",
        "Samsung1": "삼성",
        "Youtube1": "유튜브",
        "Intstar1": "인스타그램",
        "Facebook1": "페이스북",
        "Pepsi1": "펩시"
    ]
    
    static let brands_medium: [ImageName: UserAnswer] = [
        "Nobrand2": "노브랜드",
        "Lacoste2": "라코스테",
        "Lecoq2": "르꼬끄",
        "Nvidia2": "엔비디아",
        "Champion2": "챔피언",
        "Kappa2": "카파",
        "Tesla2": "테슬라",
        "Puma2": "퓨마",
        "Pringles2": "프링글스",
        "Kfc2": "KFC"
    ]
    
    static let brands_hard: [ImageName: UserAnswer] = [
        "Gucci3": "구찌",
        "LouisVuitton3": "루이비통",
        "Burberry3": "버베리",
        "Benz3": "벤츠",
        "Beanpole3": "빈폴",
        "Chanel3": "샤넬",
        "Audi3": "아우디",
        "YvesSaintLaurent3": "입생로랑",
        "Ferrari3": "페라리",
        "Hermes3": "하메스"
    ]
    
    
    typealias ImageName = String
    typealias UserAnswer = String

    enum Category: CaseIterable, Codable {
        case animals, celebrities, brands
        
        var name: String {
            switch self {
            case .animals: return "동물"
            case .celebrities: return "연예인"
            case .brands: return "브랜드"
            }
        }
    }
    
    enum Difficulty: CaseIterable, Codable {
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

