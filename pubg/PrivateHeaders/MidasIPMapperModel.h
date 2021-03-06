//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "NSCopying.h"

@class NSArray, NSDate, NSString;

@interface MidasIPMapperModel : NSObject <NSCopying>
{
    _Bool _isIPsSorted;	// 8 = 0x8
    NSDate *_lastUpdatedDate;	// 16 = 0x10
    NSString *_domain;	// 24 = 0x18
    NSString *_riskControlDomain;	// 32 = 0x20
    NSArray *_ips;	// 40 = 0x28
    NSString *_locale;	// 48 = 0x30
    long long _enviroment;	// 56 = 0x38
    double _domainDelay;	// 64 = 0x40
}

+ (void)initialize;	// IMP=0x00000001005817d0
@property(nonatomic) double domainDelay; // @synthesize domainDelay=_domainDelay;
@property(nonatomic) _Bool isIPsSorted; // @synthesize isIPsSorted=_isIPsSorted;
@property(readonly, nonatomic) long long enviroment; // @synthesize enviroment=_enviroment;
@property(readonly, copy, nonatomic) NSString *locale; // @synthesize locale=_locale;
@property(retain, nonatomic) NSArray *ips; // @synthesize ips=_ips;
@property(copy, nonatomic) NSString *riskControlDomain; // @synthesize riskControlDomain=_riskControlDomain;
@property(copy, nonatomic) NSString *domain; // @synthesize domain=_domain;
@property(retain, nonatomic) NSDate *lastUpdatedDate; // @synthesize lastUpdatedDate=_lastUpdatedDate;
- (void).cxx_destruct;	// IMP=0x0000000100584660
- (id)initWithCoder:(id)arg1;	// IMP=0x000000010058439c
- (void)encodeWithCoder:(id)arg1;	// IMP=0x00000001005841a4
- (id)copyWithZone:(struct _NSZone *)arg1;	// IMP=0x0000000100584000
- (id)_transformEnvironmentEnumIntoEnvironmentString:(long long)arg1;	// IMP=0x0000000100583f74
- (long long)_transformEnvironmentStringIntoEnvironmentEnum:(id)arg1;	// IMP=0x0000000100583d94
- (void)_initFromStaticMappingRelationship;	// IMP=0x0000000100583ba0
- (void)_parseStaticMappingRelationship:(id)arg1;	// IMP=0x0000000100583880
- (id)_loadPlistPathFromBundle;	// IMP=0x0000000100583794
- (id)_getPlistDict;	// IMP=0x0000000100583734
- (_Bool)_bundleContainslist;	// IMP=0x000000010058369c
- (_Bool)_isMapperModelExpired;	// IMP=0x0000000100583628
- (id)description;	// IMP=0x0000000100583328
- (_Bool)isDomainNonUsable;	// IMP=0x00000001005832e0
- (_Bool)shouldMapperModelUpdate;	// IMP=0x000000010058319c
- (long long)indexForIPAddress:(id)arg1;	// IMP=0x0000000100583024
- (id)getAllIPAddresses;	// IMP=0x0000000100582e68
- (id)sortedIPsBySpeed;	// IMP=0x0000000100582a6c
- (id)initWithLocale:(id)arg1 environment:(id)arg2;	// IMP=0x0000000100582944
- (id)initWithPlistDict:(id)arg1 locale:(id)arg2 environment:(id)arg3;	// IMP=0x0000000100582454
- (id)initWithDomain:(id)arg1 riskControlDomain:(id)arg2 lastUpdatedDate:(id)arg3 ipAddresses:(id)arg4 locale:(id)arg5 environment:(id)arg6 isIPsSorted:(_Bool)arg7 domainDelay:(double)arg8;	// IMP=0x000000010058226c

@end

