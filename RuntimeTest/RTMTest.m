//
//  RTMTest.m
//  RuntimeTest
//
//  Created by 李飞艳 on 2018/10/23.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "RTMTest.h"
#import <objc/runtime.h>
#import "ViewController.h"
@implementation RTMTest
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return YES;//返回YES，进入下一步转发
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;//返回nil，进入下一步转发
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(printString:)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([anInvocation selector] == @selector(printString:)) {
        ViewController *viewController = [[ViewController alloc] init];
        [anInvocation invokeWithTarget:viewController];
    }
}
@end
//-(id)forwardingTargetForSelector:(SEL)aSelector{
//    if (aSelector == @selector(printString:)) {
//        return [[ViewController alloc] init];
//    }
//    return  [super forwardingTargetForSelector:aSelector];
//}
//-(void)addMethodPrintString:(NSString *)string{
//    NSLog(@"%@",string);
//}
//+(BOOL)resolveInstanceMethod:(SEL)sel{
//    if (sel == @selector(printString:)) {
//        class_addMethod([self class], @selector(printString:), class_getMethodImplementation(self, @selector(addMethodPrintString:)), "v@:@");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
