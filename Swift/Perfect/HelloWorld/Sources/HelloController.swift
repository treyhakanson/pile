//
//  HelloController.swift
//  HelloWorld
//
//  Created by David Hakanson on 4/8/17.
//
//

import PerfectHTTP

final class HelloController {
    private func returnJSONMessage(_ message: String, res: HTTPResponse) {
        do {
            try res.setBody(json: ["message": message])
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            res.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    
    func greet(_ req: HTTPRequest, _ res: HTTPResponse) {
        res.setBody(string: "Hello World! It's nice to meet you.")
            .completed()
    }
    
    func greetWithJson(_ req: HTTPRequest, _ res: HTTPResponse) {
        returnJSONMessage("Hello World! Nice JSON huh?", res: res)
    }
    
    func greetMany(_ req: HTTPRequest, _ res: HTTPResponse) {
        guard let numPeopleRaw = req.urlVariables["num_people"],
            let numPeople = Int(numPeopleRaw) else {
            res.setBody(string: "400 Bad Request")
                .completed(status: .badRequest)
            return
        }
        
        returnJSONMessage("Hello to all \(numPeople) of you!", res: res)
    }
}
