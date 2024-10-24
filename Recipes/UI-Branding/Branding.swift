import SwiftUI

public struct Branding {
    
    static let primaryTextColor: Color = Color("PrimaryTextColor")
    static let cardColor: Color = Color("CardColor")
    static let iconColor: Color = Color("IconColor")
    static let secondaryColor: Color = Color("SecondaryFillColor")
    static let monoColor: Color = Color("MonoColor")
    
    static let gradient: LinearGradient = LinearGradient(
        gradient: Gradient(
            colors: [
                Color("GradientInitialColor"),
                Color("GradientFinalColor")
            ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}


public struct BodyText: View {
    var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(.custom("MontserratRoman-Regular", size: 16))
            .foregroundColor(Branding.primaryTextColor)
    }
}

public struct TitleText: View {
    var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(.custom("MontserratRoman-SemiBold", size: 18))
            .foregroundColor(Branding.primaryTextColor)
    }
}
