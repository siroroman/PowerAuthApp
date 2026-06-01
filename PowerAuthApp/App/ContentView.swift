import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
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

            if scenePhase != .active {
                LaunchScreenView()
            }
        }
        .task {
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation(.easeOut(duration: 0.4)) {
                isLaunching = false
            }
        }
    }
}

#Preview {
    ContentView()
}
