//
//  ViewController.swift
//  HackAR
//
//  Created by Newton Law on 05/09/2019.
//  Copyright © 2019 Newton Law. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
//        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        guard let referenceObjects = ARReferenceObject.referenceObjects(inGroupNamed: "KeysightObjects", bundle: Bundle.main) else {return}
        
        configuration.detectionObjects = referenceObjects
        
//        configuration.planeDetection = .horizontal
//
//        sceneView.session.run(configuration, options: .resetTracking)

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let objectAnchor = anchor as? ARObjectAnchor {
            let plane = SCNPlane(width: CGFloat(objectAnchor.referenceObject.extent.x * 0.8), height: CGFloat(objectAnchor.referenceObject.extent.y * 0.5))

            plane.cornerRadius = plane.width / 12

            let spriteKitScene = SKScene(fileNamed: "ProductInfo")

            plane.firstMaterial?.diffuse.contents = spriteKitScene
            plane.firstMaterial?.isDoubleSided = true
            plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.095, objectAnchor.referenceObject.center.z + 0.1)
            
            node.addChildNode(planeNode)
            
            print("daq object detected.")
        }
        
        return node
    }
    @IBAction func onCallBtnPressed(_ sender: Any) {
        print("call btn pressed.")
        let url: NSURL = URL(string: "TEL://1800888848")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func onNotificationBtnPressed(_ sender: Any) {
        print("notification btn pressed.")
        if let url = NSURL(string: "https://www.keysight.com/en/pc-1000000676%3Aepsg%3Apgr/data-acquisition-daq?nid=-33257.0.00&cc=MY&lc=eng"){
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func onProductWebsiteBtnPressed(_ sender: Any) {
        print("product website btn pressed")
        if let url = NSURL(string: "https://www.keysight.com/en/pd-1756491-pn-34972A/lxi-data-acquisition-data-logger-switch-unit?cc=MY&lc=eng"){
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func onDocumentationBtnPressed(_ sender: Any) {
        print("documentation btn pressed")
        if let url = NSURL(string: "https://literature.cdn.keysight.com/litweb/pdf/34972-90001.pdf?id=1837993"){
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
