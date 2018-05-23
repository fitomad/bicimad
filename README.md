# BiciMad - Swfit API Client
![Swift 4.1](https://img.shields.io/badge/swift-4.1-red.svg) ![Xcode](https://img.shields.io/badge/xcode-9.3-blue.svg) ![MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg)

Cliente para el API oficial de BiciMad. El servicio de bike sharing operado por la EMT de Madrid

## Uso

Lo mejor es ver un ejemplo 

```swift
BiciMADClient.shared.stations() { (result: BiciMADResult) -> Void in
    switch result
    {
        case let .success(stations):
			print("Bicis disponibles: \(stations.freeBikes)")
			print("Bicis en circulación: \(stations.bikesInUse)")
			
		case let .error(message):
			print("Algo ha salido mal... \(message)")
	}
}
```

## Contacto

Cualquier duda o sugerencia me puedes encontrar en twitter. [@fitomad](https://twitter.com/fitomad)
