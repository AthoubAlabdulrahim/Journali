//
//  splash.swift
//  Journali
//
//  Created by Athoub Alabdulrahim on 05/05/1447 AH.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            
            if self.isActive {
                MainView()
                
            }
            else {
                
                
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 10/255, green: 10/255, blue: 20/255),
                                                Color.black]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image("BookLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 100)
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [.orange, .pink, .purple]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: .purple.opacity(0.4), radius: 10, x: 0, y: 5)
                    

                    Text("Journali")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 16)
                    
                    Text("Your thoughts, your story")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(Color.white.opacity(0.8))
                }
                .multilineTextAlignment(.center)
                .padding()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
