//
//  ChatView.swift
//  Text Mee
//
//  Created by Abhirath Sujith on 05/07/22.
//

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject var viewModel: ChatsViewModel
    
    let chat: Chat
    
    @State private var text = ""
    @FocusState private var isFocused
    
    var body: some View {
        VStack(spacing: 0){
            GeometryReader { reader in
                ScrollView {
                    getMessagesView(viewWidth: reader.size.width)
                        .padding(.horizontal)
                }
            }
            .background(Color.cyan)
            
            
            
            toolbarView()
        }
        .padding(.top, 1)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            viewModel.markAsUnread(false, chat: chat)
        }
        
    }
    
    func toolbarView() -> some View {
        VStack {
            let height: CGFloat = 35
            HStack {
                TextField("Message......", text: $text)
                    .padding(.horizontal, 10)
                    .frame(height: height)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .focused($isFocused)
            }
           
        }
        .padding(.vertical)
        .padding(.horizontal)
        .background(.thinMaterial)
    }
    
    let columns = [GridItem(.flexible(minimum: 10))]
    
    func getMessagesView(viewWidth: CGFloat) -> some View {
        LazyVGrid(columns: columns, spacing: 0){
            ForEach(chat.messages) { message in
                let isRecevied = message.type == .Received
                HStack {
                    ZStack{
                        Text(message.text)
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(isRecevied ? Color.yellow.opacity(1) : .orange.opacity(1))
                            .cornerRadius(15)
                    }
                    .frame(width: viewWidth * 0.7, alignment: isRecevied ? .leading : .trailing)
                    .padding(.vertical)
                    //.background(Color.orange)
                   
                }
                .frame(maxWidth: .infinity, alignment: isRecevied ? .leading : .trailing)
                .id(message.id)
            }
        }
    }

}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(chat: Chat.sampleChat[0])
            .environmentObject(ChatsViewModel())
    }
}