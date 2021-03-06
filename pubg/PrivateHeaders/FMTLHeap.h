//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "FApplePlatformObject.h"

#import "MTLHeap.h"

@class NSMutableArray, NSMutableSet, NSString;

@interface FMTLHeap : FApplePlatformObject <MTLHeap>
{
    unsigned long long PurgableState;	// 16 = 0x10
    struct FPThreadsCriticalSection *PoolMutex;	// 24 = 0x18
    NSMutableSet *Resources;	// 32 = 0x20
    NSMutableArray *BufferBuckets[46];	// 40 = 0x28
    struct TMap<FMetalTextureDesc, NSMutableSet<id<MTLTexture>>*, FDefaultSetAllocator, TDefaultMapHashableKeyFuncs<FMetalTextureDesc, NSMutableSet<id<MTLTexture>>*, false>> TextureCache;	// 408 = 0x198
    NSString *label;	// 488 = 0x1e8
    id <MTLDevice> device;	// 496 = 0x1f0
    unsigned long long storageMode;	// 504 = 0x1f8
    unsigned long long cpuCacheMode;	// 512 = 0x200
    unsigned long long size;	// 520 = 0x208
    unsigned long long usedSize;	// 528 = 0x210
    unsigned long long poolSize;	// 536 = 0x218
}

+ (id)alloc;	// IMP=0x00000001021e4d04
+ (id)allocWithZone:(struct _NSZone *)arg1;	// IMP=0x00000001021e4ce8
+ (CDStruct_eb6fb79d *)classAllocator;	// IMP=0x00000001021e4cdc
@property(readonly) unsigned long long poolSize; // @synthesize poolSize;
@property(readonly) unsigned long long usedSize; // @synthesize usedSize;
@property(readonly) unsigned long long size; // @synthesize size;
@property(readonly) unsigned long long cpuCacheMode; // @synthesize cpuCacheMode;
@property(readonly) unsigned long long storageMode; // @synthesize storageMode;
@property(readonly) id <MTLDevice> device; // @synthesize device;
@property(copy) NSString *label; // @synthesize label;
- (id).cxx_construct;	// IMP=0x00000001021e65b4
- (void).cxx_destruct;	// IMP=0x00000001021e65a4
- (void)drain:(_Bool)arg1;	// IMP=0x00000001021e611c
- (void)aliasTexture:(id)arg1;	// IMP=0x00000001021e5dc0
- (void)aliasBuffer:(id)arg1;	// IMP=0x00000001021e5c80
- (unsigned long long)setPurgeableState:(unsigned long long)arg1;	// IMP=0x00000001021e5b08
- (id)newTextureWithDescriptor:(id)arg1;	// IMP=0x00000001021e5424
- (id)newBufferWithLength:(unsigned long long)arg1 options:(unsigned long long)arg2;	// IMP=0x00000001021e50b8
- (unsigned long long)maxAvailableSizeWithAlignment:(unsigned long long)arg1;	// IMP=0x00000001021e5048
- (void)dealloc;	// IMP=0x00000001021e4ec4
- (id)initWithDescriptor:(struct FMTLHeapDescriptor *)arg1;	// IMP=0x00000001021e4d20

// Remaining properties
@property(readonly) unsigned long long currentAllocatedSize;
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

