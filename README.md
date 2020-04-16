## WIP

**master** branch is in progress (upgrading to Swift 5.2 and [cpageler93/api-client](https://github.com/cpageler93/api-client))

# JiraSwift

![Swift](https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat)
![Platforms](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-lightgrey.svg?style=flat)
![Xcode](https://img.shields.io/badge/Xcode-11-blue.svg?style=flat)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/cpageler93/JiraSwift/blob/master/LICENSE)
[![Twitter: @cpageler93](https://img.shields.io/badge/contact-@cpageler93-blue.svg?style=flat)](https://twitter.com/cpageler93)

`JiraSwift` is a HTTP client for Jira implemented in swift based on [swift-server/async-http-client](https://github.com/swift-server/async-http-client).

## Framework Usage

### JQL Search

```swift
let jira = JiraClient(baseURL: "https://jira.tinyspeck.com", 
                      username: "your_username", 
                      password: "your_password")

// jira.search.post(jql: String) returns EventLoopFuture<SearchResult>
// you can work with .wait() or .whenComplete { result }
let result = try jira.search.post(jql: "key in (XXX027-65, XXX038-3, XXX027-58)").wait()

```

### Implemented Methods

| Implemented | Route / Method   | Route                      |
|:----------- |:---------------- |:-------------------------- |
|     ✅      | myself.get()     | [`/rest/api/2/myself`](https://docs.atlassian.com/software/jira/docs/api/REST/8.4.1/#api/2/myself) |
|     ✅      | search.post()    | [`/rest/api/2/search`](https://docs.atlassian.com/software/jira/docs/api/REST/8.4.1/#api/2/search) |
|     ✅      | serverInfo.get() | [`/rest/api/2/serverInfo`](https://docs.atlassian.com/software/jira/docs/api/REST/8.4.1/#api/2/serverInfo)     |
|     ✅      | project.list()   | [`/rest/api/2/project`](https://docs.atlassian.com/software/jira/docs/api/REST/8.4.1/#api/2/project) |
|     ✅      | project.types()  | [`/rest/api/2/project/type`](https://docs.atlassian.com/software/jira/docs/api/REST/8.4.1/#api/2/project/type) |

## Command Line Interface

### Environment

You can either setup your environment

```shell
# setup environment
JIRA_URL=https://your_jira_url
JIRA_USERNAME=your_username
JIRA_PASSWORD=your_password

jira search --jql "key in (XYZ027-65, XYZ038-3, XYZ027-58)"
```

Or pass all values as options to jira the command

```shell
jira search --url "https://your_jira_url" \
            --username "your_username" \
            --password "your_password" \
            --jql "key in (XYZ027-65, XYZ038-3, XYZ027-58)"
```

### Commands

| Command          | Description                |
| ---------------- | -------------------------- |
| `search`         | Search for Issues with JQL |
| `project list`   | List all projects          |
| `project types`  | List all project types     |


## Contribute

Feel free to add a missing REST API method or create an issue if you want me to implement it!

[Jira REST API Documentation](https://docs.atlassian.com/software/jira/docs/api/REST/8.4.1)
