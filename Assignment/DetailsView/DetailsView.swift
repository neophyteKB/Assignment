//
//  DetailsView.swift
//  Assignment
//
//  Created by Kamal Kishor on 07/12/24.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject var viewModel: DetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: 8.0
            ) {
                titleView
                contentView
                detailedView
                moreInfo
                sourceCardView
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
    
    private var titleView: some View {
        Text(self.viewModel.title)
            .font(.title2)
            .fontWeight(.bold)
    }
    
    private var contentView: some View {
        Text(self.viewModel.content)
            .font(.title3)
            .fontWeight(.semibold)
    }
    
    @ViewBuilder
    private var detailedView: some View {
        if let description = self.viewModel.desc {
            Text(description)
                .font(.body)
                .fontWeight(.regular)
        }
    }
    
    private var moreInfo: some View {
        HStack {
            articleLink
            Spacer()
            publishedDate
        }
    }
    
    private var sourceCardView: some View {
        FeedCardView(
            icon: self.viewModel.source.icon,
            title: self.viewModel.source.name,
            sourceUrl: self.viewModel.source.url
        )
        .padding(.vertical, 4.0)
        .padding(.top)
    }
    
    @ViewBuilder
    private var articleLink: some View {
        if let linkUrl =  URL(string: viewModel.link) {
            Button(action: {
                UIApplication.shared.open(linkUrl)
            }, label: {
                Text("Read More")
                    .font(.body)
                    .foregroundStyle(.primary)
                    .underline(true, color: .primary)
            })
        }
    }
    
    private var publishedDate: some View {
        Text(viewModel.dateString)
            .font(.body)
    }
}

#Preview {
    DetailsView(
        viewModel: .init(
            title: "Signing day momentum?",
            content: "ONLY AVAILABLE IN PAID PLANS",
            desc: "North Texas is headed into a key point in its efforts to build for the future with momentum on its side.",
            link: "https://dentonrc.com/signing-day-momentum/article_4d344750-b13a-11ef-b2f1-b713f4082f3a.html",
            source: .init(
                name: "Denton Record-chronicle",
                icon: "https://i.bytvi.com/domain_icons/dentonrc.jpg",
                url: "https://dentonrc.com"
            ),
            dateString: "12 Jun 2024"
        )
    )
}
