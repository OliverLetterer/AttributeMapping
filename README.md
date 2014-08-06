# SPLAttributeMapping

[![CI Status](http://img.shields.io/travis/Oliver Letterer/SPLAttributeMapping.svg?style=flat)](https://travis-ci.org/Oliver Letterer/SPLAttributeMapping)
[![Version](https://img.shields.io/cocoapods/v/SPLAttributeMapping.svg?style=flat)](http://cocoadocs.org/docsets/SPLAttributeMapping)
[![License](https://img.shields.io/cocoapods/l/SPLAttributeMapping.svg?style=flat)](http://cocoadocs.org/docsets/SPLAttributeMapping)
[![Platform](https://img.shields.io/cocoapods/p/SPLAttributeMapping.svg?style=flat)](http://cocoadocs.org/docsets/SPLAttributeMapping)

SPLAttributeMapping let's You define __statically typed__ attribute mappings (required by [Mantle](https://github.com/Mantle/Mantle) for example). Save thanks to Swift Generics.

__Please note that this is not more than a POC at the moment.__

## Usage by example

Imagin You have a webservice returning Countries as JSON Dictionaries which You wan't to map to Your own ObjC model:

```swift
class Country: NSObject {
    dynamic var identifier: NSNumber = 5
    dynamic var name: String = ""
    dynamic var createdAt: String = ""
    dynamic var updatedAt: String = ""
}
```

This requires some form of attribute mapping between the JSON object and Your ObjC model, like the following for example:

```
let attributeMapping = [
  "id": "identifier",
  "name": "name",
  "created_at": "createdAt",
  "updated_at": "updatedAt",
]
```

The problem here is that all ObjC attributes are referenced by _string_-values, which are predestinated for typos or often missed while refactoring. What You really want is a statically typed attribute mapping without typos and compile time checks. This is exactly what SPLAttributeMapping tries to solve:

```
let mapping = AttributeMapping(Country)
  .map("id", { $0.identifier })
  .map("name", { $0.name })
  .map("created_at", { $0.createdAt })
  .map("updated_at", { $0.updatedAt })

mapping.dictionary // #=> [id: identifier, name: name, updated_at: updatedAt, created_at: createdAt]
```

## Limitations

* All mapped attributes must by `dynamic`.
* All attributes must be object typed.

## Installation

SPLAttributeMapping is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "SPLAttributeMapping"

## Author

Oliver Letterer, oliver.letterer@gmail.com

## License

SPLAttributeMapping is available under the MIT license. See the LICENSE file for more info.
