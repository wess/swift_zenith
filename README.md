# Zenith

Zenith is a framework for simple and smart seperation of the view  controller and view management, leaving your controller to manage interactions and other "controller" like things. 
As well as a Router to simplify navigation through your app. 

## Requirements

- iOS 11.0+
- Xcode 9.0
- Swift 4.0

## Installation

### CocoaPods

CocoaPods is a dependency manager for Objective-C and Swift.  
To learn more about setting up your project for CocoaPods, please refer to the [official documentation](https://cocoapods.org/#install).  
To integrate Zenith into your Xcode project using CocoaPods, you have to add it to your project's `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'

use_frameworks!

target '<Your Target Name>' do
  pod 'Zenith', '~> 1.0'
end
```

Afterwards, run the following command:

```bash
$ pod install
```
## Usage
Zenith allows the view controller to hand off view layout and management to a component.

```swift
import UIKit
import Zenith

class MyViewComponent : ViewComponent {
  private lazy var label:UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.text = "Hello, world"
    
    return label
  }()
  
  override setupConstraints() {
    label.addConstraints([
      // Add constraints here
    ])
  }
  
  override render() -> UIView {
    return children(
     label
    )
  }
}

class MyViewController : ViewController<MyViewComponent> {
  // Your view controller will now load the component and
  // present it, like normal.
}
```

Zenith also features a router to simplify navigation.

```swift
import Zenith

enum MyRoute : RouteOption {
  case home
  case about

  var controller:UIViewController {
    switch self {
    case .home:
      return UINavigationController(rootViewController: MyHomeViewController)
    case .about:
      return UINavigationController(rootViewController: MyAboutViewController)
    }
  }
}

// Create an instance of your router, where you can access it anywhere.

let router = Router<MyRoute>()
router.move(.home)

```

## Credits

Zenith is written and maintained by [Wess Cope](http://wess.io).  
Twitter: [@wesscope](https://twitter.com/wesscope).


## License

Zenith is released under the MIT License.  
See [LICENSE](https://github.com/wess/zenith/blob/master/LICENSE) for details.
