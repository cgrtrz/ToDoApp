//
//  ThemeSelectorView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 27/12/2024.
//

import SwiftUI

struct ThemeSelectorView: View {
    var body: some View {
        VStack (alignment: .center){
            Spacer()
        TabView {
            Tab {
                Image("Theme1")
                    .resizable()
                    .scaledToFit()
                    .border(Color.black.opacity(0.2))
            }
            Tab {
                Image("Theme2")
                    .resizable()
                    .scaledToFit()
                    .border(Color.black.opacity(0.2))
            }
            Tab {
                Image("Theme3")
                    .resizable()
                    .scaledToFit()
                    .border(Color.black.opacity(0.2))
            }
            Tab {
                Image("Theme4")
                    .resizable()
                    .scaledToFit()
                    .border(Color.black.opacity(0.2))
            }
            Tab {
                Image("Theme5")
                    .resizable()
                    .scaledToFit()
                    .border(Color.black.opacity(0.2))
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: 200, height: 400)
            Button {
                
            } label: {
                Text("Select Theme")
            }
            .padding()
    }
    }
}

#Preview {
    ThemeSelectorView()
}
