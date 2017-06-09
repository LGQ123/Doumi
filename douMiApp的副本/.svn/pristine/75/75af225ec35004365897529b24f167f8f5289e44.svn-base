//
//  DMGlobalMethod.m
//  douMiApp
//
//  Created by edz on 2016/12/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DMGlobalMethod.h"

//@implementation DMGlobalMethod
//
//@end



BOOL isEmpty(NSString *string){
    
    if ([string isKindOfClass:[NSNumber class]]) {
        if ([[NSString stringWithFormat:@"%@",string] isEqualToString:@"0"]) {
            return YES;
        }else{
            return NO;
        }
    }
    
    if (string == nil || string == NULL || ![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


