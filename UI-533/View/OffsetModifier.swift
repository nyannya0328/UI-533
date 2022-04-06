//
//  OffsetModifier.swift
//  UI-533
//
//  Created by nyannyan0328 on 2022/04/06.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    @Binding var offset : CGFloat
    func body(content: Content) -> some View {
        content
            .overlay {
                
                GeometryReader{proxy in
                    
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                }
                .onPreferenceChange(OffsetKey.self) { value in
                    self.offset = value
                }
            }
    }
}

struct OffsetKey : PreferenceKey{
    
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
