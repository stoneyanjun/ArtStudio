// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Common {
    /// Localizable.strings
    ///   ArtStudio
    /// 
    ///   Created by stone on 2024/11/30.
    internal static let title = L10n.tr("Localizable", "common.title", fallback: "ArtStudio")
    internal enum Alert {
      internal enum Button {
        /// OK
        internal static let ok = L10n.tr("Localizable", "common.alert.button.ok", fallback: "OK")
      }
      internal enum Message {
        /// Unknown error
        internal static let unknown = L10n.tr("Localizable", "common.alert.message.unknown", fallback: "Unknown error")
      }
      internal enum Title {
        /// Error
        internal static let error = L10n.tr("Localizable", "common.alert.title.error", fallback: "Error")
      }
    }
    internal enum Title {
      /// Unknown
      internal static let unknown = L10n.tr("Localizable", "common.title.unknown", fallback: "Unknown")
    }
  }
  internal enum Enum {
    internal enum Search {
      internal enum DisplayType {
        /// Discover
        internal static let discover = L10n.tr("Localizable", "enum.search.displayType.discover", fallback: "Discover")
        /// Search
        internal static let search = L10n.tr("Localizable", "enum.search.displayType.search", fallback: "Search")
      }
    }
    internal enum Tabbar {
      /// Search
      internal static let search = L10n.tr("Localizable", "enum.tabbar.search", fallback: "Search")
      /// Topics
      internal static let topics = L10n.tr("Localizable", "enum.tabbar.topics", fallback: "Topics")
    }
  }
  internal enum SearchView {
    internal enum Button {
      /// Search
      internal static let search = L10n.tr("Localizable", "search_view.button.search", fallback: "Search")
    }
    internal enum Textfield {
      internal enum Placehold {
        /// Search photos
        internal static let searchPhotos = L10n.tr("Localizable", "search_view.textfield.placehold.search_photos", fallback: "Search photos")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
