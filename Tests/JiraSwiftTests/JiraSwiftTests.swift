import XCTest
@testable import JiraSwift

class JiraSwiftTests: XCTestCase {
    
    func testExample() {
        let e = expectation(description: "searchExpecation")
        let jiraClient = JiraClient(url: URL(string: "https://yourjiraurl")!,
                                    authorizationHeaderValue: "Basic base64(username:password)")
        jiraClient.search(jql: "key in (xyz, abc)") { result in
            print("result: \(result)")
            
            e.fulfill()
        }
        
        waitForExpectations(timeout: 15, handler: nil)
    }

}
