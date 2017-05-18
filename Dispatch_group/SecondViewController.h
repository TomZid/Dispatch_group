//
//  SecondViewController.h
//  Dispatch_group
//
//  Created by tom.zhu on 18/05/2017.
//  Copyright © 2017 tom.zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
- (void)startWithSuccess:(void(^)(id response))SuccessBlock
                  failer:(void(^)(id response))failerBlock;
@end
