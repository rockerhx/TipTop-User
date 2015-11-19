//
//  HXUserSession.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXUserSession.h"


static NSString *UserFilePath = @"/user.data";
static NSString *ProfileFilePath = @"/profile.data";

static HXUserSession *session = nil;

@implementation HXUserSession

#pragma mark - Class Methods
+ (nullable instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[HXUserSession alloc] init];
    });
    return session;
}

#pragma mark - Init Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self unArchiveUser];
        [self unArchiveProfile];
    }
    return self;
}

#pragma mark - Setter And Getter
- (HXUserSessionState)state {
    if (_user.uid && _user.accessToken) {
        NSDate *expired = [NSDate dateWithTimeIntervalSince1970:_user.tokenExpired];
        NSDate *now = [NSDate date];
        NSTimeInterval interval = [now timeIntervalSinceDate:expired];
        if (interval > 0) {
            return HXUserSessionStateLogout;
        } else {
            return HXUserSessionStateLogin;
        }
    } else {
        return HXUserSessionStateLogout;
    }
}

#pragma mark - Public Methods
- (void)updateUser:(nullable HXUser *)user {
    _user = user;
    [self archiveUser];
}

- (void)updateProfile:(nullable HXProfile *)profile {
    _profile = profile;
    [self archiveProfile];
}

- (void)updateUserAvatar:(nullable NSString *)avatarURL {
    _user.avatar = avatarURL;
    _profile.avatar = avatarURL;
    [self archiveUser];
    [self archiveProfile];
}

- (void)logout {
    [self updateUser:[HXUser new]];
    [self updateProfile:[HXProfile new]];
}

#pragma mark - Private Methods
- (void)archiveWithObject:(id)object filePath:(NSString *)filePath {
    NSString *file = [NSTemporaryDirectory() stringByAppendingPathComponent:filePath];
    [NSKeyedArchiver archiveRootObject:object toFile:file];
}

- (id)unArchiveWithFilePath:(NSString *)filePath {
    NSString *file = [NSTemporaryDirectory() stringByAppendingPathComponent:filePath];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:file];
}

- (void)archiveUser {
    [self archiveWithObject:_user filePath:UserFilePath];
}

- (void)unArchiveUser {
    _user = [self unArchiveWithFilePath:UserFilePath];
}

- (void)archiveProfile {
    [self archiveWithObject:_user filePath:ProfileFilePath];
}

- (void)unArchiveProfile {
    _profile = [self unArchiveWithFilePath:ProfileFilePath];
}

@end
