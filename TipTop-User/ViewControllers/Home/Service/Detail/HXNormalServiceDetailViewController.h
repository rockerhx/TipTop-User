//
//  HXNormalServiceDetailViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "HXCategory.h"

@interface HXNormalServiceDetailViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIButton *reserveButton;

@property (nonatomic, assign) HXCategoryListType  listType;
@property (nonatomic, copy)             NSString *aid;
@property (nonatomic, copy)             NSString *cid;
@property (nonatomic, assign)               BOOL  canReserve;

- (IBAction)backButtonPressed;
- (IBAction)reserveButtonPressed;

@end
