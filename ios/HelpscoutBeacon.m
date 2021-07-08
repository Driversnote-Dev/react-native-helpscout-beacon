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
HSBeaconUser *beaconUser;

RCT_EXPORT_METHOD(init:(NSString *)beaconID)
{
    if (beaconID == nil) {
        NSLog(@"[init] missing parameter: beaconID");
        return;
    }

    helpscoutBeaconID = beaconID;
}

RCT_EXPORT_METHOD(identify:(NSString *)email nameParameter:(NSString *)name)
{
    if (helpscoutBeaconID == nil || email == nil) {
        if (helpscoutBeaconID == nil) {
            NSLog(@"[identify] Not initialized - did you forget to call 'init'?");
        }
        if (email == nil) {
            NSLog(@"[identify] missing parameter: email");
        }
        return;
    }

    HSBeaconUser *user = [[HSBeaconUser alloc] init];
    user.email = email;
    if (name != nil) {
        user.name = name;
    }

    // Store beaconUser locally
    beaconUser = user;
    [HSBeacon login:user];
}

RCT_EXPORT_METHOD(addAttributeWithKey:(NSString *)key valueParameter:(NSString *)value)
{
    if (helpscoutBeaconID == nil || beaconUser == nil || key == nil || value == nil) {
        if (helpscoutBeaconID == nil) {
            NSLog(@"[addAttributeWithKey] Not initialized - did you forget to call 'init'?");
        }
        if (beaconUser == nil) {
            NSLog(@"[addAttributeWithKey] Not initialized - did you forget to call 'identify' or 'login'?");
        }
        if (key == nil) {
            NSLog(@"[addAttributeWithKey] missing parameter: key");
        }
        if (value == nil) {
            NSLog(@"[addAttributeWithKey] missing parameter: value");
        }
        return;
    }

    [beaconUser addAttributeWithKey:key value:value];
}

RCT_EXPORT_METHOD(open:(NSString *)signatureKey)
{
    if (helpscoutBeaconID == nil || beaconUser == nil) {
        if (helpscoutBeaconID == nil) {
            NSLog(@"[open] Not initialized - did you forget to call 'init'?");
        }
        if (beaconUser == nil) {
            NSLog(@"[open] Not initialized - did you forget to call 'identify' or 'login'?");
        }
        return;
    }

    HSBeaconSettings *settings = [[HSBeaconSettings alloc] initWithBeaconId:helpscoutBeaconID];
    if (signatureKey == nil) {
        [HSBeacon openBeacon:settings];
    } else {
        [HSBeacon openBeacon:settings signature:signatureKey];
    }
}

RCT_EXPORT_METHOD(navigate:(NSString *)path)
{
    if (helpscoutBeaconID == nil || path == nil) {
        if (helpscoutBeaconID == nil) {
            NSLog(@"[navigate] Not initialized - did you forget to call 'init'?");
        }
        if (path == nil) {
            NSLog(@"[navigate] missing parameter: path");
        }
        return;
    }

    HSBeaconSettings *settings = [[HSBeaconSettings alloc] initWithBeaconId:helpscoutBeaconID];
    [HSBeacon navigate:path beaconSettings:settings];
}

RCT_EXPORT_METHOD(logout)
{
    if (helpscoutBeaconID == nil) {
        NSLog(@"[logout] Not initialized - did you forget to call 'init'?");
        return;
    }

    [HSBeacon logout];
}

RCT_EXPORT_METHOD(openArticle:(NSString *)articleID signatureParameter:(NSString *)signature)
{
    if (helpscoutBeaconID == nil || articleID == nil) {
        if (helpscoutBeaconID == nil) {
            NSLog(@"[openArticle] Not initialized - did you forget to call 'init'?");
        }
        if (articleID == nil) {
            NSLog(@"[openArticle] missing parameter: articleID");
        }
        return;
    }

    HSBeaconSettings *settings = [[HSBeaconSettings alloc] initWithBeaconId:helpscoutBeaconID];
    if (signature == nil) {
        [HSBeacon openArticle:articleID beaconSettings:settings];
    } else {
        [HSBeacon openArticle:articleID beaconSettings:settings signature:signature];
    }
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
    if (helpscoutBeaconID == nil) {
        NSLog(@"[resetSuggestions] Not initialized - did you forget to call 'init'?");
        return;
    }

    NSMutableArray *emptyArray = [NSMutableArray new];
    [HSBeacon suggest:emptyArray];
}

@end
