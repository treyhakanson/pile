//
//  HelloMustache.swift
//  HelloPerfectAssistant
//
//  Created by David Hakanson on 4/9/17.
//
//

import PerfectHTTP
import PerfectMustache

struct MustacheHelper: MustachePageHandler {
    var values: MustacheEvaluationContext.MapType
    
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        contxt.extendValues(with: values)
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.appendBody(string: "Error: \(error)")
                .completed(status: .internalServerError)
        }
    }
}

final class HelloMustache {
    func renderTemplate(req: HTTPRequest, res: HTTPResponse) {
        var values = MustacheEvaluationContext.MapType()
        values["name"] = "Trey Hakanson"
        
        mustacheRequest(request: req, response: res, handler: MustacheHelper(values: values), templatePath: req.documentRoot + "/hello.mustache")
    }
    
    func renderTemplateAlt(req: HTTPRequest, res: HTTPResponse) {
        guard let name = req.urlVariables["name"] else {
            res.setBody(string: "400 Bad Request")
                .completed(status: .badRequest)
            return
        }
        var values = MustacheEvaluationContext.MapType()
        values["name"] = name
        
        mustacheRequest(request: req, response: res, handler: MustacheHelper(values: values), templatePath: req.documentRoot + "/hello.mustache")
    }
    
    func renderTemplateAll(req: HTTPRequest, res: HTTPResponse) {
        var values = MustacheEvaluationContext.MapType()
        values["users"] = [
            ["name": "Trey Hakanson", "email": "trey@hatchli.io"],
            ["name": "Eileen Guan", "email": "eguan@gmail.com"],
            ["name": "Drew Hakanson", "email": "dhak@gmail.com"],
            ["name": "Grant Hakanson", "email": "ghak@gmail.com"]
        ]
        
        mustacheRequest(request: req, response: res, handler: MustacheHelper(values: values), templatePath: req.documentRoot + "/hello-all.mustache")
    }
    
    func renderTemplateNone(req: HTTPRequest, res: HTTPResponse) {
        let values = MustacheEvaluationContext.MapType()
        
        mustacheRequest(request: req, response: res, handler: MustacheHelper(values: values), templatePath: req.documentRoot + "/hello-all.mustache")
    }
}
