import XCTest
import SwiftUI
@testable import ViewInspector

#if os(macOS)

final class TouchBarTests: XCTestCase {
    
    func testEnclosedView() throws {
        let view = TouchBar(content: { Text("Test") })
        let sut = try view.inspect().text().string()
        XCTAssertEqual(sut, "Test")
    }
    
    func testTouchBarID() throws {
        let view = EmptyView().touchBar(TouchBar(id: "abc", content: { Text("") }))
        let sut = try view.inspect().emptyView().touchBar().touchBarID()
        XCTAssertEqual(sut, "abc")
    }
}

// MARK: - View Modifiers

final class GlobalModifiersForTouchBar: XCTestCase {
    
    func testTouchBar() throws {
        let sut = EmptyView().touchBar(TouchBar(content: { Text("") }))
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testTouchBarInspection() throws {
        let view = EmptyView().touchBar(TouchBar(content: { Text("") })).padding()
        let sut = try view.inspect().emptyView().touchBar()
        XCTAssertEqual(sut.content.modifiers.count, 0)
    }
    
    func testTouchBarItemPrincipal() throws {
        let sut = EmptyView().touchBarItemPrincipal(true)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testTouchBarItemPrincipalInspection() throws {
        let sut1 = try EmptyView().touchBarItemPrincipal(true)
            .inspect().emptyView().touchBarItemPrincipal()
        XCTAssertTrue(sut1)
        let sut2 = try EmptyView().touchBarItemPrincipal(false)
            .inspect().emptyView().touchBarItemPrincipal()
        XCTAssertFalse(sut2)
    }
    
    func testTouchBarCustomizationLabel() throws {
        let sut = EmptyView().touchBarCustomizationLabel(Text(""))
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testTouchBarCustomizationLabelInspection() throws {
        let sut = try EmptyView().touchBarCustomizationLabel(Text("abc"))
            .inspect().emptyView().touchBarCustomizationLabel().string()
        XCTAssertEqual(sut, "abc")
    }
    
    func testTouchBarItemPresence() throws {
        let sut = EmptyView().touchBarItemPresence(.required(""))
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testTouchBarItemPresenceInspection() throws {
        let presence: TouchBarItemPresence = .optional("abc")
        let sut = try EmptyView().touchBarItemPresence(presence)
            .inspect().emptyView().touchBarItemPresence()
        XCTAssertEqual(sut, presence)
    }
}

extension TouchBarItemPresence: BinaryEquatable { }

#endif