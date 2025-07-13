//https://vae.life/archives/bv001
import SwiftUI

struct FullScreenView: View {
    @State var currentFullflag = false
    @State var readyToFull = true
    @State var verticalPosition = 0.0
    let diyAnimation = Animation.spring(
        response: 0.4,
        dampingFraction: 0.8,
        blendDuration: 0
    )
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(.yellow)
                .blur(radius: 80)
                .offset(x: -150, y: 200)
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(.pink)
                .blur(radius: 80)
                .offset(x: 150, y: -100)
            VStack {
                if !currentFullflag {
                    Spacer()
                }
                ZStack {
                    Rectangle()
                        .frame(
                            width: .infinity,
                            height: currentFullflag ? .infinity : 100
                        )
                        .background(.ultraThinMaterial)
                        .opacity(0.5)
                        .cornerRadius(currentFullflag ? 20 : 10)
                        .onTapGesture {
                            withAnimation(diyAnimation) {
                                currentFullflag = true
                                readyToFull = false
                            }
                        }
                    HStack {
                        VStack {
                            Rectangle()
                                .frame(
                                    width: currentFullflag ? 300 : 80,
                                    height: currentFullflag ? 300 : 80
                                )
                                .foregroundColor(.blue)
                                .cornerRadius(currentFullflag ? 20 : 5)
                                .padding(.top, currentFullflag ? 80 : 0)
                            if currentFullflag {
                                Spacer()
                            }
                        }
                        if !currentFullflag {
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .offset(y: currentFullflag ? verticalPosition : 0)
                .padding(.bottom, currentFullflag ? 0 : 100)
                .gesture(gestureVertical())

            }
            .padding(currentFullflag ? 0 : 10)
        }
        .ignoresSafeArea(.all)
    }

    func gestureVertical() -> some Gesture {
        return DragGesture()
            .onChanged { value in
                if !readyToFull {
                    verticalPosition = value.translation.height
                }
                if readyToFull && !currentFullflag
                    && value.translation.height < -50
                {
                    withAnimation(diyAnimation) {
                        currentFullflag = true
                    }
                }

            }
            .onEnded { value in
                if readyToFull {
                    readyToFull.toggle()
                } else {
                    if currentFullflag
                        && value.translation.height > UIScreen.main.bounds
                            .height / 2
                    {
                        withAnimation(diyAnimation) {
                            readyToFull.toggle()
                            verticalPosition = 0
                            currentFullflag = false
                        }
                    } else {
                        withAnimation(diyAnimation) {
                            verticalPosition = 0
                        }
                    }
                }

            }
    }
}

#Preview {
    FullScreenView()
}
