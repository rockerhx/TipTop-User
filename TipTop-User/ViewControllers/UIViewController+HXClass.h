//
//  UIViewController+HXClass.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXStoryBoardManager.h"
#import "HXUserSession.h"

@interface UIViewController (HXClass)

@property (nonatomic, copy, readonly)           NSString *navigationControllerIdentifier;
@property (nonatomic, assign, readonly) HXStoryBoardName  storyBoardName;

+ (UINavigationController *)navigationControllerInstance;
+ (instancetype)instance;

- (void)showAlertWithMessage:(NSString *)message;

@end
