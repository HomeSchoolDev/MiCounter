//
//  MiCounterSaveViewController.h
//  MiCounter
//
//  Created by Derek Maurer on 2/8/14.
//
//

#import <UIKit/UIKit.h>

@interface MiCounterSaveViewController : UIViewController
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) IBOutlet UITextField *textField;

- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;
@end
