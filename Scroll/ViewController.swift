import Cocoa
import SwiftUI

struct Case_1_ScrollView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<100, id: \.self) { index in
                    Text("\(index)")
                }
            }.frame(maxWidth: .infinity)
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
    struct DocumentView: View {
        var body: some View {
            VStack {
                ForEach(0..<100, id: \.self) { index in
                    Text("\(index)")
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
        }
    }
    
    override func loadView() {
        let scrollView = NSTextView.scrollableTextView()
        let textView = scrollView.documentView as? NSTextView
        textView?.string = String(repeating: "MMM\n", count: 100)
        view = scrollView
    }
}

class ViewController: NSViewController {
    let case_1 = NSHostingController(rootView: Case_1_ScrollView())
    let case_2 = NSHostingController(rootView: Case_2_List())
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
            wrapper.widthAnchor.constraint(equalToConstant: 600),
        ])
        
        case_1.view.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(case_1.view)
        NSLayoutConstraint.activate([
            case_1.view.topAnchor.constraint(equalTo: wrapper.topAnchor),
            case_1.view.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
            case_1.view.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
            case_1.view.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
        ])
        
        case_2.view.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(case_2.view)
        NSLayoutConstraint.activate([
            case_2.view.topAnchor.constraint(equalTo: wrapper.topAnchor),
            case_2.view.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
            case_2.view.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
            case_2.view.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
        ])
        
        case_3.view.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(case_3.view)
        NSLayoutConstraint.activate([
            case_3.view.topAnchor.constraint(equalTo: wrapper.topAnchor),
            case_3.view.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
            case_3.view.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
            case_3.view.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
        ])
        
        switchCase(segment)
    }

    @objc func switchCase(_ sender: NSSegmentedControl) {
        switch sender.selectedSegment {
        case 0:
            case_1.view.isHidden = false
            case_2.view.isHidden = true
            case_3.view.isHidden = true
        case 1:
            case_1.view.isHidden = true
            case_2.view.isHidden = false
            case_3.view.isHidden = true
        case 2:
            case_1.view.isHidden = true
            case_2.view.isHidden = true
            case_3.view.isHidden = false
        default:
            break
        }
    }
}

