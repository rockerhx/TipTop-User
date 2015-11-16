//
//  HXLoginRequset.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXLoginRequset.h"

static NSString *LoginApi = @"/session/login";

@implementation HXUser (HXLoginRequset)

+ (AFHTTPRequestOperation *)loginWithParameters:(NSDictionary *)parameters
                                        success:(void(^)(HXApiResponse *response, HXUser *user))success
                                        failure:(void(^)(HXApiResponse *response))failure
{
    return [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:LoginApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HXApiResponse *response = [HXApiResponse responseWithStatusCode:operation.response.statusCode
                                                              errorCode:[responseObject[@"error_code"] integerValue]
                                                                message:responseObject[@"tip"]];
        HXUser *user = [HXUser mj_objectWithKeyValues:responseObject[@"data"]];
        if (success) {
            success(response, user);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HXApiResponse *response = [HXApiResponse responseWithStatusCode:operation.response.statusCode
                                                              errorCode:[operation.responseObject[@"error_code"] integerValue]
                                                                message:error.localizedFailureReason];
        if (failure) {
            failure(response);
        }
    }];
}

@end
