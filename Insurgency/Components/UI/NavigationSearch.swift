//
//  NavigationSearch.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import SwiftUI

struct NavigationSearch: UIViewControllerRepresentable {
    typealias UIViewControllerType = Wrapper

    @Binding var text: String
    @Binding var placeholder: String

    init(text: Binding<String>, placeholder: Binding<String>) {
        self._text = text
        self._placeholder = placeholder
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: _text, placeholder: _placeholder)
    }

    func makeUIViewController(context: Context) -> Wrapper {
        Wrapper()
    }

    func updateUIViewController(_ wrapper: Wrapper, context: Context) {
        wrapper.searchController = context.coordinator.searchController

        wrapper.searchController?.searchBar.text = text
        wrapper.searchController?.searchBar.placeholder = placeholder
    }

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var placeholder: String

        lazy var searchController: UISearchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.text = text
            controller.searchBar.placeholder = placeholder
            controller.searchBar.delegate = self
            return controller
        }()

        init(text: Binding<String>, placeholder: Binding<String>) {
            self._text = text
            self._placeholder = placeholder
            super.init()
        }

        // MARK: - UISearchBarDelegate

        func searchBar(_ searchBar: UISearchBar, textDidChange text: String) {
            self.text = text
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            self.text = ""
        }
    }

    class Wrapper: UIViewController {
        var searchController: UISearchController? {
            get {
                parent?.navigationItem.searchController
            }
            set {
                parent?.navigationItem.searchController = newValue
            }
        }
    }
}
