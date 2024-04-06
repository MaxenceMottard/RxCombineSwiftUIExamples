//
//  RxPublisher+Extensions.swift
//  ImplementSwiftUIInUIKitArchi
//
//  Created by Maxence Mottard on 05/04/2024.
//

import Combine
import RxSwift

@available(OSX 10.15, tvOS 13.0, *)
public extension ObservableConvertibleType {
    /// An `AnyPublisher` of the underlying Observable's Element type
    /// so the RxSwift.Observable pushes events to the Publisher.
    var publisher: AnyPublisher<Element, Swift.Error> {
        RxPublisher(upstream: self).eraseToAnyPublisher()
    }

    /// Returns a `AnyPublisher` of the underlying Observable's Element type
    /// so the RxSwift.Observable pushes events to the Publisher.
    ///
    /// - returns: AnyPublisher of the underlying Observable's Element type.
    /// - note: This is an alias for the `publisher` property.
    func asPublisher() -> AnyPublisher<Element, Swift.Error> {
        publisher
    }
}

/// A Publisher pushing RxSwift events to a Downstream Combine subscriber.
@available(OSX 10.15, tvOS 13.0, *)
public class RxPublisher<Upstream: ObservableConvertibleType>: Combine.Publisher {
    public typealias Output = Upstream.Element
    public typealias Failure = Swift.Error

    private let upstream: Upstream

    init(upstream: Upstream) {
        self.upstream = upstream
    }

    public func receive<S: Subscriber>(subscriber: S) where Failure == S.Failure, Output == S.Input {
        subscriber.receive(subscription: RxSubscription(upstream: upstream, downstream: subscriber))
    }
}
