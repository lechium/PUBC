//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSDictionary;

@interface AWSMTLManagedObjectAdapter : NSObject
{
    Class _modelClass;	// 8 = 0x8
    NSDictionary *_managedObjectKeysByPropertyKey;	// 16 = 0x10
    NSDictionary *_relationshipModelClassesByPropertyKey;	// 24 = 0x18
}

+ (id)managedObjectFromModel:(id)arg1 insertingIntoContext:(id)arg2 processedObjects:(struct __CFDictionary *)arg3 error:(id *)arg4;	// IMP=0x0000000100bae99c
+ (id)managedObjectFromModel:(id)arg1 insertingIntoContext:(id)arg2 error:(id *)arg3;	// IMP=0x0000000100bae858
+ (id)modelOfClass:(Class)arg1 fromManagedObject:(id)arg2 processedObjects:(struct __CFDictionary *)arg3 error:(id *)arg4;	// IMP=0x0000000100bac714
+ (id)modelOfClass:(Class)arg1 fromManagedObject:(id)arg2 error:(id *)arg3;	// IMP=0x0000000100bac344
@property(readonly, copy, nonatomic) NSDictionary *relationshipModelClassesByPropertyKey; // @synthesize relationshipModelClassesByPropertyKey=_relationshipModelClassesByPropertyKey;
@property(readonly, copy, nonatomic) NSDictionary *managedObjectKeysByPropertyKey; // @synthesize managedObjectKeysByPropertyKey=_managedObjectKeysByPropertyKey;
@property(readonly, nonatomic) Class modelClass; // @synthesize modelClass=_modelClass;
- (void).cxx_destruct;	// IMP=0x0000000100baf2b0
- (id)uniquingPredicateForModel:(id)arg1;	// IMP=0x0000000100baef80
- (void)mergeValuesOfModel:(id)arg1 forKeysFromManagedObject:(id)arg2;	// IMP=0x0000000100baed7c
- (void)mergeValueOfModel:(id)arg1 forKey:(id)arg2 fromManagedObject:(id)arg3;	// IMP=0x0000000100baed14
- (id)managedObjectKeyForKey:(id)arg1;	// IMP=0x0000000100baec2c
- (id)entityAttributeTransformerForKey:(id)arg1;	// IMP=0x0000000100baea88
- (id)managedObjectFromModel:(id)arg1 insertingIntoContext:(id)arg2 processedObjects:(struct __CFDictionary *)arg3 error:(id *)arg4;	// IMP=0x0000000100bac998
- (id)modelFromManagedObject:(id)arg1 processedObjects:(struct __CFDictionary *)arg2 error:(id *)arg3;	// IMP=0x0000000100baaf5c
- (id)initWithModelClass:(Class)arg1;	// IMP=0x0000000100baae28
- (id)init;	// IMP=0x0000000100baae10

@end

