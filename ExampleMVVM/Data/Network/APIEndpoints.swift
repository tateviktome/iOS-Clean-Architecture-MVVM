//
//  APIEndpoints.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation

struct APIEndpoints {
    
    static func getMovies(with moviesRequestDTO: MoviesRequestDTO) -> Endpoint<MoviesResponseDTO> {

        return Endpoint(path: "3/search/movie/",
                        method: .get,
                        queryParametersEncodable: moviesRequestDTO)
    }

    static func getMovies2(with moviesRequestDTO: MoviesRequestDTO) -> Endpoint<Void> {

        return Endpoint(path: "3/search/movie/",
                        method: .get,
                        queryParametersEncodable: moviesRequestDTO)
    }
    
    static func getMoviePoster(path: String, width: Int) -> Endpoint<Data> {

        let sizes = [92, 154, 185, 342, 500, 780]
        let closestWidth = sizes.enumerated().min { abs($0.1 - width) < abs($1.1 - width) }?.element ?? sizes.first!
        
        return Endpoint(path: "t/p/w\(closestWidth)\(path)",
                        method: .get,
                        responseDecoder: RawDataResponseDecoder())
    }
    
    static func getConfigs(with configRequestDTO: ConfigRequestDTO) -> Endpoint<ConfigResponseDTO> {

        return Endpoint(path: "http://www.mocky.io/v2/5e8c6e252f00002b0088caf7",
                        isFullPath: true,
                        method: .get,
                        queryParametersEncodable: configRequestDTO)
    }
}
