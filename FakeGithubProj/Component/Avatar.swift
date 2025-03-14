//
//  Avatar.swift
//  FakeGithubProj
//
//  Created by TQ on 2025/3/14.
//

import SwiftUI
import Kingfisher

struct Avatar: View {
    @State private var user: GitHubUser
    
     init(user: GitHubUser) {
         self.user = user
     }
    
    var body: some View {
        VStack(spacing: 8) {
            KFImage(URL(string: user.avatar_url))
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.bottom, 20)
            
            Text(user.name)
                .font(.system(size: 18))
                .foregroundColor(Color(hex: "333333"))
            
            HStack(spacing: 20) {
                Text("Followers: \(user.followers)")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "555555"))
                
                Text("Following: \(user.following)")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "555555"))
            }
        }
    }
}
