# Mondrian
A Binary Space Partitioning Framework for iOS.

[![Build Status](https://travis-ci.org/NiceThings/Mondrian.svg?branch=develop)](https://travis-ci.org/NiceThings/Mondrian)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

----------
## Introduction

Mondrain is a lightweight framework consisting of a handful of protocols and extensions.

Any type that implements `Partitionable` may pass an instance into the `partitioned` function to return a collection of elements that compose the partitioned instance.


## Installation with Carthage

BonMot is compatible with [Carthage](https://github.com/Carthage/Carthage). To install it, simply add the following line to your Cartfile:

```
github "NiceThings/Mondrian"
```

## Usage

`partitioned` takes a root value to partitition, a minimum value which the returned elements should not fall below, and a tranformation closure that defines how the partitioning should take place. 

For example, `partitioned` could return a `CGRect` vertically bisected in in chunks no smaller than a rectangle of area `100`:

```
        let viewRect = view.frame

        CGRect.partitioned(withRootValue: viewRect,
                                          minValue: CGRect(x: 0.0,
                                                           y: 0.0,
                                                           width: 50.0,
                                                           height: 50.0)) { (parent) -> (CGRect, CGRect) in

            let bisectPt = parent.height / 2.0
            let c1 = CGRect(origin: parent.origin, size: CGSize(width: parent.width, height: parent.height - bisectPt))
            let c2 = CGRect(origin: CGPoint(x: c1.minX, y: c1.maxY), size: CGSize(width: parent.width, height: bisectPt))


            return (c1, c2)
        }
```


In the example below, the `CGRect` bisected at a random index, resulting in a slick, Mondrian-esque image.


```
CGRect.partitioned(withRootValue: viewRect, minValue: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)) { (parent) -> (CGRect, CGRect) in
            
            var c1 = CGRect.zero
            var c2 = CGRect.zero
            var bisectPt: CGFloat = 0.0
            
            if arc4random() % 2 == 0 {
                bisectPt = parent.height / CGFloat(arc4random_uniform(4) + 2)
                c1 = CGRect(origin: parent.origin, size: CGSize(width: parent.width, height: parent.height - bisectPt))
                c2 = CGRect(origin: CGPoint(x: c1.minX, y: c1.maxY), size: CGSize(width: parent.width, height: bisectPt))
            } else {
                bisectPt = parent.width / CGFloat(arc4random_uniform(4) + 2)
                c1 = CGRect(origin: parent.origin, size: CGSize(width: parent.width - bisectPt, height: parent.height))
                c2 = CGRect(origin: CGPoint(x: c1.maxX, y: c1.minY), size: CGSize(width: bisectPt, height: parent.height))
            }
            
            
            return (c1, c2)
        }
```

<p align="center" >
<br/>
<img style="width: 30%" src="https://raw.github.com/nicethings/mondrian/develop/demo.png" alt="Overview" />
<br/>
</p>


## License
Mondrian is released under the [MIT license](https://opensource.org/licenses/MIT). See [LICENSE.md](./LICENSE.md) for details.

