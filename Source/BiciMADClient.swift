//
//  BiciMADClient.swift
//  BiciKit
//
//  Created by Adolfo Vera Blasco on 16/5/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

///
/// Todas las request se devuelven aquí
///
private typealias HttpRequestCompletionHandler = (_ result: HttpResult) -> (Void)

///
/// BiciMad. Resultados
///
public typealias BiciMADCompletionHandler = (_ result: BiciMADResult) -> (Void)


public class BiciMADClient
{
    /// Singleton
    public static let shared: BiciMADClient = BiciMADClient()

    /// JSON decoder para las peticiones a **BiciMad**
    private let decoder: JSONDecoder
    
    /// HTTP sesión ...
    private var httpSession: URLSession!
    /// ...y su configuración
    private var httpConfiguration: URLSessionConfiguration!

    private let baseURI: String

    private let apiUser: String
    private let apiPassword: String

    /**
        Crea una sesión HTTP session, el JSON decoder y 
        configura los parámetros de validación del API BiciMad.
    */
    private init()
    {
        self.decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.bicimadISO8601)

        self.baseURI = "https://rbdata.emtmadrid.es:8443/BiciMad"
        self.apiUser = "### TU_USUARIO ###"
        self.apiPassword = "### TU CLAVE ###"
        
        self.httpConfiguration = URLSessionConfiguration.default
        self.httpConfiguration.httpMaximumConnectionsPerHost = 10
        
        let http_queue: OperationQueue = OperationQueue()
        http_queue.maxConcurrentOperationCount = 10
        
        self.httpSession = URLSession(configuration:self.httpConfiguration,
                                      delegate:nil,
                                      delegateQueue:http_queue)
    }

    /**
        Recupera todas las estaciones del servicio BiciMad 
     
         - Parameter handler: Closure donde tenemos la información de las estaciones
    */
    public func stations(_ handler: @escaping BiciMADCompletionHandler) -> Void
    {
        let uri = "\(self.baseURI)/get_stations/\(self.apiUser)/\(self.apiPassword)/"

        guard let url = URL(string: uri) else
        {
            return 
        }

        self.serviceRequest(for: url, completionHandler: handler)
    }

    /**
        Obtiene la información para una stación en concreto

        - Parameters:
            - identifier: Identificador único de la estación
            - completionHandler: Closure donde tenemos la información de la estación
    */
    public func station(forIdentifier identifier: Int, completionHandler handler: @escaping BiciMADCompletionHandler) -> Void
    {
        let uri = "\(self.baseURI)/get_single_station/\(self.apiUser)/\(self.apiPassword)/\(identifier)/"

        guard let url = URL(string: uri) else
        {
            return 
        }

        self.serviceRequest(for: url, completionHandler: handler)
    }
        
    /**
        Las peticiones de todas las estaciones o de una sola
        estación se procesan en esta función.

        - Parameters:
            - url: La URL de la operación que se debe invocar
            - completionHandler: Closure donde tenemos la información
    */
    private func serviceRequest(for url: URL, completionHandler handler: @escaping BiciMADCompletionHandler) -> Void
    {
        // And send the request
        self.processHttp(url, httpHandler: { (result: HttpResult) -> Void in
            switch result
            {
                case .success(let data):
                    if let jsonData = self.fixJSONResponse(from: data), let response = try? self.decoder.decode(Response.self, from: jsonData)
                    {
                        handler(BiciMADResult.success(stations: response.results.stations))
                    }
                case .requestError(let code, let message):
                    let error_message: String = "\(message). Error with code \(code)"
                    handler(BiciMADResult.error(message: error_message))
                case .connectionError(let reason):
                    handler(BiciMADResult.error(message: reason))
            }
        })
    }

    /**
        Corrige el formato del JSON proviniente del API
        de BiciMAD.

        Parece que la clave `data` incluye el caracter backslash `\`,
        al igual que las llaves de apertura `{` y cierre `}`

        - Parameter data: El stream de datos devuelto por el servicio
        - Returns: El stream con un formato `JSON` válido
    */
    private func fixJSONResponse(from data: Data) -> Data?
    {
        guard var jsonResponse = String(data: data, encoding: .utf8) else
        {
            return nil
        }

        jsonResponse = jsonResponse
            .replacingOccurrences(of: "\"{", with: "{")
            .replacingOccurrences(of: "}\"", with: "}")
            .replacingOccurrences(of: "\\", with: "")
        
        return jsonResponse.data(using: .utf8)
    }

    //
    // MARK: - Funciones helper HTTP
    //

    /**
        URL request

        - Parameters:
            - request: `URL` solicitada
            - completionHandler: El resultado de la operación HTTP
    */
    private func processHttp(_ url: URL, httpHandler: @escaping HttpRequestCompletionHandler) -> Void
    {
        let request: URLRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)

        let data_task: URLSessionDataTask = self.httpSession.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let error = error
            {
                httpHandler(HttpResult.connectionError(reason: error.localizedDescription))
                return
            }

            guard let data = data, let http_response = response as? HTTPURLResponse else
            {
                httpHandler(HttpResult.connectionError(reason: "No data. No response"))
                return
            }

            switch http_response.statusCode
            {
                case 200:
                    httpHandler(HttpResult.success(data: data))
                    
                default:
                    let code: Int = http_response.statusCode
                    let message: String = HTTPURLResponse.localizedString(forStatusCode: code)

                    httpHandler(HttpResult.requestError(code: code, message: message))
            }
        })

        data_task.resume()
    }
}
