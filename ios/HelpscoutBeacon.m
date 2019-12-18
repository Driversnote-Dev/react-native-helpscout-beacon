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

NSString *helpscoutBeaconID;

RCT_EXPORT_METHOD(init:(NSString *)beaconID)
{
    if (beaconID == nil) {
        NSLog(@"[init] missing parameter: beaconID");
        return;
    }

    helpscoutBeaconID = beaconID;
}

RCT_EXPORT_METHOD(open:(NSString *)signatureKey)
{
    if (helpscoutBeaconID == nil || signatureKey == nil) {
        if (helpscoutBeaconID == nil) {
            NSLog(@"[open] Not initialized - did you forget to call 'init'?");
        }
        if (signatureKey == nil) {
            NSLog(@"[open] missing parameter: signatureKey");
        }
        return;
    }

    HSBeaconSettings *settings = [[HSBeaconSettings alloc] initWithBeaconId:helpscoutBeaconID];
    [HSBeacon openBeacon:settings signature:signatureKey];
}

RCT_EXPORT_METHOD(login:(NSString *)email nameParameter:(NSString *)name userIdParameter:(NSString *)userID)
{
    if (helpscoutBeaconID == nil || email == nil || name == nil || userID == nil) {
        if (helpscoutBeaconID == nil) {
            NSLog(@"[login] Not initialized - did you forget to call 'init'?");
        }
        if (email == nil) {
            NSLog(@"[login] missing parameter: email");
        }
        if (name == nil) {
            NSLog(@"[login] missing parameter: name");
        }
        if (userID == nil) {
            NSLog(@"[login] missing parameter: userID");
        }
        return;
    }

    HSBeaconUser *user = [[HSBeaconUser alloc] init];
    user.email = email;
    user.name = name;
    [HSBeacon login:user];
    [user addAttributeWithKey:@"userId" value:userID];
}

RCT_EXPORT_METHOD(loginAndOpen:(NSString *)email nameParameter:(NSString *)name userIdParameter:(NSString *)userID signatureParameter:(NSString *)signature)
{
    if (helpscoutBeaconID == nil || email == nil || name == nil || userID == nil) {
        if (helpscoutBeaconID == nil) {
            NSLog(@"[loginAndOpen] Not initialized - did you forget to call 'init'?");
        }
        if (email == nil) {
            NSLog(@"[loginAndOpen] missing parameter: email");
        }
        if (name == nil) {
            NSLog(@"[loginAndOpen] missing parameter: name");
        }
        if (userID == nil) {
            NSLog(@"[loginAndOpen] missing parameter: userID");
        }
        if (signature == nil) {
            NSLog(@"[loginAndOpen] missing parameter: signature");
        }
        return;
    }

    [self login:email nameParameter:name userIdParameter:userID];
    [self open:signature];
}

RCT_EXPORT_METHOD(logout)
{
    [HSBeacon logout];
}

RCT_EXPORT_METHOD(openArticle:(NSString *)articleID signatureParameter:(NSString *)signature)
{
    if (helpscoutBeaconID == nil || articleID == nil || signature == nil) {
        if (helpscoutBeaconID == nil) {
            NSLog(@"[openArticle] Not initialized - did you forget to call 'init'?");
        }
        if (articleID == nil) {
            NSLog(@"[openArticle] missing parameter: articleID");
        }
        if (signature == nil) {
            NSLog(@"[openArticle] missing parameter: signature");
        }
        return;
    }

    HSBeaconSettings *settings = [[HSBeaconSettings alloc] initWithBeaconId:helpscoutBeaconID];
    [HSBeacon openArticle:articleID beaconSettings: settings signature:signature];
}

RCT_EXPORT_METHOD(suggestArticles:(NSArray *)articleIDList)
{
    if (helpscoutBeaconID == nil || articleIDList == nil) {
        if (helpscoutBeaconID == nil) {
            NSLog(@"[suggestArticles] Not initialized - did you forget to call 'init'?");
        }
        if (articleIDList == nil) {
            NSLog(@"[suggestArticles] missing parameter: articleIDList");
        }
        return;
    }

    [HSBeacon suggest:articleIDList];
}

RCT_EXPORT_METHOD(resetSuggestions)
{
    NSMutableArray *emptyArray = [NSMutableArray new];
    [HSBeacon suggest:emptyArray];
}

@end
