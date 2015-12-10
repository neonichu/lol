import Chores
import Decodable
import Foundation

struct SimCtlOutput: Decodable {
  let devices: [Device]
  let deviceTypes: [DeviceType]
  let runtimes: [Runtime]

  static func decode(json: AnyObject) throws -> SimCtlOutput {
    let deviceFamilies = (try json => "devices") as! [String : AnyObject]
    var devices = [Device]()

    for deviceFamily in deviceFamilies {
      for deviceDictionary in (deviceFamily.1 as! NSArray) {
        let dict = deviceDictionary as! NSDictionary
        let device = Device(
            availability: (dict["availability"] as? String) ?? "",
            name: (dict["name"] as? String) ?? "",
            state: (dict["state"] as? String) ?? "",
            udid: (dict["udid"] as? String) ?? ""
        )
        devices.append(device)
      }
    }

    return try SimCtlOutput(
        devices: devices,
        deviceTypes: json => "devicetypes",
        runtimes: json => "runtimes"
    )
  }
}

public struct Device: CustomStringConvertible, Decodable {
  private let availability: String
  public let name: String
  private let state: String
  public let udid: String

  public var description: String {
    return "\(name) (\(udid)) (\(state))"
  }

  public static func decode(json: AnyObject) throws -> Device {
    return try Device(
        availability: json => "availability",
        name: json => "name",
        state: json => "state",
        udid: json => "udid"
    )
  }
}

public struct DeviceType: Decodable {
  public let identifier: String
  public let name: String

  public static func decode(json: AnyObject) throws -> DeviceType {
    return try DeviceType(
        identifier: json => "identifier",
        name: json => "name"
    )
  }
}

public struct Runtime: Decodable {
  private let availability: String
  private let buildVersion: String
  public let identifier: String
  public let name: String
  public let version: String

  public static func decode(json: AnyObject) throws -> Runtime {
    return try Runtime(
        availability: json => "availability",
        buildVersion: json => "buildversion",
        identifier: json => "identifier",
        name: json => "name",
        version: json => "version"
    )
  }
}

public class SimCtl {
  private let output: SimCtlOutput

  public init() throws {
    let result = >["xcrun", "simctl", "list", "--json"]

    if let data = result.stdout.dataUsingEncoding(NSUTF8StringEncoding) {
      let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
      output = try SimCtlOutput.decode(json)
    } else {
      fatalError("Did not receive data from `simctl`")
    }
  }

  public var devices: [Device] { return output.devices }

  public func createDefaults() {
    for deviceType in output.deviceTypes {
      for runtime in output.runtimes {
        let _ = >["xcrun", "simctl", "create", deviceType.name, deviceType.identifier,
            runtime.identifier]
      }
    }
  }

  public func delete(device: Device) {
    let _ = >["xcrun", "simctl", "delete", device.udid]
  }
}
