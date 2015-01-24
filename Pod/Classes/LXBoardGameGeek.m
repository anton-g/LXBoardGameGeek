//
//  LXBoardGameGeek.m
//  Pods
//
//  Created by Anton Gunnarsson on 2015-01-23.
//
//

#import "LXBoardGameGeek.h"
#import "LXSharedConstants.h"
#import <XMLDictionary.h>

@interface LXBoardGameGeek ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation LXBoardGameGeek

+ (LXBoardGameGeek *)sharedInstance {
    static LXBoardGameGeek *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[LXBoardGameGeek alloc] initPrivate];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[LXBoardGameGeek sharedInstance]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    }
    return self;
}

#pragma mark - Public methods
+ (void)gameWithID:(int)gameID options:(NSArray *)options completion:(boardGameCompletionBlock)completion {
    [[self sharedInstance] gameWithID:gameID options:options completion:completion];
}

+ (void)search:(NSString *)name options:(NSArray *)options completion:(boardGamesCompletionBlock)completion {
    [[self sharedInstance] search:name options:options completion:completion];
}

+ (void)gamesFromString:(NSString *)gameIDString options:(NSArray *)options completion:(boardGamesCompletionBlock)completion {
    [[self sharedInstance] gamesFromString:gameIDString options:options completion:completion];
}

+ (void)gamesFromArray:(NSArray *)gameIDs options:(NSArray *)options completion:(boardGamesCompletionBlock)completion {
    [[self sharedInstance] gamesFromArray:gameIDs options:options completion:completion];
}

#pragma mark - Private methods

- (void)gameWithID:(int)gameID options:(NSArray *)options completion:(boardGameCompletionBlock)completion {
    NSString *endPoint = [self endPointWithString:[NSString stringWithFormat:@"%d", gameID] type:EndPointThing options:options];
    [self fetchFrom:endPoint completion:^void (NSDictionary *gameData, NSError *error) {
        LXBoardGame *game;
        if (!error) {
            NSDictionary *gameInfo = gameData[@"item"];
            game = [self gameFromData:gameInfo];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(game, error);
        });
    }];
}

- (void)gamesFromString:(NSString *)gameIDString options:(NSArray *)options completion:(boardGamesCompletionBlock)completion {
    NSString *endPoint = [self endPointWithString:[NSString stringWithFormat:@"%@", gameIDString] type:EndPointThing options:options];
    [self fetchFrom:endPoint completion:^void (NSDictionary *gameData, NSError *error) {
        NSMutableArray *games = [NSMutableArray new];
        if (!error) {
            for (NSDictionary *singleGameData in gameData[kBoardGameItemKey]) {
                [games addObject:[self gameFromData:singleGameData]];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(games, error);
        });
    }];
}

- (void)gamesFromArray:(NSArray *)gameIDs options:(NSArray *)options completion:(boardGamesCompletionBlock)completion {
    NSString *gameIDString = [gameIDs componentsJoinedByString:@","];
    
    [self gamesFromString:gameIDString options:options completion:completion];
}

- (void)search:(NSString *)name options:(NSArray *)options completion:(boardGamesCompletionBlock)completion {
    NSString *endPoint = [self endPointWithString:name type:EndPointSearch options:options];
    [self fetchFrom:endPoint completion:^void (NSDictionary *data, NSError *error) {
        NSMutableArray *games = [NSMutableArray new];
        if (!error) {
            for (NSDictionary *gameData in data[kBoardGameItemKey]) {
                
                LXBoardGame *game = [self smallGameFromData:gameData];
                
                [games addObject:game];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(games, error);
        });
    }];
}

- (NSString *)endPointWithString:(NSString *)endpoint type:(EndPointType)type options:(NSArray *)options {
    NSString *realEndPoint;
    
    endpoint = [endpoint stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    switch (type) {
        case EndPointSearch:
            realEndPoint = [NSString stringWithFormat:@"%@%@%@", kBoardGameGeekAPIURL, kAPISearchKey, endpoint];
            if ([options containsObject:kBGGOptionTypeBoardGame] || [options containsObject:kBGGOptionTypeExpansion]) {
                realEndPoint = [realEndPoint stringByAppendingString:kAPITypeKey];
                
                if ([options containsObject:kBGGOptionTypeBoardGame]) {
                    realEndPoint = [realEndPoint stringByAppendingString:[NSString stringWithFormat:@"%@,", kBGGOptionTypeBoardGame]];
                }
                if ([options containsObject:kBGGOptionTypeExpansion]) {
                    realEndPoint = [realEndPoint stringByAppendingString:kBGGOptionTypeExpansion];
                }
            }
            
            if ([options containsObject:kBGGOptionSearchExact]) {
                realEndPoint = [realEndPoint stringByAppendingString:kAPIExactKey];
            }
            break;
        case EndPointThing:
            realEndPoint = [NSString stringWithFormat:@"%@%@%@%@", kBoardGameGeekAPIURL, kAPIThingKey, kAPIIdKey, endpoint];
            
            if ([options containsObject:kBGGOptionShowStats]) {
                realEndPoint = [realEndPoint stringByAppendingString:kAPIStatsKey];
            }
            break;
            
        default:
            break;
    }
    
    if ([options containsObject:kBGGOptionShowStats]) {
        realEndPoint = [realEndPoint stringByAppendingString:[NSString stringWithFormat:@"&%@", kAPIStatsKey]];
    }
    
    return realEndPoint;
}

- (void)fetchFrom:(NSString *)endPoint completion:(void (^)(NSDictionary *, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:endPoint];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (error != nil) {
                NSLog(@"Something went wrong: %@", [error localizedDescription]);
                completion(nil, error);
                return;
            }
            
            XMLDictionaryParser *parser = [[XMLDictionaryParser alloc] init];
            
            NSDictionary *xmlObject = [parser dictionaryWithData:data];
            
            completion(xmlObject, nil);
        }];
        [dataTask resume];
    });
}

