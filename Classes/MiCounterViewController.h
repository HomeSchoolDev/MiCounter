//
//  MiCounterViewController.h
//  MiCounter
//
//  Created by Derek on 6/22/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiCounterViewController : UIViewController {

}

@property (nonatomic, strong) IBOutlet UILabel *countLabel;
@property (nonatomic, strong) IBOutlet UIView *buttonSep;

- (IBAction)plusButtonPressed:(id)sender;
- (IBAction)minusButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)countsButtonPressed:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;

@end

