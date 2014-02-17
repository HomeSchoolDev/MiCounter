//
//  SPAlertView.h
//  snaper
//
//  Created by Derek Maurer on 1/26/14.
//  Copyright (c) 2014 Home School Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPAlertView;

typedef void(^SPAlertViewFinished)(SPAlertView *alert,int);

@interface SPAlertView : UIView
- (id)initWithTitle:(NSString*)title message:(NSString*)message buttons:(NSArray*)buttons cancelButton:(NSString*)cancel andFinishedBlock:(SPAlertViewFinished)finishedBlock;
- (void)show;
- (void)dismiss;
@end
