//
//  VoiceShortcutsDataManager.swift
//  FastCaico
//
//  Created by Yuri on 15/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import Foundation
import Intents
import os.log

class VoiceShortcutsDataManager {
    static var shared = VoiceShortcutsDataManager()
    private init() {
        updateVoiceShortcuts(completion: nil)
    }
    
    private var shortcuts = [INVoiceShortcut]()
    
    func voiceShortcut(for order: FoodOrder) -> INVoiceShortcut? {
        let voiceShorcut = shortcuts.first { (voiceShortcut) -> Bool in
            guard let intent = voiceShortcut.__shortcut.intent as? OrderFoodIntent,
                let orderFromIntent = FoodOrder(intent: intent) else {
                    return false
            }
            return order == orderFromIntent
        }
        return voiceShorcut
    }
    
    
    func updateVoiceShortcuts(completion: (() -> Void)?) {
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { (voiceShortcutsFromCenter, error) in
            guard let voiceShortcutsFromCenter = voiceShortcutsFromCenter else {
                if let error = error as NSError? {
                    os_log("Failed to fetch voice shortcuts with error: %@", log: OSLog.default, type: .error, error)
                }
                return
            }
            self.shortcuts = voiceShortcutsFromCenter
            if let completion = completion {
                completion()
            }
        }
    }
}
