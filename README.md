
<p align="center">
  <img src="https://user-images.githubusercontent.com/22377058/69292342-93627480-0c0e-11ea-8415-a7f7f0e8d6ae.png" alt="Icon"/>
</p>

<H1 align="center">UIOutlineView</H1>

UIOutlineView is an iOS analogue for NSOutlineView class available for macOS

## Installation

UIOutlineView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UIOutlineView"
```

## Usage

### Import
Don't forget to add import:
```swift
import UIOutlineView
```

### Register cells
As for UITableView you should register cells you will use in OutlineView:
```swift
outlineView.register(YourCell.self, forCellReuseIdentifier: "cell")
```

### DataSource and Delegate
UIOutlineView is filled with data from UIOutlineViewDataSource and events handling is performed by UIOutlineViewDelegate. Protocols are almost similar to NSOutlineView's DataSource and Delegate:
```swift
outlineView.outline_delegate = self
outlineView.outline_dataSource = self
```

## Author

VihlayewAlex, vihlayew.alex@gmail.com

## License

UIOutlineView is available under the MIT license. See the LICENSE file for more info.
