//
//  MovieDetailsView.swift
//  ReduxMovieDBEarlTests
//
//  Created by Bakhtiozin Andrii on 9/17/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation
import EarlGrey
@testable import ReduxMovieDB

class MovieDetailsView {
    
    func assert(extMovie: ExtMovie) {
        let title = extMovie.movie.title!
        assertValue(value: title, type: UIAccessibilityTraitHeader.self)
        assertValue(value: title, type: UIAccessibilityTraitStaticText.self)
        assertValue(value: extMovie.movie.overview!, type: UIAccessibilityTraitStaticText.self)
        assertValue(value: extMovie.movie.releaseDate!, type: UIAccessibilityTraitStaticText.self)
        assertValue(value: extMovie.genre, type: UIAccessibilityTraitStaticText.self)
    }

    private func assertValue(value: String, type: UIAccessibilityTraits) {
        EarlGrey.selectElement(with:
            grey_allOf(
                [
                    grey_kindOfClass(UILabel.self),
                    grey_accessibilityLabel(value),
                    grey_sufficientlyVisible(),
                    grey_accessibilityTrait(type)
                ])
            )
            .assert(grey_text(value))
    }

    func pressBack() {
        let backButton = EarlGrey.selectElement(with: grey_allOf([grey_text("Movies"), grey_sufficientlyVisible()]))
        backButton.perform(grey_tap())
    }
}
