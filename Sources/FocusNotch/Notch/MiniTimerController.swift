import SwiftUI

struct MiniTimerView: View {
    @ObservedObject var viewModel: PomodoroViewModel
    @AppStorage("workDuration") private var workDuration: Double = 25
    let cornerRadius: CGFloat
    let width: CGFloat

    var body: some View {
        Text(viewModel.formattedTime)
            .font(.custom("Forza Thin", size: 14))
            .foregroundColor(.white)
            .monospacedDigit()
            .frame(width: width - 14, alignment: .leading)
            .frame(maxHeight: .infinity)
            .padding(.leading, 14)
            .background(
                BottomRoundedRect(radius: cornerRadius).fill(.black)
            )
            .frame(width: width)
    }
}

struct CoffeeIconView: View {
    let cornerRadius: CGFloat

    var body: some View {
        Image(systemName: "cup.and.saucer.fill")
            .font(.system(size: 13))
            .foregroundColor(.orange.opacity(0.8))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(
                BottomRoundedRect(radius: cornerRadius).fill(.black)
            )
    }
}

struct FocusIconView: View {
    let cornerRadius: CGFloat

    var body: some View {
        Image(systemName: "flame.fill")
            .font(.system(size: 13))
            .foregroundColor(.red.opacity(0.8))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(
                BottomRoundedRect(radius: cornerRadius).fill(.black)
            )
    }
}
