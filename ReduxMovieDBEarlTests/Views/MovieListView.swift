//
//  MovieListView.swift
//  ReduxMovieDBEarlTests
//
//  Created by Bakhtiozin Andrii on 9/17/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation
import EarlGrey
@testable import ReduxMovieDB

class MovieListView {

    func search(movieName: String) -> MovieListView {
        EarlGrey.selectElement(with: grey_accessibilityTrait(UIAccessibilityTraitSearchField.self))
                .perform(grey_typeText(movieName))
        return self
    }

    func cleanResult() {
        EarlGrey.selectElement(with: grey_accessibilityTrait(UIAccessibilityTraitSearchField.self))
                .perform(grey_tap())
        EarlGrey.selectElement(with: grey_text("Cancel"))
                .perform(grey_tap())
    }

    func choose(positionInList: UInt) -> MovieDetailsView {
        EarlGrey.selectElement(with: grey_allOf([grey_kindOfClass(UITableViewCell.self), grey_sufficientlyVisible()]))
                .atIndex(positionInList)
                .perform(grey_tap())
        return MovieDetailsView()
    }

    func chooseByText(movieName: String) -> MovieDetailsView {
        EarlGrey.selectElement(
                        with: grey_allOf(
                                [
                                    grey_accessibilityTrait(UIAccessibilityTraits(UIAccessibilityTraitStaticText.self)),
                                    grey_accessibilityLabel(movieName),
                                    grey_ancestor(grey_kindOfClass(UITableViewCell.self)),
                                    grey_sufficientlyVisible()
                                ]
                        )
                )
                .perform(grey_tap())
        return MovieDetailsView()
    }

    func assertCountOfResults(results: Int) {
        let actual = count(matcher: grey_kindOfClass(UITableViewCell.self))
        assert(actual == results)
    }

    func assertResults(_ movieName: String) {
        let result: TempObj = TempObj()
        let actual = count(matcher: grey_kindOfClass(UITableViewCell.self))
        for i in 0...actual - 1 {
            EarlGrey.selectElement(with: grey_allOf([grey_kindOfClass(UITableViewCell.self), grey_sufficientlyVisible()]))
                    .atIndex(i)
                    .perform(grey_getText(result))
            assert(result.text.contains(movieName))
        }
    }

    private func count(matcher: GREYMatcher!) -> UInt {
        var error: NSError? = nil
        var index: UInt = 0
        let countMatcher: GREYElementMatcherBlock =
                GREYElementMatcherBlock.matcher(matchesBlock: { (element: Any?) -> Bool in
                    if (matcher.matches(element) && grey_sufficientlyVisible().matches(element)) {
                        index = index + 1;
                    }
                    return false;
                }) { (description: Any?) in
                    let greyDescription: GREYDescription = description as! GREYDescription
                    greyDescription.appendText("Count of Matcher")
                }
        EarlGrey.selectElement(with: grey_allOf([countMatcher, grey_sufficientlyVisible()]))
                .assert(grey_notNil(), error: &error);
        return index
    }

    private class TempObj {
        var text = ""
    }

    private func grey_getText(_ result: TempObj) -> GREYActionBlock {
        return GREYActionBlock.action(
                withName: "get text",
                constraints: grey_respondsToSelector(#selector(getter: UILabel.text))) { element, errorOrNil -> Bool in
            let elementObject: MovieListTableViewCell? = element as? MovieListTableViewCell
            let text = elementObject?.title.text
            result.text = text ?? ""
            return true
        }
    }
}

