//
//  SearchController.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/12/2020.
//

import SwiftUI

// MARK: View+Search

extension View {
    func navigationBarSearch(text: Binding<String>, placeholder: String) -> some View {
        let controller = SearchController(text: text, placeholder: placeholder)
        return overlay(controller.frame(width: 0, height: 0))
    }
}

// MARK: SearchController

private struct SearchController: UIViewControllerRepresentable {
    @Binding
    var text: String
    let placeholder: String

    init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }

    func makeUIViewController(context _: Context) -> SearchBarWrapperController {
        SearchBarWrapperController()
    }

    func updateUIViewController(
        _ controller: SearchBarWrapperController,
        context: Context
    ) {
        controller.searchController = context.coordinator.searchController
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, placeholder: placeholder)
    }

    class Coordinator: NSObject, UISearchResultsUpdating {
        @Binding
        var text: String
        var last: String?
        let searchController: UISearchController

        init(text: Binding<String>, placeholder: String) {
            self._text = text
            self.searchController = UISearchController(searchResultsController: nil)

            super.init()

            searchController.searchResultsUpdater = self
            searchController.hidesNavigationBarDuringPresentation = true
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = placeholder
        }

        func updateSearchResults(for searchController: UISearchController) {
            guard let text = searchController.searchBar.text else {
                return
            }

            if text != last {
                self.last = text
                self.text = text
            }
        }
    }

    class SearchBarWrapperController: UIViewController {
        var searchController: UISearchController? {
            didSet {
                parent?.navigationItem.searchController = searchController
            }
        }

        override func viewWillAppear(_: Bool) {
            parent?.navigationItem.searchController = searchController
        }

        override func viewDidAppear(_: Bool) {
            parent?.navigationItem.searchController = searchController
        }
    }
}
