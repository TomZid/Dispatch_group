//
//  SecondViewController.m
//  Dispatch_group
//
//  Created by tom.zhu on 18/05/2017.
//  Copyright © 2017 tom.zhu. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (nonatomic, copy) void (^firstRequest)(id response);
@property (nonatomic, copy) void (^SecondRequest)(id response);
@end

@implementation SecondViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startWithSuccess:^(id response) {
        
    } failer:^(id response) {
        
    }];
}

- (void)startWithSuccess:(void (^)(id))SuccessBlock failer:(void (^)(id))failerBlock {
    /*1、dispatch_group_async
     *2、dispatch_group_enter(group)、dispatch_group_leave(group)
     *3、dispatch_group_notify
     *4、dispatch_group_wait
     */
    
    ///*dispatch_group_enter must be balanced with dispatch_group_leave().
    dispatch_group_t group = dispatch_group_create();
    
    self.firstRequest = ^(id response) {
        NSLog(@"firstRequest enter");
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(2);
            NSLog(@"firstRequest 结束");
            dispatch_group_leave(group);
        });
    };
    self.SecondRequest = ^(id response) {
        NSLog(@"SecondRequest enter");
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(8);
            NSLog(@"SecondRequest 结束");
            dispatch_group_leave(group);
        });
    };
    
    self.firstRequest(nil);
    self.SecondRequest(nil);
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"dispatch_group_notify 结束");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
        NSLog(@"dispatch_group_wait 结束");
    });
    //*/
    
    /*
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.dispatchgroup.test", DISPATCH_QUEUE_CONCURRENT);

    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@"firstRequest 结束");
    });
    
    dispatch_group_async(group, queue, ^{
        sleep(8);
        NSLog(@"secondRequest 结束");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"dispatch_group_notify 执行");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
        NSLog(@"dispatch_group_wait 结束");
    });
     */
}

@end
