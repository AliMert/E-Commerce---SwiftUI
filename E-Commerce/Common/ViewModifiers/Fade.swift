//
//  Fade.swift
//  E-Commerce
//
//  Created by Ali Mert Özhayta on 28.05.2022.
//

import SwiftUI

public struct Fade: ViewModifier {

    //MARK: Properties

    private let gradient: Gradient
    private let startPoint: UnitPoint
    private let endPoint: UnitPoint

    //MARK: Init

    init(gradient: Gradient? = nil, startPoint: UnitPoint = .bottom, endPoint: UnitPoint = .top) {
        self.gradient = gradient ?? Fade.getDefaultGradient()
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    //MARK: UI

    public func body(content: Content) -> some View {
        content
            .mask((LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)))
    }

    private static func getDefaultGradient() -> Gradient {
        Gradient(stops: [
            .init(color: .clear, location: 0),
            .init(color: .black, location: 0.25)
        ])
    }
}

//MARK: - View extension

public extension View {

    func fade(gradient: Gradient? = nil, startPoint: UnitPoint = .bottom, endPoint: UnitPoint = .top) -> some View {
        self.modifier(Fade(gradient: gradient, startPoint: startPoint, endPoint: endPoint))
    }
}
