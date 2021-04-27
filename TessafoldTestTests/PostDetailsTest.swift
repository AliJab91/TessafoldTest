//
//  PostDetailsTest.swift
//  TessafoldTestTests
//
//  Created by Ali jaber on 27/04/2021.
//

import XCTest
@testable import TessafoldTest
class PostDetailsTest: XCTestCase {
    var detailsViewController: PostDetailsViewController!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Posts", bundle: nil)
        self.detailsViewController =  storyboard.instantiateViewController(withIdentifier: "PostDetailsViewController") as? PostDetailsViewController
        self.detailsViewController.loadView()
        self.detailsViewController.viewDidLoad()
    }
    
    func test_setTableView() {
        XCTAssertNotNil(detailsViewController.tableView)
    }
    
    func test_HasDelegate() {
        XCTAssertNotNil(detailsViewController.tableView.delegate)
    }
    
    func test_tableViewConfromsToDelegateProtocol() {
        XCTAssertTrue(detailsViewController.conforms(to: UITableViewDelegate.self))
    }
    
    func test_TableViewHasDataSource() {
        XCTAssertNotNil(detailsViewController.tableView.dataSource)
    }
    
    func test_tableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(detailsViewController.conforms(to: UITableViewDataSource.self))
    }
    
    func test_tableViewConformsToCellForRow() {
        XCTAssertTrue(detailsViewController.responds(to: #selector(detailsViewController.tableView(_:cellForRowAt:))))
    }
    
    func test_tableiewConformsToNumberOfRows() {
        XCTAssertTrue(detailsViewController.responds(to: #selector(detailsViewController.tableView(_:numberOfRowsInSection:))))
    }
    
    func test_tableViewCellGeneralHasReuseIdentifier() {
           let cell = detailsViewController.tableView(detailsViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? GeneralInformationCell
           let actualReuseIdentifer = cell?.reuseIdentifier
           let expectedReuseIdentifier = "GeneralInformationCell"
           XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
       }
    
    func test_tableViewCellCommentHasReuseIdentifier() {
           let cell = detailsViewController.tableView(detailsViewController.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? CommentCell
           let actualReuseIdentifer = cell?.reuseIdentifier
           let expectedReuseIdentifier = "CommentCell"
           XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
       }
    
    
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
