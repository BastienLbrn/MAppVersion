[![Swift Version][swift-image]][swift-url]

# MAppVersion

## Requirements

- iOS 15.0+

## Usage example

This package allows you to retrieve easily the potential updates (required or not) depending on version's component.

In this example we will display the update available as soon as we have a patch update, and force the update whenever a major release will be pushed to the store.

```swift

import Foundation
import MAppVersion

@MainActor class ContentViewModel: ObservableObject {
    
    @Published var showUpdate = false
    @Published var showForceUpdate = false
    
    init() {
        Task.init {
            (showUpdate, showForceUpdate) = await MAppVersion.needUpdate(notify: .patch, force: .major)
        }
    }
}

```

Once this method has been called, potential updates will be kept and some properties will be available directly in MAppVersion.current (static instance).

```swift

    public var appStoreLink: String?
    public var currentVersion: MAppVersionValue?
    public var appStoreVersion: MAppVersionValue?

```

App versions will be built according version format described below:

```swift

public struct MAppVersionValue {
    public var major: Int
    public var minor: Int
    public var patch: Int
}

```

## Error tracking

Clear error handling can save you a lot of debugging time.

```swift

public enum MAppVersionError: Error {
    case infoDictionaryNotFound
    case versionNotFoundInInfoDictionary
    case versionInvalidInInfoDictionary
    case identifierNotFoundInInfoDictionary
    case lookupURLFailed
    case getStoreVersionCallError
    case getStoreVersionDecodingFailed
    case getStoreVersionResultNotFound
    case getStoreVersionResultInvalid
}

```

[https://github.com/BastienLbrn/github-link](https://github.com/BastienLbrn/)

[swift-image]:https://img.shields.io/badge/swift-15.0-orange.svg
[swift-url]: https://swift.org/
