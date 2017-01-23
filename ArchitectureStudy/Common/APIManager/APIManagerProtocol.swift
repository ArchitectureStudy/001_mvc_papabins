//
//  APIManagerProtocol.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 13..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation
import Alamofire


enum BackendError: Error {
    case network(error: Error)
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
}

protocol APIManagerProtocol {
    func requestApi(_ endpoint: Endpoint) -> DataRequest
}

extension APIManagerProtocol {
    func requestApi(_ endpoint: Endpoint) -> DataRequest {
        return requestApi(endpoint)
    }
}

func += <K, V> (left: inout [K : V], right: [K : V]) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

extension SessionManager: APIManagerProtocol {
    
    func requestApi(_ endpoint: Endpoint) -> DataRequest {
        return request(endpoint)
    }
}

protocol ResponseObjectSerializable {
    init?(response: HTTPURLResponse, representation: Any)
}

protocol APIRequestProtocol {
    func responseApi(_ completionHandler: (DataResponse<Any>) -> Void) -> Self
}

extension DataRequest {

    func responseApi<T: ResponseObjectSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self
    {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else { return .failure(BackendError.network(error: error!)) }
            
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(BackendError.jsonSerialization(error: result.error!))
            }
            
            guard let response = response, let responseObject = T(response: response, representation: jsonObject) else {
                return .failure(BackendError.objectSerialization(reason: "JSON could not be serialized: \(jsonObject)"))
            }
            
            return .success(responseObject)
        }
        
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

enum ApiResult<Value> {
    case success(value: Value)
    case failure(error: NSError)
    
    init(_ f: () throws -> Value) {
        do {
            let value = try f()
            self = .success(value: value)
        } catch let error as NSError {
            self = .failure(error: error)
        }
    }
    
    func unwrap() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
