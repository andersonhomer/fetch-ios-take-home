import Foundation
import SwiftUI

public struct Images {
 
    static let refreshIcon = Image("ArrowClockWise")
    static let filterIcon = Image("Filter")
    static let forkAndKnife = Image("ForkAndKnife")
    static let error = Image("Error")

    public enum Variant {
        case multi
        case mono
    }
    
    struct Display: View {
        var image: Image
        var variant: Variant = .mono
        
        public var body: some View {
            image
                .resizable()
                .scaledToFit()
                .symbolRenderingMode(.palette)
                .if(variant == .mono) { view in
                    view.foregroundStyle(Branding.monoColor, Branding.monoColor)
                }
                .foregroundStyle(Branding.iconColor, Branding.secondaryColor)
        }
    }
    
    struct Icons {
        
        struct ToolBarIcons: View {
            var image: Image
            
            public var body: some View {
                image
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Branding.iconColor, Branding.iconColor)
            }
        }
    }
}


