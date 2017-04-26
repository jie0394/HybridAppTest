//
//  SZKoclaJScontextModel.m
//  JS_OC_JavaScriptCore
//
//  Created by 李然豪 on 17/4/7.
//  Copyright © 2017年 李然豪. All rights reserved.
//

#import "SZKoclaJScontextModel.h"

@implementation SZKoclaJScontextModel
//-(void)scanClick{
//    if ([self.delegate respondsToSelector:@selector(scanClick)]) {
//        [self.delegate scanClick];
//    }
//}
//
//-(void)payClick{
//    if ([self.delegate respondsToSelector:@selector(payClick)]) {
//        [self.delegate payClick];
//    }
//}
-(void)share{
    if ([self.delegate respondsToSelector:@selector(share)]) {
        [self.delegate share];
    }
}

-(void)callBack{
    if ([self.delegate respondsToSelector:@selector(callBackTest)]) {
        [self.delegate callBackTest];
    }
}
@end
