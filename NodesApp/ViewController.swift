//
//  ViewController.swift
//  NodesApp
//
//  Created by Sasi on 8/19/18.
//  Copyright © 2018 Sasi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func actionOne(_ sender: Any) {
        let nodeA = MyNode(name: "A")
        let nodeB = MyNode(name: "B")
        let nodeC = MyNode(name: "C")
        let nodeD = MyNode(name: "D")
        let nodeE = MyNode(name: "E")
        let nodeF = MyNode(name: "F")
        
        nodeA.connections.append(Connection(to: nodeB, weight: 1))
        nodeB.connections.append(Connection(to: nodeC, weight: 3))
        nodeC.connections.append(Connection(to: nodeD, weight: 1))
        nodeB.connections.append(Connection(to: nodeE, weight: 1))
        nodeE.connections.append(Connection(to: nodeC, weight: 1))
        nodeC.connections.append(Connection(to: nodeF, weight: 1))
        
        let sourceNode = nodeA
        let destinationNode = nodeC
        
        var path = shortestPath(source: sourceNode, destination: destinationNode)
        
        if let succession: [String] = path?.array.reversed().flatMap({ $0 as? MyNode}).map({$0.name}) {
            print("🏁 Quickest path: \(succession)")
        } else {
            print("💥 No path between \(sourceNode.name) & \(destinationNode.name)")
        }
    }
    
    @IBAction func actionTwo(_ sender: Any) {
        let nodeA = MyNode(name: "A")
        let nodeB = MyNode(name: "B")
        let nodeC = MyNode(name: "C")
        let nodeD = MyNode(name: "D")
        let nodeE = MyNode(name: "E")
        let nodeF = MyNode(name: "F")
        
        nodeA.connections.append(Connection(to: nodeB, weight: 1))
        nodeB.connections.append(Connection(to: nodeC, weight: 3))
        nodeC.connections.append(Connection(to: nodeD, weight: 1))
        nodeB.connections.append(Connection(to: nodeE, weight: 1))
        nodeE.connections.append(Connection(to: nodeC, weight: 1))
        nodeC.connections.append(Connection(to: nodeF, weight: 1))
        
        let sourceNode = nodeA
        let destinationNode = nodeF
        
        var path = shortestPath(source: sourceNode, destination: destinationNode)
        
        if let succession: [String] = path?.array.reversed().flatMap({ $0 as? MyNode}).map({$0.name}) {
            print("🏁 Quickest path: \(succession)")
        } else {
            print("💥 No path between \(sourceNode.name) & \(destinationNode.name)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
       
        
        
       
        
        

        
    }
    
    func shortestPath(source: Node, destination: Node) -> Path? {
        var frontier: [Path] = [] {
            didSet { frontier.sort { return $0.cumulativeWeight < $1.cumulativeWeight } } // the frontier has to be always ordered
        }
        
        frontier.append(Path(to: source)) // the frontier is made by a path that starts nowhere and ends in the source
        
        while !frontier.isEmpty {
            let cheapestPathInFrontier = frontier.removeFirst() // getting the cheapest path available
            guard !cheapestPathInFrontier.node.visited else { continue } // making sure we haven't visited the node already
            
            if cheapestPathInFrontier.node === destination {
                return cheapestPathInFrontier // found the cheapest path 😎
            }
            
            cheapestPathInFrontier.node.visited = true
            
            for connection in cheapestPathInFrontier.node.connections where !connection.to.visited { // adding new paths to our frontier
                frontier.append(Path(to: connection.to, via: connection, previousPath: cheapestPathInFrontier))
            }
        } // end while
        return nil // we didn't find a path 😣
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    

}


