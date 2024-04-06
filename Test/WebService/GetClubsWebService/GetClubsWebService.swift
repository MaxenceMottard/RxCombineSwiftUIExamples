//
//  GetClubsWebService.swift
//  ImplementSwiftUIInUIKitArchi
//
//  Created by Maxence Mottard on 05/04/2024.
//

import Foundation
import RxSwift

struct GetClubsWebService {
    func fetchClubs() -> Observable<GetClubsWebServiceResponse> {
        let urlString = "https://api.quickshot.fr/v1/clubs"

        return Observable.create { observer in
            guard let url = URL(string: urlString) else {
                observer.onError(NSError(domain: "WRONG_URL", code: 0))
                return Disposables.create()
            }

            var urlRquest = URLRequest(url: url)
            urlRquest.httpMethod = "GET"

            let task = URLSession.shared.dataTask(with: urlRquest) { (data, response, error) in
                if let error {
                    observer.onError(error)
                    return
                }

                guard let data else {
                    observer.on(.completed)
                    return
                }

                do {
                    let jsonDecoder = JSONDecoder()
                    let decodedData = try jsonDecoder.decode(GetClubsWebServiceResponse.self, from: data)

                    observer.on(.next(decodedData))
                    observer.on(.completed)
                } catch {
                    observer.onError(error)
                }
            }

            task.resume()

            return Disposables.create()
        }
    }
}
