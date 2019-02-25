import Foundation
import SmokeHTTP1
import SmokeOperationsHTTP1
import NIOHTTP1
import HeliumLogger
import LoggerAPI
import Service
import Shell

typealias SmokeHandlerSelector = StandardSmokeHTTP1HandlerSelector
typealias JSONDelegate = JSONPayloadHTTP1OperationDelegate
typealias HandlerSelector = SmokeHandlerSelector<ApplicationContext, JSONDelegate>

let logger = HeliumLogger()
Log.logger = logger

let services = [
    (path: "/echo", method: HTTPMethod.POST, type: EchoService.self)
]

func createHandlerSelector() -> HandlerSelector {
    var handlerSelector = HandlerSelector(
        defaultOperationDelegate: ApplicationContext.operationDelegate
    )
    services.forEach { service in
        handlerSelector.addHandlerForUri(service.path, httpMethod: service.method, handler: service.type.serviceHandler)
    }
    return handlerSelector
}

do {
    Log.info("Starting Server")
    Log.info("Verifying shell availability.  Hostname = \(shell.hostname())")
    try SmokeHTTP1Server.startAsOperationServer(
        withHandlerSelector: createHandlerSelector(),
        andContext: ApplicationContext()
    )
} catch {
    Log.error("Unable to start Operation Server: '\(error)'")
}
