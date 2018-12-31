import UIKit

let goodButtonsDictionary = ["scene1": "Go outside and fashion a torch", "scene2": "Try to door handle to open the door gently"  , "scene3": "Take the tapestry off the wall and cover the crow with it.", "scene4" : "Attack the goblin", "scene5" : ""]
let badButtonsDictionary = ["scene1": "Continue walking deeper into the cave despite the darkness", "scene2": "Hello"  , "scene3": "Go outside and fashion a torch", "scene4" : "aaa", "scene5" : ""]
let neutralButtonsDictionary = ["scene1": "Shout a greeting and hope someone does (or does not) respond", "scene2": "Hello"  , "scene3": "Go outside and fashion a torch", "scene4" : "ddd", "scene5" : ""]

enum UserDecision {
    case good
    case bad
    case neutral
}

func changeButtonTitles(condition: UserDecision, scene: String) -> String {
    switch condition {
    case .good:
        guard let returnValue = goodButtonsDictionary["\(scene)"] else {return "Could not get title"}
        return returnValue
    case .bad:
        guard let returnValue = badButtonsDictionary["\(scene)"] else {return "Could not get title"}
        return returnValue
    case .neutral:
        guard let returnValue = neutralButtonsDictionary["\(scene)"] else {return "Could not get title"}
        return returnValue
    }
}

print(changeButtonTitles(condition: .neutral, scene: "scene4"))
