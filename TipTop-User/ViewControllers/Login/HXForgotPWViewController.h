//
//  HXForgotPWViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXSecurityCodeButton;

@interface HXForgotPWViewController : UITableViewController

@property (weak, nonatomic) IBOutlet          UITextField *staffIDTextField;
@property (weak, nonatomic) IBOutlet          UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet HXSecurityCodeButton *captchaButton;
@property (weak, nonatomic) IBOutlet          UITextField *captchaTextField;
@property (weak, nonatomic) IBOutlet          UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet          UITextField *confirmTextField;

- (IBAction)backButtonPressed;
- (IBAction)enterButtonPressed;

@end
