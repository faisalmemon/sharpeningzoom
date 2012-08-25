//
//  zmAppDelegate.h
//  ZoomingExample
//
//  Created by Faisal Memon on 23/08/2012.
//  Copyright (c) 2012 Faisal Memon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class zmViewController;

@interface zmAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) zmViewController *viewController;

@end