/**
 *  Maps data from NSDictionaries to LXBoardGame object
 *
 *  @param data NSDictionary with boardgame data
 *
 *  @return LXBoardGame object
 */
- (LXBoardGame *)gameFromData:(NSDictionary *)data {
    LXBoardGame *game = [LXBoardGame new];

    game.gameID             = [data[kBoardGameIDKey] intValue];
    game.thumbURL           = [NSURL URLWithString:data[kBoardGameThumbnailKey]];
    game.imageURL           = [NSURL URLWithString:data[kBoardGameImageKey]];
    game.gameDescription    = data[kBoardGameDescriptionKey];
    game.yearPublished      = [data[kBoardGameYearKey][kBoardGameValueKey] intValue];
    game.maxPlayers         = [data[kBoardGameMaxPlayersKey][kBoardGameValueKey] intValue];
    game.minPlayers         = [data[kBoardGameMinPlayersKey][kBoardGameValueKey] intValue];
    game.playingTime        = [data[kBoardGamePlayTimeKey][kBoardGameValueKey] intValue];
    game.minAge             = [data[kBoardGameMinAgeKey][kBoardGameValueKey] intValue];
    
    //Separate primary and alternate names
    if ([[data objectForKey:kBoardGameNameKey] isKindOfClass:[NSArray class]]) {
        NSArray *gameNames = (NSArray *)[data objectForKey:kBoardGameNameKey];
        NSMutableArray *altNames = [NSMutableArray new];
        
        for (NSDictionary *name in gameNames) {
            if ([[name objectForKey:kBoardGameTypeKey] isEqualToString:kBoardGamePrimaryNameKey]) {
                game.name = [name objectForKey:kBoardGameValueKey];
            }
            else {
                [altNames addObject:[name objectForKey:kBoardGameValueKey]];
            }
            
            game.alternateNames = altNames;
        }
    } else {
        NSDictionary *firstName = [data objectForKey:kBoardGameNameKey];
        game.name = [firstName objectForKey:kBoardGameValueKey];
    }
    
    //Map links
    if ([[data objectForKey:kBoardGameLinkKey] isKindOfClass:[NSArray class]]) {
        game.links = (NSArray *)[data objectForKey:kBoardGameLinkKey];
    }
    
    //Map stats
    if ([data objectForKey:kBoardGameStatsKey]) {
        NSDictionary *statistics = [data objectForKey:kBoardGameStatsKey];
        NSDictionary *ratings = [statistics objectForKey:kBoardGameRatingsKey];
        
        LXBoardGameStats *stats = [LXBoardGameStats new];
        
        stats.usersRated            = [ratings[kBoardGameNumUsersRatedKey][kBoardGameValueKey] intValue];
        stats.averageRating         = [ratings[kBoardGameAverageRatingKey][kBoardGameValueKey] floatValue];
        stats.bayesAverageRating    = [ratings[kBoardGameBayesAverageKey][kBoardGameValueKey] floatValue];
        stats.ranks                 = ratings[kBoardGameRanksKey][kBoardGameValueKey];
        stats.stddev                = [ratings[kBoardGameStddevKey][kBoardGameValueKey] floatValue];
        stats.median                = [ratings[kBoardGameMedianKey][kBoardGameValueKey] floatValue];
        stats.owned                 = [ratings[kBoardGameOwnedKey][kBoardGameValueKey] intValue];
        stats.trading               = [ratings[kBoardGameTradingKey][kBoardGameValueKey] intValue];
        stats.wanting               = [ratings[kBoardGameWantingKey][kBoardGameValueKey] intValue];
        stats.wishing               = [ratings[kBoardGameWishingKey][kBoardGameValueKey] intValue];
        stats.numComments           = [ratings[kBoardGameNumCommentsKey][kBoardGameValueKey] intValue];
        stats.numWeights            = [ratings[kBoardGameNumWeightsKey][kBoardGameValueKey] intValue];
        stats.averageWeight         = [ratings[kBoardGameAverageWeightKey][kBoardGameValueKey] floatValue];
        
        game.statistics = stats;
    }
    
    return game;
}

/**
 *  Since search only returns a basic amount of info as default we want to only map the relevant properties as well
 *
 *  @param data Data to map the relevant properties to a LXBoardGame object
 *
 *  @return LXBoardGame object
 */
- (LXBoardGame *)smallGameFromData:(NSDictionary *)data {
    LXBoardGame *game = [LXBoardGame new];
    
    game.name = data[kBoardGameNameKey][kBoardGameValueKey];
    game.gameID             = [data[kBoardGameIDKey] intValue];
    game.yearPublished      = [data[kBoardGameYearKey][kBoardGameValueKey] intValue];
    
    return game;
}

@end
