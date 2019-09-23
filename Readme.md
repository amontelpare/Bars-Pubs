# Bars&Pubs

Aplicación para test de proceso de selección de la empresa Rappi.

## Contenido
	
* [Requerimientos](#requerimientos)
* [Integrar](#instalar)
	* [CocoaPods](#cocoapods)
* [Consideraciones](#consideraciones)
   * [API](#api)
   * [iOS](#ios)
   * [Metodología](#metodologia)

## <a name="requerimientos"></a> Requerimientos

* XCode 10.0+
* Swift 4.0+
* iOS 12.4+
* [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) 1.7.1+

## <a name="instalar"></a> Instalar

### <a name="cocoapods"></a> CocoaPods

1. Instalar el pod:

		$ pod install

## <a name="consideraciones"></a> Consideraciones

### <a name="api"></a> API

1. La API, en el servicio search?, devuelve un JSON mal formado. En lugar de un array de restaurantes devuelve un array de diccionarios donde la Key es “restaurant” y el Value es el objecto. En la doc lo muestra correcto, pero en la implementación no.

2. El servicio search? devuelve menos resultados de los que dice su count. Se puede comprobar desde su página, si se pone start = 200, devuelve success con 0 resultados en el array.

### <a name="ios"></a> iOS

1. Elegí la arquitectura Clean Swift, basada en Clean Architecture,  la misma utiliza un ciclo unidireccional VIP.

2. Se implementó más de un StoreService, a modo representativo, para mostrar que es el iterator quien define a quien pedirle la información, cualquiera que implemente el protocolo del Store puede ser utilizado. La app sólo usa el que hace llamados a API.

### <a name="metodologia"></a> Metodología

1. Se trabajó en branchs por tareas, que luego se integraban con el branch develop. Una vez finalizada la versión, se mergeó a master y se generó el release desde ahí. Con esta forma de trabajo los PR se realizan cada vez que se mergea un branch de tarea con develop.

