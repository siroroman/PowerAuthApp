import SwiftUI

extension View {
    func navigationBackDisabled() -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .background(SwipeBackDisabler())
    }
}

private struct SwipeBackDisabler: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        uiViewController.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}
