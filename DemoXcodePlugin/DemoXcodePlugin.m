//
//  DemoXcodePlugin.m
//  DemoXcodePlugin
//
//  Created by Michael Ash on 8/11/15.
//  Copyright © 2015 mikeash. All rights reserved.
//

#import "DemoXcodePlugin.h"

#import <AppKit/AppKit.h>
#import <objc/runtime.h>


@implementation DemoXcodePlugin

+ (void)load {
    NSLog(@"DemoXcodePlugin loaded");
    
    Class nstv = [NSTextView class];
    SEL drawRect = @selector(drawRect:);
    Method m = class_getInstanceMethod(nstv, drawRect);
    IMP oldImplementation = method_getImplementation(m);
    IMP newImplementation = imp_implementationWithBlock(^(NSTextView *self, NSRect rect) {
        [[self layoutManager] setUsesScreenFonts: YES];
        ((void (*)(id, SEL, NSRect))oldImplementation)(self, drawRect, rect);
    });
    method_setImplementation(m, newImplementation);
}

@end
