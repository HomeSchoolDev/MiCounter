//
//  AMBlurView.m
//  blur
//
//  Created by Cesar Pinto Castillo on 7/1/13.
//  Copyright (c) 2013 Arctic Minds Inc. All rights reserved.
//

#import "AMBlurView.h"
#import <QuartzCore/QuartzCore.h>

@interface AMBlurView ()

@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, assign) UIBarStyle barStyle;

@end

@implementation AMBlurView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andBlurType:(UIBarStyle)bar {
    self = [super initWithFrame:frame];
    if (self) {
        //self.barStyle = bar;
        //[self setup];
        self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.toolbar setBarStyle:bar];
        [self addSubview:self.toolbar];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self.toolbar setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void)setup {
    // If we don't clip to bounds the toolbar draws a thin shadow on top
    /*[self setClipsToBounds:YES];
    
    if (![self toolbar]) {
        [self setToolbar:[[UIToolbar alloc] initWithFrame:[self bounds]]];
        //[[self toolbar] setBarStyle:UIBarStyleBlack];
        [[self toolbar] setBarStyle:self.barStyle];
        CALayer *layer = [self.toolbar layer];
        //[layer setOpacity:0.9];
        [self.layer insertSublayer:layer atIndex:0];
    }*/
}

- (void)setBlurTintColor:(UIColor *)blurTintColor {
    [self.toolbar setBarTintColor:blurTintColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.toolbar setFrame:[self bounds]];
}

@end
