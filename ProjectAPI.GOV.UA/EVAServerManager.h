//
//  EVAServerManager.h
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 28.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class EVADeclaration;

@interface EVAServerManager : NSObject
@property (strong, nonatomic) AFHTTPSessionManager *requestSessionManager;

+(EVAServerManager*) sharedManager;

-(void) getDeclarationsGroupWithSearchText:(NSString*) searchText onSuccess:(void(^)(NSArray* arrayOfDeclarations)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;
@end
