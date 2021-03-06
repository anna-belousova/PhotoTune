//
//  Throttler.swift
//  PhotoTune
//
//  Created by Mikhail Medvedev on 14.01.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

/*
USAGE:

// let throttler = Throttler(minimumDelay: 0.5)
func frequentlyCalledMethod() {

//    Throttling our computationally expensive task will ensure
//    that it is only run once after 0.5 seconds have elapsed since last being requested,
//    preventing excessive computation in the case that this method is called with high frequency

throttler.throttle {
computationallyExpensiveTask()
}
}

func computationallyExpensiveTask() {
// It's a fake! 😱
}

*/

import Foundation
final class Throttler
{
	private var workItem = DispatchWorkItem(block: {})
	private var previousRun = Date.distantPast
	private let queue: DispatchQueue
	private let minimumDelay: TimeInterval

	init(minimumDelay: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
		self.minimumDelay = minimumDelay
		self.queue = queue
	}

	func throttle(_ block: @escaping () -> Void) {
		// Cancel any existing work item if it has not yet executed
		workItem.cancel()

		// Re-assign workItem with the new block task, resetting the previousRun time when it executes
		workItem = DispatchWorkItem {
			[weak self] in
			self?.previousRun = Date()
			block()
		}

		// If the time since the previous run is more than the required minimum delay
		// => execute the workItem immediately
		// else
		// => delay the workItem execution by the minimum delay time
		let delay = previousRun.timeIntervalSinceNow > minimumDelay ? 0 : minimumDelay
		queue.asyncAfter(deadline: .now() + Double(delay), execute: workItem)
	}
}
