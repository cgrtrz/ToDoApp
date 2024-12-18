//
//  Popup.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 17/12/2024.
//

import SwiftUI

struct Popup<T: View>: ViewModifier {
    
    let popup: T
    let isPresented: Bool
    let alignment: Alignment
    
    init(isPresented: Bool, alignment: Alignment, @ViewBuilder content: () -> T) {
        self.isPresented = isPresented
        self.alignment = alignment
        self.popup = content()
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(pupupContent())
            //.position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height)
    }
    
    @ViewBuilder private func pupupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                withAnimation(.spring()) {
                    popup
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
                }.transition(.offset(x: 0, y: geometry.belowScreenEdge))
            }
        }
    }
}

private extension GeometryProxy {
    
    var belowScreenEdge: CGFloat {
            UIScreen.main.bounds.height - frame(in: .global).minY
        }
    
}

struct Popup_Previews: PreviewProvider {
    
    static var previews: some View {
        Color.clear
            .modifier(Popup(isPresented: true, alignment: .bottom, content: {
                Color(.secondarySystemBackground)
                    .frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height * 0.085)
                    .padding(.bottom, 50)
            }))
    }
    
    
}
