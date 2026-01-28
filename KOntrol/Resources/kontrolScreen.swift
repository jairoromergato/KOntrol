
import SwiftUI

extension View {
    func kontrolScreen() -> some View {
        self
            .background(AppColors.background)
            .tint(AppColors.primaryButton)
    }

    func kontrolPrimaryButton() -> some View {
        self
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(AppColors.primaryButton)
            .foregroundColor(.white)
            .cornerRadius(14)
    }
}
