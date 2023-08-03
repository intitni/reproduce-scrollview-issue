import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet var window: NSWindow!
    let viewController = ViewController(nibName: nil, bundle: nil)

    func applicationDidFinishLaunching(_: Notification) {
        window.contentView = viewController.view
    }

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_: NSApplication) -> Bool {
        return true
    }
}

struct Case_1_ScrollView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<100, id: \.self) { index in
                    Text("\(index)")
                }
            }
        }
    }
}

struct Case_2_List: View {
    var body: some View {
        List {
            ForEach(0..<100, id: \.self) { index in
                Text("\(index)")
            }
        }
    }
}

class Case_3_NSScrollView: NSViewController {
    override func loadView() {
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.documentView = NSHostingView(rootView: Case_1_ScrollView())
        view = scrollView
    }
}

class ViewController: NSViewController {
    let case_1 = NSHostingView(rootView: Case_1_ScrollView())
    let case_2 = NSHostingView(rootView: Case_2_List())
    let case_3 = Case_3_NSScrollView()
    let wrapper = NSView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let segment = NSSegmentedControl(
            labels: ["ScrollView", "List", "NSScrollView"],
            trackingMode: .selectOne,
            target: self,
            action: #selector(switchCase(_:))
        )
        segment.selectedSegment = 0
        segment.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        segment.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segment)
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            segment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wrapper)
        NSLayoutConstraint.activate([
            wrapper.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 20),
            wrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            wrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            wrapper.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
        
        case_1.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(case_1)
        NSLayoutConstraint.activate([
            case_1.topAnchor.constraint(equalTo: wrapper.topAnchor),
            case_1.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
            case_1.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
            case_1.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
        ])
        
        case_2.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(case_2)
        NSLayoutConstraint.activate([
            case_2.topAnchor.constraint(equalTo: wrapper.topAnchor),
            case_2.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
            case_2.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
            case_2.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
        ])
        
        case_3.view.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(case_3.view)
        NSLayoutConstraint.activate([
            case_3.view.topAnchor.constraint(equalTo: wrapper.topAnchor),
            case_3.view.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
            case_3.view.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
            case_3.view.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
        ])
    }

    @objc func switchCase(_ sender: NSSegmentedControl) {
        switch sender.selectedSegment {
        case 0:
            case_1.alphaValue = 1
            case_2.alphaValue = 0
            case_3.view.alphaValue = 0
        case 1:
            case_1.alphaValue = 0
            case_2.alphaValue = 1
            case_3.view.alphaValue = 0
        case 2:
            case_1.alphaValue = 0
            case_2.alphaValue = 0
            case_3.view.alphaValue = 1
        default:
            break
        }
    }
}

