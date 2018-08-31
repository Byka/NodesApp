//
//  String.swift
//  NodesApp
//
//  Created by Sasi on 8/19/18.
//  Copyright © 2018 Sasi. All rights reserved.
//

import UIKit


    extension Path {
        var array: [Node] {
            var array: [Node] = [self.node]
            
            var iterativePath = self
            while let path = iterativePath.previousPath {
                array.append(path.node)
                
                iterativePath = path
            }
            
            return array
        }
    }


class Node {
    var visited = false
    var connections: [Connection] = []
}

class Connection {
    public let to: Node
    public let weight: Int
    
    public init(to node: Node, weight: Int) {
        assert(weight >= 0, "weight has to be equal or greater than zero")
        self.to = node
        self.weight = weight
    }
}

class Path {
    public let cumulativeWeight: Int
    public let node: Node
    public let previousPath: Path?
    
    init(to node: Node, via connection: Connection? = nil, previousPath path: Path? = nil) {
        if
            let previousPath = path,
            let viaConnection = connection {
            self.cumulativeWeight = viaConnection.weight + previousPath.cumulativeWeight
        } else {
            self.cumulativeWeight = 0
        }
        
        self.node = node
        self.previousPath = path
    }
}

// **** EXAMPLE BELOW ****
class MyNode: Node {
    let name: String
    
    init(name: String) {
        self.name = name
        super.init()
    }
}

