#import "HelpscoutBeacon.h"
#import "Beacon.h"
#import <React/RCTBridgeModule.h>

@implementation HelpscoutBeacon

RCT_EXPORT_MODULE();

+ (BOOL)requiresMainQueueSetup
{
    return NO;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

NSString * const beaconID = @"***REMOVED***";

RCT_EXPORT_METHOD(open:(NSString *)signatureKey)
{
    HSBeaconSettings *settings = [[HSBeaconSettings alloc] initWithBeaconId:beaconID];
    [HSBeacon openBeacon:settings signature:signatureKey];
}

RCT_EXPORT_METHOD(login:(NSString *)email nameParameter:(NSString *)name userIdParameter:(NSString *)userID)
{
    HSBeaconUser *user = [[HSBeaconUser alloc] init];
    user.email = email;
    user.name = name;
    [HSBeacon login:user];
    [user addAttributeWithKey:@"userId" value:userID];
}

RCT_EXPORT_METHOD(loginAndOpen:(NSString *)email nameParameter:(NSString *)name userIdParameter:(NSString *)userID signatureParameter:(NSString *)signature)
{
    [self login:email nameParameter:name userIdParameter:userID];
    [self open:signature];
}

RCT_EXPORT_METHOD(logout)
{
    [HSBeacon logout];
}

RCT_EXPORT_METHOD(openArticle:(NSString *)articleID signatureParameter:(NSString *)signature)
{
    HSBeaconSettings *settings = [[HSBeaconSettings alloc] initWithBeaconId:beaconID];
    [HSBeacon openArticle:articleID beaconSettings: settings signature:signature];
}

RCT_EXPORT_METHOD(suggestArticles:(NSArray *)articleIDList)
{
    [HSBeacon suggest:articleIDList];
}

RCT_EXPORT_METHOD(resetSuggestions)
{
    NSMutableArray *emptyArray = [NSMutableArray new];
    [HSBeacon suggest:emptyArray];
}

@end
