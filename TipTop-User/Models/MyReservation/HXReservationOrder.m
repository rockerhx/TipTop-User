//
//  HXReservationOrder.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/21.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXReservationOrder.h"

@implementation HXReservationOrder

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
        @"agentID": @"agent_id",
      @"displayID": @"display_id",
        @"subCate": @"sub_cate",
      @"agentName": @"agent_name",
    @"agentAvatar": @"agent_avatar",
    @"agentMobile": @"agent_mobile",
     @"isComplete": @"is_complete",
   @"completeTime": @"complete_time",
     @"createDate": @"create_time"};
}

@end