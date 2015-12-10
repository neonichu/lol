import Commander
import SimCtl

Group {
  $0.command("list") {
    let simctl = try SimCtl()
    let _ = simctl.devices.map { print($0) }
  }

  $0.command("delete") {
  	let simctl = try SimCtl()
  	let _ = simctl.devices.map { simctl.delete($0) }
  }

  $0.command("create_defaults") {
  	let simctl = try SimCtl()
  	simctl.createDefaults()
  }
}.run()
