# JiraSwift

![Platforms](https://img.shields.io/badge/Platforms-iOS|macOS|tvOS|watchOS|Linux-yellow.svg?style=flat)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/cpageler93/JiraSwift/blob/master/LICENSE)
[![Twitter: @cpageler93](https://img.shields.io/badge/contact-@cpageler93-lightgrey.svg?style=flat)](https://twitter.com/cpageler93)

Jira Client for Swift


## Usage


### Framework

#### JQL Search

```swift
let jiraClient = Jira.Client(url: URL(string: "https://your_jira_url")!,
                             username: "your_username",
                             password: "your_password")
jiraClient.search(jql: "key in (XXX027-65, XXX038-3, XXX027-58)") { result in
    switch result {
    case .success(let result):
        for issue in result.issues {
            print("issue: \(issue.key)")
        }
    case .failure:
    	break
    }
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