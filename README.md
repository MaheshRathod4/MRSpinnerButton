
# MRSpinnerButton

Custom loader button which is written in pure swiftUI and works on iOS, macOS,iPadOS,watchOS and tvOS. 

## iOS Demo

![ezgif com-video-to-gif](https://user-images.githubusercontent.com/68275505/229348656-880dd3b3-238a-4b4a-aead-4acc91c6a02f.gif)

## macOS Demo

![ezgif com-video-to-gif](https://user-images.githubusercontent.com/68275505/229348709-9b2f30ff-626d-4865-95cd-16d61fcfd901.gif)

## Requirements 

- iOS 14.0+ / macOS 12.0+ / tvOS 14.0+ / watchOS 8.0+ (if you use it in SwiftUI)


## Installation

- File > Swift Packages - Add Package Dependency
Add https://github.com/MaheshRathod4/MRSpinnerButton

## Features

- Three types of animation 
- Support any some view
- Support on iOS,iPadOS,macOS,tvOS,watchOS 


## Usage/Examples 1

```swift
import SwiftUI
import MRSpinnerButton

struct ContentView: View {
    
    @State var lodingState:LoadingState = .none
    
    var body: some View {
        VStack(spacing: 20) {
            MRSpinnerButton(content: {
                // MARK :- some View
                Text("Login")
                    .foregroundColor(.white)
            }, loadingState: $lodingState, loadingType: .simple, width: 120, height: 60, color: .teal, loaderColor: .white)
            
            // MARK :- Don't forgot to add withAnimation
            HStack {
                Button {
                    withAnimation {
                        lodingState = .fail
                    }
                } label: {
                    Text("Error")
                }
                Button {
                    withAnimation {
                        lodingState = .isLoading
                    }
                } label: {
                    Text("Start")
                }
                Button {
                    withAnimation {
                        lodingState = .success
                    }
                } label: {
                    Text("Success")
                }
            }
            .padding(.top,16)
        }
    }
}


```

## Usage/Examples 2

```swift 

struct ContentView: View {
    
    @State var lodingState:LoadingState = .none
    
    var body: some View {
        VStack(spacing: 20) {
    
            MRSpinnerButton(content: {
                // MARK :- some View
                HStack {
                    Image(systemName: "square.and.arrow.up.fill")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                    Text("Halfball")
                        .foregroundColor(.white)
                }
            }, loadingState: $lodingState, loadingType: .halfBall, width: 160, height: 60, cornerRadius: 20, color: .orange, loaderColor: .white)
            
            // MARK :- Don't forgot to add withAnimation
            HStack {
                Button {
                    withAnimation {
                        lodingState = .fail
                    }
                } label: {
                    Text("Error")
                }
                Button {
                    withAnimation {
                        lodingState = .isLoading
                    }
                } label: {
                    Text("Start")
                }
                Button {
                    withAnimation {
                        lodingState = .success
                    }
                } label: {
                    Text("Success")
                }
            }
            .padding(.top,16)
        }
    }
}
```

## Usage/Examples 3

```swift

struct ContentView: View {
    
    @State var lodingState:LoadingState = .none
    
    var body: some View {
        VStack(spacing: 20) {
            MRSpinnerButton(content: {
                 // MARK :- some View
                VStack {
                    Image(systemName: "square.and.arrow.down.fill")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                    Text("Circle Stroke")
                        .foregroundColor(.white)
                }
            }, loadingState: $lodingState, loadingType: .circleStroke, width: 150, height: 60, color: .pink, loaderColor: .white)
            
             // MARK :- Don't forgot to add withAnimation
            HStack {
                Button {
                    withAnimation {
                        lodingState = .fail
                    }
                } label: {
                    Text("Error")
                }
                Button {
                    withAnimation {
                        lodingState = .isLoading
                    }
                } label: {
                    Text("Start")
                }
                Button {
                    withAnimation {
                        lodingState = .success
                    }
                } label: {
                    Text("Success")
                }
            }
            .padding(.top,16)
        }
    }
}

```

## Meta

- Distributed under the MIT license. See LICENSE for more information.
## Inspired
https://github.com/SimformSolutionsPvtLtd/SSSpinnerButton
