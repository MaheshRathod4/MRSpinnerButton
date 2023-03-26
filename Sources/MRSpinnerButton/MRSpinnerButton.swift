
//
//  MRSpinnerButton.swift
//
//
//  Created by Mahesh Rathod on 26/03/23.
//

import Foundation
import SwiftUI

public struct MRSpinnerButton<Content:View>: View {
    
    @Binding var loadingState:LoadingState
    var loadingType:LoadingType
    var width:CGFloat
    var height:CGFloat
    var color:Color
    let loaderColor:Color
    let content:Content
    let cornerRadius:CGFloat
    
    @State private var innerTrimEnd: CGFloat = 0
    @State private var isCompleteAnimation:Bool = false
    private var animationDuration: Double = 0.75
    private var errorAnimationDuration:Double = 1.0
    @Namespace private var animation
    
    ///  The corner radius have default value
    /// - Parameters:
    ///   - content: The content view of the button
    ///   - loadingState: A loading state (ex. .isLoading)
    ///   - loadingType: A loding type  (ex .simple)
    ///   - width: The width of the button
    ///   - height: The height of the button
    ///   - cornerRadius: corner radius of the button
    ///   - color: content color
    ///   - loaderColor: A loader color
    public init(@ViewBuilder content:() -> Content,
         loadingState: Binding<LoadingState>,
         loadingType:LoadingType,
         width: CGFloat,
         height: CGFloat,
         cornerRadius:CGFloat = 8.0,
         color: Color,
         loaderColor:Color
    ) {
        self.content = content()
        self._loadingState = loadingState
        self.loadingType = loadingType
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.color = color
        self.loaderColor = loaderColor
    }
    
    public var body: some View {
        switch loadingState {
        case .none:
            getDefaultView
        case .isLoading:
            switch loadingType {
            case .simple:
                RoundedRectangle(cornerRadius: height / 2)
                    .matchedGeometryEffect(id: "Shape", in: animation)
                    .foregroundColor(color)
                    .frame(width: height,height: height)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: loaderColor))
                    ).onAppear {
                        withAnimation(.spring()) {
                            self.isCompleteAnimation = false
                            self.innerTrimEnd = 0
                        }
                    }
            case .halfBall:
                RoundedRectangle(cornerRadius: height / 2)
                    .matchedGeometryEffect(id: "Shape", in: animation)
                    .foregroundColor(color)
                    .frame(width: height,height: height)
                    .overlay(
                        HalfBall(color: loaderColor)
                            .frame(width: height / 2 ,height: height / 2)
                    ).onAppear {
                        withAnimation(.spring()) {
                            self.isCompleteAnimation = false
                            self.innerTrimEnd = 0
                        }
                    }
            case .circleStroke:
                RoundedRectangle(cornerRadius: height / 2)
                    .matchedGeometryEffect(id: "Shape", in: animation)
                    .foregroundColor(color)
                    .frame(width: height,height: height)
                    .overlay(
                        CircleStroke(color: loaderColor)
                            .frame(width: height / 2 ,height: height / 2)
                    ).onAppear {
                        withAnimation(.spring()) {
                            self.isCompleteAnimation = false
                            self.innerTrimEnd = 0
                        }
                    }
            }
        case .success:
            getSuccessView
        case .fail:
            getErrorView
        }
    }
}

extension MRSpinnerButton {
    //MARK: - Get Success View
    private var getSuccessView:some View {
        RoundedRectangle(cornerRadius: isCompleteAnimation ? cornerRadius : height / 2)
            .matchedGeometryEffect(id: "Shape", in: animation)
            .foregroundColor(color)
            .frame(width: isCompleteAnimation ? width : height ,height: height)
            .overlay(
                Checkmark()
                    .trim(from: 0, to: innerTrimEnd)
                    .stroke(.white, lineWidth: 2)
                    .frame(width: height / 3,height: height / 3)
            )
            .onAppear {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    self.innerTrimEnd = 1.0
                }
                
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + animationDuration) {
                    withAnimation(.spring()) {
                        self.isCompleteAnimation = true
                        self.loadingState = .none
                    }
                }
            }
    }
    
    private var getErrorView:some View {
        RoundedRectangle(cornerRadius: isCompleteAnimation ? cornerRadius : height / 2)
            .matchedGeometryEffect(id: "Shape", in: animation)
            .foregroundColor(color)
            .frame(width: isCompleteAnimation ? width : height ,height: height)
            .overlay(
                Cross()
                    .trim(from: 0, to: innerTrimEnd)
                    .stroke(.white, lineWidth: 2)
                    .frame(width: height / 3,height: height / 3)
            )
            .onAppear {
                withAnimation(.easeInOut(duration: errorAnimationDuration)) {
                    self.innerTrimEnd = 1.0
                }
                
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + errorAnimationDuration) {
                    withAnimation(.spring()) {
                        self.isCompleteAnimation = true
                        self.loadingState = .none
                    }
                }
            }
    }
    
    private var getDefaultView :some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .matchedGeometryEffect(id: "Shape", in: animation)
            .foregroundColor(color)
            .frame(width: width,height: height)
            .overlay(
                content
                    .frame(width: width,height: height)
            )
    }
}
