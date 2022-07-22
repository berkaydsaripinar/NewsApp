//
//  NewsData.swift
//  NewsApp
//
//  Created by Muhammadjon Loves on 7/6/22.
//

import Foundation

struct NewsData: Codable {
    let status: String?
    let articles: [Articles]
}

struct Articles: Codable {
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    
}
