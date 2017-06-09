//
//  UIImage+Resize.m
//  tourongzhuanjia
//
//  Created by sweet luo on 15/10/20.
//  Copyright © 2015年 KristyFuWa. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage*)cutImageWithRadius:(CGFloat)inset
{
//    UIGraphicsBeginImageContext(self.size);
//    CGContextRef gc = UIGraphicsGetCurrentContext();
//    
//    float x1 = 0.;
//    float y1 = 0.;
//    float x2 = x1+self.size.width;
//    float y2 = y1;
//    float x3 = x2;
//    float y3 = y1+self.size.height;
//    float x4 = x1;
//    float y4 = y3;
//    radius = radius*2;
//    
//    CGContextMoveToPoint(gc, x1, y1+radius);
//    CGContextAddArcToPoint(gc, x1, y1, x1+radius, y1, radius);
//    CGContextAddArcToPoint(gc, x2, y2, x2, y2+radius, radius);
//    CGContextAddArcToPoint(gc, x3, y3, x3-radius, y3, radius);
//    CGContextAddArcToPoint(gc, x4, y4, x4, y4-radius, radius);
//    
//    
//    CGContextClosePath(gc);
//    CGContextClip(gc);
//    
//    CGContextTranslateCTM(gc, 0, self.size.height);
//    CGContextScaleCTM(gc, 1, -1);
//    CGContextDrawImage(gc, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
//    
//    
//    
//    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return newimage;
    
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, self.size.width - inset * 2.0f, self.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [self drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

@end
