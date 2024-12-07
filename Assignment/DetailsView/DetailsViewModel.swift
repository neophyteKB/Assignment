//
//  DetailsViewModel.swift
//  Assignment
//
//  Created by Kamal Kishor on 07/12/24.
//

import Foundation

@MainActor
final class DetailsViewModel: ObservableObject {
    
    var title: String
    var content: String
    var desc: String?
    var link: String
    var source: Source
    var dateString: String
    
    init(
        title: String,
        content: String,
        desc: String?,
        link: String,
        source: Source,
        dateString: String) {
            self.title = title
            self.content = content
            self.desc = desc
            self.link = link
            self.source = source
            self.dateString = dateString
        }
}

extension DetailsViewModel {
    struct Source {
        let name: String
        let icon: String?
        let url: String
    }
}
