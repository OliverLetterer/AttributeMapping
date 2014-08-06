//
//  _SPLAttributeMappingProxy.m
//  AttributeMapping
//
//  Created by Oliver Letterer on 06.08.14.
//  Copyright (c) 2014 Sparrow-Labs. All rights reserved.
//

#import "_SPLAttributeMappingProxy.h"

@implementation _SPLAttributeMappingProxy

- (instancetype)initWithTargetClass:(Class)targetClass
{
    if (self = [super init]) {
        NSString *newClassName = [NSString stringWithFormat:@"%@___%@", NSStringFromClass(self.class), targetClass];
        Class subclass = NSClassFromString(newClassName);

        if (!subclass) {
            subclass = objc_allocateClassPair([_SPLAttributeMappingProxy class], newClassName.UTF8String, 0);
            objc_registerClassPair(subclass);
        }

        object_setClass(self, subclass);
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if ([super resolveInstanceMethod:sel]) {
        return YES;
    }

    Class targetClass = NSClassFromString([NSStringFromClass(object_getClass(self)) componentsSeparatedByString:@"___"].lastObject);
    if (!targetClass) {
        return NO;
    }

    objc_property_t property = class_getProperty(targetClass, sel_getName(sel));

    if (!property) {
        return NO;
    }

    IMP implementation = imp_implementationWithBlock(^id(id self) {
        return NSStringFromSelector(sel);
    });
    return class_addMethod(self, sel, implementation, method_getTypeEncoding(class_getInstanceMethod(targetClass, sel)));
}

@end
