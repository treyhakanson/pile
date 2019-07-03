import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// create the web server
let server = HTTPServer()
server.serverPort = 8080
server.documentRoot = "Webroot"

// create a routes object
var routes = Routes()

// create instances of route controllers
let hc = HelloController()

// add routes
routes.add(method: .get, uri: "/hello-world", handler: hc.greet)
routes.add(method: .get, uri: "/hello-world-json", handler: hc.greetWithJson)
// can set variables in routes using "{}". Note that for whatever
// dumb reason, this convention MUST be snake-case
routes.add(method: .get, uri: "/greet-many/{num_people}", handler: hc.greetMany)

// add the routes to the server
server.addRoutes(routes)

// start the web server
do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
