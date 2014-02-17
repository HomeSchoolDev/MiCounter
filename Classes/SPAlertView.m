//
//  SPAlertView.m
//  snaper
//
//  Created by Derek Maurer on 1/26/14.
//  Copyright (c) 2014 Home School Dev. All rights reserved.
//

#import "SPAlertView.h"
#import "AMBlurView.h"
#define kButtonBase 10101

@interface SPAlertView ()
{
    UIButton *backgroundDismissButton;
    UIView *dimView;
    UIView *alertView;
    UILabel *messageField;
    UILabel *titleField;
    AMBlurView *blurView;
}
@property (nonatomic) UIDynamicAnimator* animator;
@property (nonatomic) UISnapBehavior *snapBehavior;
@property (nonatomic, copy) SPAlertViewFinished finished;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) NSString *cancelButton;
@end

@implementation SPAlertView

- (id)initWithTitle:(NSString*)tit message:(NSString*)msg buttons:(NSArray*)btns cancelButton:(NSString*)cancel andFinishedBlock:(SPAlertViewFinished)finishedBlock
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (self)
    {
        self.finished = finishedBlock;
        self.title = tit;
        self.message = msg;
        self.buttons = [[NSMutableArray alloc] initWithArray:btns];
        self.cancelButton = cancel;
        
        UIColor *themeColor = [UIColor colorWithRed:0.063 green:0.486 blue:0.965 alpha:1.0];
        UIColor *oppositeColor = [UIColor whiteColor];
        
        if (self.cancelButton == nil || [self.cancelButton isEqualToString:@""])
        {
            NSLog(@"SPAlertView - cancel button must be present");
            return nil;
        }
        
        if (self.buttons.count > 2)
        {
            NSLog(@"SPAlertView - You cannot have more than 3 buttonts");
            return nil;
        }
        
        float alertWidth = [[UIScreen mainScreen] bounds].size.width - 40;
        float messageWidth = alertWidth - 20;

        float messageHeight = [self.message boundingRectWithSize:CGSizeMake(messageWidth, MAXFLOAT)
                                                  options:NSLineBreakByWordWrapping | NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}
                                                  context:nil].size.height;
        
        if (messageHeight > [[UIScreen mainScreen] bounds].size.height/2) messageHeight = [[UIScreen mainScreen] bounds].size.height/2;
        float titleHeight = 40; //arbitrary height
        float buttonHeight = 45;
        
        if (self.buttons == nil) self.buttons = [[NSMutableArray alloc] init];
        [self.buttons addObject:self.cancelButton];
        
        float buttonsHeight = [self.buttons count] * buttonHeight;
        float alertHeight = titleHeight + messageHeight + 20 + buttonsHeight;
        
        /*dimView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [dimView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.6]];
        [self addSubview:dimView];
        
        backgroundDismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backgroundDismissButton addTarget:self action:@selector(backgroundDismissButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [backgroundDismissButton setFrame:CGRectMake(0, 0, dimView.frame.size.width, dimView.frame.size.height)];
        [dimView addSubview:backgroundDismissButton];*/
        
        blurView = [[AMBlurView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andBlurType:UIBarStyleBlack];
        [self addSubview:blurView];
        
        alertView = [[UIView alloc] initWithFrame:CGRectMake(20, [[UIScreen mainScreen] bounds].size.height/2 - alertHeight/2,
                                                             alertWidth, alertHeight)];
        [[alertView layer] setCornerRadius:1.0];
        [alertView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:alertView];
        
        titleField = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.size.width, titleHeight)];
        [titleField setBackgroundColor:themeColor];
        [titleField setTextColor:oppositeColor];
        [titleField setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0]];
        [titleField setTextAlignment:NSTextAlignmentCenter];
        [titleField setText:self.title];
        [alertView addSubview:titleField];
        
        CALayer *titleSep = [[CALayer alloc] init];
        [titleSep setFrame:CGRectMake(0, titleField.frame.size.height-0.5, titleField.frame.size.width, 0.5)];
        [titleSep setBackgroundColor:[[UIColor lightGrayColor] CGColor]];
        [titleField.layer addSublayer:titleSep];
        
        messageField = [[UILabel alloc] initWithFrame:CGRectMake(10, titleField.frame.origin.y + titleField.frame.size.height + 10, messageWidth, messageHeight)];
        [messageField setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]];
        [messageField setNumberOfLines:0];
        [messageField setLineBreakMode:NSLineBreakByWordWrapping];
        [messageField setTextAlignment:NSTextAlignmentCenter];
        [messageField setText:self.message];
        [alertView addSubview:messageField];
        
        for (NSString *buttonText in self.buttons)
        {
            float y = 0;
            int buttonIndex = [self.buttons indexOfObject:buttonText];
            
            if (buttonIndex == 0)
            {
                y = messageField.frame.origin.y + messageField.frame.size.height + 10;
            }
            else
            {
                UIButton *previousButton = (UIButton*)[alertView viewWithTag:kButtonBase+buttonIndex-1];
                y = previousButton.frame.origin.y;
                y += previousButton.frame.size.height;
            }
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button addTarget:self action:@selector(alertViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [button setFrame:CGRectMake(0, y, alertView.frame.size.width, buttonHeight)];
            [button setTitle:buttonText forState:UIControlStateNormal];
            [button setTag:kButtonBase+buttonIndex];
            [button setTitleColor:themeColor forState:UIControlStateNormal];
            [alertView addSubview:button];
            
            CALayer *titleSep2 = [[CALayer alloc] init];
            [titleSep2 setFrame:CGRectMake(0, 0, button.frame.size.width, 0.5)];
            [titleSep2 setBackgroundColor:[[UIColor lightGrayColor] CGColor]];
            [button.layer addSublayer:titleSep2];
        }
    }
    
    return self;
}

- (void)alertViewButtonPressed:(UIButton*)button
{
    self.finished(self,[button tag] - kButtonBase);
}

- (void)backgroundDismissButtonPressed
{
    [self dismiss];
}

- (void)show
{
    UIView *superView = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [superView addSubview:self];
    
    CGRect origRect = alertView.frame;
    
    [dimView setAlpha:0.0];
    
    [alertView setFrame:CGRectMake(origRect.origin.x,  -dimView.frame.size.height - 100, origRect.size.width, origRect.size.height)];
    
    [UIView animateWithDuration:0.2 animations:^{
        [blurView setAlpha:1.0];
    }];
    
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:alertView snapToPoint:superView.center];
    [snapBehavior setDamping:0.3];
    
    [animator addBehavior:snapBehavior];
    
    self.snapBehavior = snapBehavior;
    self.animator = animator;
}

- (void)dismiss
{
    [self.animator removeAllBehaviors];
    self.animator = nil;
    self.snapBehavior = nil;
    UIView *superView = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [alertView setCenter:superView.center];
    [blurView setAlpha:1.0];
    
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:500 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [alertView setFrame:CGRectMake(alertView.frame.origin.x, self.frame.size.height + alertView.frame.size.height + 100, alertView.frame.size.width, alertView.frame.size.height)];
        [blurView setAlpha:0.0];
    }
    completion:^(BOOL done)
    {
         [self setHidden:YES];
         [self removeFromSuperview];
    }];
}

@end
