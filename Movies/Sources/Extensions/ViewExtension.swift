//
//  ViewExtension.swift
//  Movies
//
//  Created by Dursun YILDIZ on 30.05.2024.
//

import SwiftUI
extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }

    func isLoading(isShow: Binding<Bool>) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay(
                ZStack {
                    if isShow.wrappedValue {
                        GeometryReader { _ in
//                            let size = proxy.size
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .opacity(0.8)
                                .edgesIgnoringSafeArea(.all)

                            ZStack {
                                RotatingDotsIndicatorView(count: 5)
                            }.padding(.horizontal)

                                .frame(maxHeight: getRect().height * 0.3)
                                .cornerRadius(14)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        }
                    }
                }
            )

            .animation(.easeInOut, value: isShow.wrappedValue)
    }
}

struct RotatingDotsIndicatorView: View {
    let count: Int

    var body: some View {
        GeometryReader { geometry in
            ForEach(0 ..< count, id: \.self) { index in
                RotatingDotsIndicatorItemView(index: index, size: geometry.size)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct RotatingDotsIndicatorItemView: View {
    let index: Int
    let size: CGSize

    @State private var scale: CGFloat = 0
    @State private var rotation: Double = 0

    var body: some View {
        let animation = Animation
            .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
            .repeatForever(autoreverses: false)

        return Circle()
            .fill(Color.purple)
            .frame(width: size.width / 5, height: size.height / 5)
            .scaleEffect(scale)
            .offset(y: size.width / 10 - size.height / 2)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                rotation = 0
                scale = (5 - CGFloat(index)) / 5
                withAnimation(animation) {
                    rotation = 360
                    scale = (1 + CGFloat(index)) / 5
                }
            }
    }
}
