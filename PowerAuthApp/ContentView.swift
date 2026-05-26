import SwiftUI

struct ContentView: View {
    @State private var isLaunching = true

    var body: some View {
        ZStack {
            LandingPageView(viewModel: LandingPageViewModel())

            if isLaunching {
                LaunchScreenView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 0.4)) {
                    isLaunching = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
