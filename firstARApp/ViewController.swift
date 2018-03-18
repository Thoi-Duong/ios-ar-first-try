//
//  ViewController.swift
//  firstARApp
//
//  Created by thoiduong on 6/10/17.
//  Copyright © 2017 thoiduong. All rights reserved.
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
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // add tap event handler
        
        let tapGusture = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(gestureRecognize:)))
        view.addGestureRecognizer(tapGusture)
    }
    
    @objc func tapAction(gestureRecognize: UITapGestureRecognizer){
        
        guard let currentFrame = sceneView.session.currentFrame else {
            return
        }
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.2
        let transform = simd_mul(currentFrame.camera.transform, translation)
        
        // Add a new anchor to the session.
        let anchor = ARAnchor(transform: transform)
        sceneView.session.add(anchor: anchor)
    }
    
    // (Elsewhere...) Provide a label node to represent the anchor.
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        return SKLabelNode(text: "👾")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // configaration
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
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
