# QuadTree

## Compatibility
QuadTree is written in Swift 4 and requires Xcode 9+

## Installation
### CocoaPods

Make sure you have **CocoaPods** installed on your system:

[CocoaPods](https://cocoapods.org/) is a dependency manager for Swift and Objective-C Cocoa projects. You can install it with the following command:

```shell
$ sudo gem install cocoapods
```

Add a podfile:

```Ruby
platform :ios, '10.0'
use_frameworks!
target '<Your Target Name>' do
    pod 'QuadTree', :git => 'https://github.com/hershalle/QuadTree.git'
end
```
Then, run the following command:

```shell
$ pod install
```

### Manual
// TODO: use alamofire

## Usage

### Construct an empty tree
QuadTree holds a point and an asosiate object of some type T. Some use cases for T are:

- Color: The color of the pixel at that point
- View: A node at that point
- Data: A quadTree can represent a sparse matrix

here I chose to use String:

```Swift
import QuadTree

let quadTree = QuadTree<String>(bounds: bounds)
```

The points of the tree must be contained inside the bounds.

### Add a point

```swift
quadTree.add(point: point, object: "This is an associated value")
```

point is CGPoint

### Tree traversal
```swift
quadTree.traverse { (leaf, bounds) in
	guard let leaf = leaf else {
   		print("Empty quad in bounds \(bounds)")
		return
	}
            
	print("found object \(leaf.object) at point: \(leaf.point) inside quad \(bounds)")
}
```

## Contributing

If you have any ideas, just [open an issue](https://github.com/hershalle/FilterComposer/issues) and tell me what you think.
You can also contact me via Twitter [@hershalle](https://twitter.com/hershalle)

If you'd like to contribute, please fork the repository and make changes as
you'd like. Pull requests are warmly welcome.

## Licensing

This project is licensed under [MIT license](https://github.com/hershalle/FilterComposer/blob/master/LICENSE). 