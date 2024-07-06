//
//  FlickrApiServiceTests.swift
//  FlickrAppTests
//
//  Created by Jordan Porter on 06/07/2024.
//

import XCTest
@testable import FlickrApp

final class FlickrApiServiceTests: XCTestCase {
    var flickrApiService: FlickrApiService!

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockUrlProtocol.self]
        let customSession = URLSession(configuration: config)

        flickrApiService = FlickrApiService(session: customSession)
    }

    override func tearDown() {
        flickrApiService = nil
        MockUrlProtocol.requestHandler = nil
        super.tearDown()
    }

    func test_givenTheUrlProtocolReturnsValidDataAndResponse_whenCallFlickrApiIsCalled_thenValidJsonDataIsReturned() async {
        MockUrlProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, .dummy)
        }

        do {
            let additionalQueryItems = [URLQueryItem(name: "method", value: "flickr.photos.search")]
            let data = try await flickrApiService.callFlickrApi(with: additionalQueryItems)

            XCTAssertNotNil(data)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            XCTAssertNotNil(json)
            XCTAssertEqual(json?["stat"] as? String, "ok")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }

    func test_givenTheUrlProtocolReturnsAnInvalidResponse_whenCallFlickrApiIsCalled_thenErrorIsThrown() async {
        MockUrlProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        do {
            let additionalQueryItems = [URLQueryItem(name: "method", value: "flickr.photos.search")]
            let _ = try await flickrApiService.callFlickrApi(with: additionalQueryItems)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertNotNil(error)
            if let urlError = error as? URLError {
                XCTAssertEqual(urlError.code, .badServerResponse)
            } else {
                XCTFail("Expected URLError but got: \(error)")
            }
        }
    }
}
