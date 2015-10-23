//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Guanqun Mao on 10/21/15.
//  Copyright © 2015 Guanqun Mao. All rights reserved.
//

import Foundation

class RecordedAudio:NSObject{
    var filePathUrl:NSURL!
    var title:String!
    
    init(title:String!, filePathUrl:NSURL!) {
        self.title = title
        self.filePathUrl = filePathUrl
    }
}
