//
//  ViewController.swift
//  Home
//
//  Created by Вероника Садовская on 14.09.2018.
//  Copyright © 2018 Veronika Sadovskaya. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
	
	@IBOutlet var sceneView: ARSCNView!
	let positionTreeArray = [SCNVector3(0.2, -0.2, -2.5), SCNVector3(-0.2, -0.2, -2.5),SCNVector3(0.8, -0.2, -3.25),SCNVector3(-0.8, -0.2, -3.25), SCNVector3(0.2, -0.2, -4) , SCNVector3(-0.2, -0.2, -4), SCNVector3(0.2, -0.2, -4)]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
		
		// Set the view's delegate
		sceneView.delegate = self
		
		// Show statistics such as fps and timing information
		sceneView.showsStatistics = true
		sceneView.autoenablesDefaultLighting = true
		loadHome()
		loadTree()
	}
	
	func loadHome() {
		// Create a new scene
		let scene = SCNScene(named: "art.scnassets/home.scn")!
		
		// Set the scene to the view
		sceneView.scene = scene
	}
	
	func loadTree() {
		positionTreeArray.forEach{
			
			let nodeCylinder = SCNNode()
			nodeCylinder.position = $0
			let cylinder = SCNCylinder(radius: 0.01, height: 0.1)
			cylinder.firstMaterial?.diffuse.contents = UIColor.brown
			nodeCylinder.geometry = cylinder
			sceneView.scene.rootNode.addChildNode(nodeCylinder)
			
			let nodeSphere = SCNNode()
			nodeSphere.position = SCNVector3(nodeCylinder.position.x, nodeCylinder.position.y + 0.1, nodeCylinder.position.z)
			let sphere = SCNSphere(radius: 0.05)
			sphere.firstMaterial?.diffuse.contents = UIColor.green
			nodeSphere.geometry = sphere
			sceneView.scene.rootNode.addChildNode(nodeSphere)
		}
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Create a session configuration
		let configuration = ARWorldTrackingConfiguration()
		
		// Run the view's session
		sceneView.session.run(configuration)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		// Pause the view's session
		sceneView.session.pause()
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
