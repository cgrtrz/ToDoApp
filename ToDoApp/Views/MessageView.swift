//
//  MessageView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 16/12/2024.
//

import SwiftUI

struct MessageView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var message: String
    @Binding var isVisible: Bool
    
    var body: some View {
        if isVisible {
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Theme.PopUp.backgroundColor)
                
                Text(message)
            }.frame(width: Constants.PopUp.width, height: Constants.PopUp.height)
                .position(x: Constants.PopUp.xPosition, y: Constants.PopUp.yPosition)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            //self.isVisible = false
                            //dismiss()
                            self.position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height + 500)
                            //self.popover(isPresented: $isVisible, content: <#T##() -> View#>)
                        }
                    }
                }
        }
    }
}

#Preview {
    MessageView(message: .constant("message"), isVisible: .constant(true))
}
