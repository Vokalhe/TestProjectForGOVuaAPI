//
//  EVAServerManager.m
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 28.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAServerManager.h"

#import "EVADeclaration.h"

static NSInteger errorDuringNetworkRequest = 999;


@implementation EVAServerManager
- (id)init
{
    self = [super init];
    if (self) {
        self.requestSessionManager = [AFHTTPSessionManager manager];
        self.requestSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return self;
}

+(EVAServerManager*) sharedManager {
    static EVAServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EVAServerManager alloc] init];
    });
    return manager;
}

#pragma mark - GET

-(void) getDeclarationsGroupWithSearchText:(NSString*) searchText onSuccess:(void(^)(NSArray* arrayOfDeclarations)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
  
    NSString *urlString = [NSString stringWithFormat:@"https://public-api.nazk.gov.ua/v1/declaration/?"];
    NSDictionary *parameters = @{ @"q": searchText };
    
    [self.requestSessionManager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *items = [responseObject objectForKey:@"items"];
        
        NSMutableArray *objectsArray = [NSMutableArray array];
    
        for(NSDictionary *dict in items){
            EVADeclaration *declaration = [[EVADeclaration alloc] initWithServerResponse:dict];
            [objectsArray addObject:declaration];
        }
        if (success) {
            success(objectsArray);
        }
        
        
    } failure:^(NSURLSessionDataTask *  task, NSError * _Nonnull error) {
        NSLog(@"error = %@", [error localizedDescription]);
        if (failure) {
            failure(error, errorDuringNetworkRequest);
        }
    }];
    
}


@end
