// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
  import SwiftUI
#elseif os(iOS)
  import UIKit
  import SwiftUI
#elseif os(tvOS) || os(watchOS)
  import UIKit
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Colors {
  public static let appSignatureColor = ColorAsset(name: "app_signature_color")
  public static let primaryBody = ColorAsset(name: "primary_body")
  public static let primaryGray = ColorAsset(name: "primary_gray")
}

public extension UIColor {
	static let appSignatureColor = UIColor(named: "app_signature_color", in: BundleToken.bundle, compatibleWith: nil)
	static let primaryBody = UIColor(named: "primary_body", in: BundleToken.bundle, compatibleWith: nil)
	static let primaryGray = UIColor(named: "primary_gray", in: BundleToken.bundle, compatibleWith: nil)
}

public extension SwiftUI.Color {
	static let appSignatureColor = SwiftUI.Color("app_signature_color", bundle: BundleToken.bundle)
	static let primaryBody = SwiftUI.Color("primary_body", bundle: BundleToken.bundle)
	static let primaryGray = SwiftUI.Color("primary_gray", bundle: BundleToken.bundle)
}

// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
	guard let color = Color(asset: self) else {
	  fatalError("Unable to load color asset named \(name).")
	}
	return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
	let bundle = BundleToken.bundle
	guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
	  fatalError("Unable to load color asset named \(name).")
	}
	return color
  }
  #endif

  fileprivate init(name: String) {
	self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
	let bundle = BundleToken.bundle
	#if os(iOS) || os(tvOS)
	self.init(named: asset.name, in: bundle, compatibleWith: nil)
	#elseif os(macOS)
	self.init(named: NSColor.Name(asset.name), bundle: bundle)
	#elseif os(watchOS)
	self.init(named: asset.name)
	#endif
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
