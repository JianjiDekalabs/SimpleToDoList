//  Model.swift
//  AgendaAPP
//  Created by Jianji Zhong Huang on 11/10/24.
import Foundation

struct Agenda: Codable, Identifiable {
    var description: String
    var id: UUID = UUID()
    
    init(description: String) {
        self.description = description
    }
   
}

