//
//  SVGImageView.swift
//  hypermarket
//
//  Created by Barry Allen on 27/7/2025.
//

import Foundation
import SVGKit
import SwiftUI

struct SVGImageView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> SVGKFastImageView {
        let emptySVG = SVGKImage()
        let svgView = SVGKFastImageView(svgkImage: emptySVG) ?? SVGKFastImageView(svgkImage: SVGKImage())!
        svgView.contentMode = .scaleAspectFit
        svgView.clipsToBounds = true
        svgView.translatesAutoresizingMaskIntoConstraints = false
        svgView.backgroundColor = .clear
        return svgView
    }
    func updateUIView(_ uiView: SVGKFastImageView, context: Context) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let svgImage = SVGKImage(data: data) {
                DispatchQueue.main.async {
                    uiView.image = svgImage
                    uiView.setNeedsLayout()
                }
            }
        }
    }
}
