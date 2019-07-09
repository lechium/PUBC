//
//  NSObject+AssociatedObjects.m
//  
//  Created by Andy Matuschak on 8/27/09.
//  Public domain because I love you.
//

#import "NSObject+AssociatedObjects.h"
#import <objc/runtime.h>

@implementation NSObject (AMAssociatedObjects)

- (NSString *)documentsFolder {
    
    NSFileManager *man = [NSFileManager defaultManager];
    NSArray *paths =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:
                                                0] : NSTemporaryDirectory();
    if (![man fileExistsAtPath:basePath])
        [man createDirectoryAtPath:basePath withIntermediateDirectories:YES attributes:nil error:nil];
    return basePath;
}


- (void)associateValue:(id)value withKey:(void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)weaklyAssociateValue:(id)value withKey:(void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)associatedValueForKey:(void *)key
{
	return objc_getAssociatedObject(self, key);
}

@end

@implementation NSDate (Science)

+ (BOOL)passedEpochDateInterval:(NSTimeInterval)interval
{
    //return true; //force to test to see if it works
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSComparisonResult result = [date compare:[NSDate date]];
    if (result == NSOrderedAscending)
    {
        return true;
    }
    return false;
}

@end
