//
//  MouseMover.swift
//  Mouse Mover
//
//  Created by Admin on 17/04/2023.
//

import Cocoa
import Quartz

class MouseMover {
    
    private var timer: Timer?

    func startMovingMouse(interval: TimeInterval, distance: CGFloat) {
        self.stopMovingMouse()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            self.moveMouse(distance: distance)
        }
    }
    
    func stopMovingMouse() {
        self.timer?.invalidate()
        self.timer = nil
    }

    private func moveMouse(distance: CGFloat) {
        let currentLocation = NSEvent.mouseLocation
        let newLocation = CGPoint(x: currentLocation.x + distance, y: currentLocation.y + distance)
        
        CGDisplayMoveCursorToPoint(CGMainDisplayID(), newLocation)
    }
    
}
