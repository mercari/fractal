# Fractal

An iOS Design System based on Atomic Design Theory and Declarative UI

## Installation

### Carthage

```
github "mercari/fractal"
```

### CocoaPods

```
pod 'Fractal', :git => 'https://github.com/mercari/fractal.git'
```

## Usage

1. Create a `Brand` 
2. Build Atomic Components as plain old `UIView` / `UIViewController` subclasses
3. Create `Sections` using the `ViewSection` `ViewControllerSection` protocols
4. Add `SectionBuilder` to your main `UIViewController`
5. Create a declaritive array of `Sections` that display your Atomic Components in a `UITableView` or `UICollectionView`

Please visit the in built TestApp to see various implementations of Sections.

## Reference
http://atomicdesign.bradfrost.com/

## Progress
| Epics | |
----|---- 
| DesignSystem | ✅ |
| SectionSystem | ✅ |
| SandboxApp | ✅ |
| Tests | WIP |

| Branding | |
----|---- 
| Colors | ✅ |
| Fonts | ✅ |
| Sizes | ✅ |
| Spacing & Autolayout | ✅ |
| Brand injection | ✅ |
| DateFormat | WIP |

| Atomic Elements |  |
----|---- 
| Button | ✅ |
| Label | ✅ |
| SegmentedControl | ✅ |
| Slider | ✅ |
| Switch | ✅ |
| TextField | ✅ |
| TextView | ✅ |

| Section interpretation | |
----|---- 
| UITableView | ✅ |
| UICollectionView | ✅ |
| UIStackView in UIScrollView | Maybe |
| UIViewController | Maybe |

## Contributors

[nodata](https://github.com/nodata)

[cantallops](https://github.com/cantallops)

[danielsinclairtill](https://github.com/danielsinclairtill)

[plimc](https://github.com/plimc)

[jeffreybergier](https://github.com/jeffreybergier)

[herbal7ea](https://github.com/herbal7ea)

[bricklife](https://github.com/bricklife)

[timoliver](https://github.com/timoliver)

[musbaalbaki](https://github.com/musbaalbaki)

## Contribution

Please read the CLA carefully before submitting your contribution to Mercari.
Under any circumstances, by submitting your contribution, you are deemed to accept and agree to be bound by the terms and conditions of the CLA.

https://www.mercari.com/cla/

## License

Copyright 2019 Mercari, Inc.
Licensed under the MIT License.
