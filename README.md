[![Swift Version][swift-image]][swift-url]

# MAppVersion

## Requirements

- iOS 15.0+

## Usage example

```swift
import Foundation
import MAppVersion

@MainActor class ContentViewModel: ObservableObject {
    
    @Published var showUpdate = false
    @Published var showForceUpdate = false
    
    init() {
        Task.init {
            (showUpdate, showForceUpdate) = await MAppVersion.needUpdate(notify: .patch, force: .patch)
        }
    }
}
```

[https://github.com/BastienLbrn/github-link](https://github.com/BastienLbrn/)

[swift-image]:https://img.shields.io/badge/swift-15.0-orange.svg
[swift-url]: https://swift.org/
