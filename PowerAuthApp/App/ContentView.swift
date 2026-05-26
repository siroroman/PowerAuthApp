import SwiftUI

struct ContentView: View {
    @State private var isLaunching = true
    @State private var landingVM = LandingPageViewModel()

    var body: some View {
        ZStack {
            NavigationStack {
                LandingPageView(viewModel: landingVM)
            }

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
