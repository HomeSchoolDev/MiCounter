//
//  MiCounterCountInfoViewController.h
//  MiCounter
//
//  Created by Derek Maurer on 2/8/14.
//
//

#import <UIKit/UIKit.h>

@interface MiCounterCountInfoViewController : UIViewController
@property (nonatomic, strong) NSString *countName;
@property (nonatomic, strong) NSString *count;

@property (nonatomic, strong) IBOutlet UILabel *countNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *countLabel;
@property (nonatomic, strong) IBOutlet UIButton *deleteButton;
@property (nonatomic, strong) IBOutlet UIButton *shareButton;

- (IBAction)shareButtonPressed:(id)sender;
- (IBAction)deleteButtonPressed:(id)sender;
@end
