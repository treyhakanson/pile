import PerfectLib
import PerfectHTTPServer
import PerfectHTTP

var server = HTTPServer()
server.serverPort = 8080
server.documentRoot = "Webroot"

var routes = Routes()

let hm = HelloMustache()

routes.add(method: .get, uri: "/hello-mustache", handler: hm.renderTemplate)
routes.add(method: .get, uri: "/hello-mustache/{name}", handler: hm.renderTemplateAlt)
routes.add(method: .get, uri: "/hello-all", handler: hm.renderTemplateAll)
routes.add(method: .get, uri: "/hello-none", handler: hm.renderTemplateNone)

server.addRoutes(routes)

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Server errored with \(err) \(msg)")
}
