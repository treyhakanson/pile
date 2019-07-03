//: Playground - noun: a place where people can play

import UIKit



class Comment {
    
    var text: String
    var subcomments: Array<Comment>
    
    init(text: String, subcomments: Array<Comment>) {
        self.text = text
        self.subcomments = subcomments
    }
    
}

var finalComment: Comment = Comment(text: "final comment", subcomments: [])

var subComment1: Comment = Comment(text: "subcomment 1", subcomments: [])
var subComment2: Comment = Comment(text: "subcomment 2", subcomments: [finalComment])
var subComment3: Comment = Comment(text: "subcomment 3", subcomments: [])
var subComment4: Comment = Comment(text: "subcomment 4", subcomments: [])

var innerComment1: Comment = Comment(text: "inner comment 1", subcomments: [subComment1, subComment2])
var innerComment2: Comment = Comment(text: "inner comment 2", subcomments: [subComment3, subComment4])

var parentComment: Comment = Comment(text: "some text", subcomments: [innerComment1, innerComment2])



// recursively iterate from parent comment downward through subcomments
// the outermost (initial) level of comments may have multiple, and thus
// the func (TableView initializer) must handle the "super comment" as
// an array of comments

// format of comments on database can easily be done using JSON arrays:
// Comment {
//    text: "example text"
//    subcomments: [
//    
//        Comment {
//            text: "example text"
//            subcomments: []
//        }
//    
//        Comment {
//            text: "example text"
//            subcomments: []
//        }
//    ]
//
// }

func iterateOverComments(comments: Array<Comment>, var level: Int) {
    
    // increase the current level
    level++
    
    // iterate over outermost level of comments downward
    for comment in comments {
    
        // if subcomments exist
        if !comment.subcomments.isEmpty {
            
            // arbitary code to show level
            var str = ""
            var tmp = level
            while (tmp > 0) {
                str += "-"
                tmp--
            }
            
            // handle the text of the current comment
            print(str + comment.text)
            
            // handle the subcomments as a new parent comment
            iterateOverComments(comment.subcomments, level: level)
        }
            
        // if no sub comments exist
        else {
            
            // arbitary code to show level
            var str = ""
            var tmp = level
            while (tmp > 0) {
                str += "-"
                tmp--
            }
            
            // handle the text accordingly
            print(str + comment.text)
            
        }
        
    }
    
}

iterateOverComments([parentComment], level: 0)














