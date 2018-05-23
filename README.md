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

## Registro 

Para poder trabajar con el API necesitas estar registrado en portal de Datos Abiertos de la EMT. Puedes acceder [desde este formulario](http://opendata.emtmadrid.es/Formulario.aspx).

Una vez tengas en tu poder el correo de confirmación con tu usuario y contraseña debes editar la clase `BiciMADClient`, situarte en el inicializador de la clase y poner tu usuario y contraseña en la asignación de las variables `apiUser` y `apiPassword`

```swift
private init()
{
	self.decoder = JSONDecoder()
	decoder.dateDecodingStrategy = .formatted(DateFormatter.bicimadISO8601)

	self.baseURI = "https://rbdata.emtmadrid.es:8443/BiciMad"
->	self.apiUser = "### TU_USUARIO_AQUÍ ###"
->	self.apiPassword = "### TU CLAVE_AQUÍ ###"
	...
```

## Contacto

Cualquier duda o sugerencia me puedes encontrar en twitter. [@fitomad](https://twitter.com/fitomad)
