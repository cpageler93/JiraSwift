# JiraSwift

![Platforms](https://img.shields.io/badge/Platforms-iOS|macOS|tvOS|watchOS|Linux-yellow.svg?style=flat)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/cpageler93/JiraSwift/blob/master/LICENSE)
[![Twitter: @cpageler93](https://img.shields.io/badge/contact-@cpageler93-lightgrey.svg?style=flat)](https://twitter.com/cpageler93)

Jira Client for Swift


## Usage


### Framework

#### JQL Search

```swift
let client = Jira.Client(baseURL: "https://jira.tinyspeck.com",
                         username: "your_username",
                         password: "your_password")

do {
    let searchResult = try client.search(jql: "key in (XXX027-65, XXX038-3, XXX027-58)").wait()
    for issue in searchResult.issues {
        print("\(issue.key): \(issue.fields.assignee?.name ?? "NONE" )")
    }
} catch Jira.ClientError.jiraError(let error) {
    print(error.errorMessages)
} catch {
    print(error)
}

```

### CLI

#### JQL Search

```shell
# setup environment
JIRA_URL=https://your_jira_url
JIRA_USERNAME=your_username
JIRA_PASSWORd=your_password #or leave it blank and get prompted from JiraSwiftCLI

./JiraSwiftCLI search "key in (XYZ027-65, XYZ038-3, XYZ027-58)"
```

Or pass all values as options to JiraSwiftCLI

```shell
.build/debug/JiraSwiftCLI search "key in (XYZ027-65, XYZ038-3, XYZ027-58)" --url "https://your_jira_url" --username "your_username" --password "your_password"
```
