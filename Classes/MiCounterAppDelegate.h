//
//  MiCounterAppDelegate.h
//  MiCounter
//
//  Created by Derek on 6/22/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MiCounterViewController;

@interface MiCounterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MiCounterViewController *viewController;
	
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MiCounterViewController *viewController;

@end

