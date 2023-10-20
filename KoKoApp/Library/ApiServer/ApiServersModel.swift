//
//  ApiServersModel.swift
//  GoBusNow
//
//  Created by alan on 2023/7/16.
//

import SwiftUI

protocol ApiServersProtocol: ObservableObject {
    func requestHttpServer<T: Decodable>(completion: @escaping (Result<[T], Error>) -> Void)
}

class ApiServersModel: ApiServersProtocol {

    let api: ApiRouter
    let method: ApiMethod

    init(api: ApiRouter, method: ApiMethod = .GET) {
        self.api = api
        self.method = method
    }
    
    func requestHttpServer<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = URL(string: base_URL + api.rawValue) else {
            completion(.failure(ApiError.RequestUrlError("URL 錯誤")))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        urlSession(request: request, completion: completion)
    }

    private func urlSession<T: Decodable>(request: URLRequest,completion: @escaping (Result<T, Error>) -> Void) {

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(ApiError.DataTaskError("URLSession 錯誤")))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(ApiError.ResponseNullError("Response 資料為空")))
                return
            }

            if response.statusCode == 200 {
                guard let data = data else {
                    completion(.failure(ApiError.DataNullError("Data 資料為空")))
                    return
                }
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(json))
                }
                catch {
                    completion(.failure(ApiError.JsonError("Json 資料結構錯誤")))
                }
            }
            else {
                completion(.failure(ApiError.ResponseError("Response 請求響應錯誤")))
            }
        }
        dataTask.resume()


    }
}

