//
//  PostsTest.swift
//  TessafoldTestTests
//
//  Created by Ali jaber on 27/04/2021.
//

import XCTest
@testable import TessafoldTest
class PostsTest: XCTestCase {
    var postsViewController: PostsViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Posts", bundle: nil)
        self.postsViewController =  storyboard.instantiateViewController(withIdentifier: "PostsViewController") as? PostsViewController
        self.postsViewController.loadView()
        self.postsViewController.viewDidLoad()
    }
    
    func test_setTableView() {
        XCTAssertNotNil(self.postsViewController.tableView)
    }
    
    func test_HasDelegate() {
        XCTAssertNotNil(postsViewController.tableView.delegate)
    }
    
    func test_tableViewConfromsToDelegateProtocol() {
        XCTAssertTrue(self.postsViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(self.postsViewController.responds(to: #selector(self.postsViewController.tableView(_:didSelectRowAt:))))
    }
    
    func test_TableViewHasDataSource() {
        XCTAssertNotNil(self.postsViewController.tableView.dataSource)
    }
    
    func test_tableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(self.postsViewController.conforms(to: UITableViewDataSource.self))
    }
    
    func test_tableViewConformsToCellForRow() {
        XCTAssertTrue(self.postsViewController.responds(to: #selector(self.postsViewController.tableView(_:cellForRowAt:))))
    }
    
    func test_tableiewConformsToNumberOfRows() {
        XCTAssertTrue(self.postsViewController.responds(to: #selector(self.postsViewController.tableView(_:numberOfRowsInSection:))))
    }
    
    func test_tableViewCellHasReuseIdentifier() {
           let cell = self.postsViewController.tableView(self.postsViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? PostsCell
           let actualReuseIdentifer = cell?.reuseIdentifier
           let expectedReuseIdentifier = "PostsCell"
           XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
       }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
