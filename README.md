## Description

This project demonstrates how to develop a screen using SwiftUI while maintaining an existing architecture based on UIKit. The goal is to show how SwiftUI can be integrated into existing projects without having to completely overhaul the underlying architecture.

## Approaches

### 1. UIKit with RxSwift: [ClubsListWithRx](https://github.com/MaxenceMottard/RxCombineSwiftUIExamples/tree/master/Test/Features/ClubsListWithRx)

This approach uses UIKit for the UI, with both the Worker and ViewModel implementing RxSwift. This represents the traditional method of iOS application development before the introduction of SwiftUI.

#### Features:

- **Worker:** Uses RxSwift.
- **ViewModel:** Implements RxSwift for state and presentation logic.
- **Screen:** Developed using UIKit.


### 2. SwiftUI with RxSwift and Combine: [ClubsListWithRxSwiftUI](https://github.com/MaxenceMottard/RxCombineSwiftUIExamples/tree/master/Test/Features/ClubsListWithRxSwiftUI)

Here, we retain RxSwift at the Worker and ViewModel levels, but introduce Combine to enable the use of SwiftUI. It uses @Published (Combine and SwiftUI) instead of CurrentSubject (RxSwift) for reactivity within SwiftUI.

#### Features:

- **Worker:** Continues to use RxSwift.
- **ViewModel:** Uses RxSwift but adopts Combine for reactivity with SwiftUI.
- **Screen:** Developed using SwiftUI.


### 3. RxSwift to Combine Bridge with SwiftUI: [ClubsListWithCombineSwiftUI](https://github.com/MaxenceMottard/RxCombineSwiftUIExamples/tree/master/Test/Features/ClubsListWithCombineSwiftUI)

This method creates a bridge between RxSwift and Combine. The worker transforms the RxSwift Observable into a Combine Publisher, so that the ViewModel is developed entirely with Combine.

#### Features:

- **Worker:** Uses RxSwift with a bridge to Combine.
- **ViewModel:** Implements Combine.
- **Screen:** Developed with SwiftUI.
