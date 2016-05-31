//
//  Client.m
//  HagglePit
//
//  Created by Nikhil Sharma on 15/5/15.
//  Copyright (c) 2015 Jay Ang. All rights reserved.
//

#import "Client.h"

static NSString *const kAPIBaseUrl = @"http://tgb-dchua.pagekite.me/";
static NSString *const kAPIVersionHeader = @"X-Api-Version";
static NSString *const kAuthTokenHeader = @"X-Auth-Token";

NSString *const ClientDidUpdateUserAccountNotification = @"ClientDidUpdateUserAccountNotification";


@implementation Client

+ (instancetype)sharedInstance {
	static dispatch_once_t pred = 0;
	__strong static id _sharedObject = nil;
	dispatch_once(&pred, ^{
		_sharedObject = [[self alloc] init];
	});
	return _sharedObject;
}

- (instancetype)init {
	self = [super initWithBaseURL:[NSURL URLWithString:kAPIBaseUrl]];
	if (self) {
		self.requestSerializer = [AFJSONRequestSerializer serializer];
		self.responseSerializer = [AFJSONResponseSerializer serializer];
		
		NSString *authToken = self.authToken;
		if (authToken.length > 0) {
			[self.requestSerializer setValue:authToken forHTTPHeaderField:kAuthTokenHeader];
		}
	}
	return self;
}@end