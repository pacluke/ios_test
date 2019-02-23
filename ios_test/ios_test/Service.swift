//
//  Service.swift
//  ios_test
//
//  Created by Lucas Flores on 19/02/19.
//  Copyright © 2019 lucas.flores. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Moscapsule

public class Service {
    
    let mqttConfig: MQTTConfig
    var mqttClient: MQTTClient?
    
    init() {
        // set MQTT Client Configuration
        mqttConfig = MQTTConfig(clientId: "ambar-beyond", host: "ambar.mqtt.beyond.dm", port: 1883, keepAlive: 60)
        
        // create new MQTT Connection
        mqttClient = MQTT.newConnection(mqttConfig, connectImmediately: true)
        mqttConfig.onConnectCallback = { returnCode in
            if returnCode == ReturnCode.success {
                // something to do in case of successful connection
                print("AAAAAAAAAAAAAAAAAAAAAAAAAAAA")
            }
            else {
                // error handling for connection failure
            }
        }
        
    }
    
    public func publish(){
        mqttConfig.onPublishCallback = { messageId in
            print("published (msg id=\(messageId)))")
        }
        mqttConfig.onMessageCallback = { mqttMessage in
            print("MQTT Message received: payload=\(String(describing: mqttMessage.payloadString))")
            let receivedMessage = mqttMessage.payloadString!
            print("from server msg = \(receivedMessage)")
            
            let data = receivedMessage.data(using: .utf8, allowLossyConversion: false)!
            print("xxxxxxx = \(data)")
        }
        
        mqttClient?.publish(string: "10", topic: "interview/beyond/1/pub", qos: 0, retain: false)
    }
    
    public func subscribe(){
        mqttClient?.subscribe("interview/beyond/1/nfy/ambar-beyond", qos: 2)
        mqttConfig.onMessageCallback = { mqttMessage in
            print("MQTT Message received: payload=\(String(describing: mqttMessage.payloadString))")
            let receivedMessage = mqttMessage.payloadString!
            print("from server msg = \(receivedMessage)")
            
            let data = receivedMessage.data(using: .utf8, allowLossyConversion: false)!
            print("xxxxxxx = \(data)")
        }
    }
    
    public func disconnect(){
        self.mqttClient?.disconnect()
    }
    
}
