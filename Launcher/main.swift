import Foundation

@objc(XPCServiceProtocol)
public protocol XPCServiceProtocol {
    func call(withReply reply: @escaping () -> Void)
}

let connection = NSXPCConnection(machServiceName: "com.intii.example.mach.service.name")
connection.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)
connection.resume()
let service = connection.remoteObjectProxyWithErrorHandler { print($0) } as! XPCServiceProtocol
service.call(withReply: {})

print("O")
RunLoop.current.run()
