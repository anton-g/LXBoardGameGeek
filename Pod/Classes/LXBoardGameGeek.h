//
//  LXBoardGameGeek.h
//  Pods
//
//  Created by Anton Gunnarsson on 2015-01-23.
//
//

#import <Foundation/Foundation.h>
#import "LXBoardGame.h"

static NSString * const kBGGOptionShowStats = @"stats";
static NSString * const kBGGOptionTypeBoardGame = @"boardgame";
static NSString * const kBGGOptionTypeExpansion = @"boardgameexpansion";
static NSString * const kBGGOptionSearchExact = @"exact";

typedef void (^boardGamesCompletionBlock)(NSArray *boardGames, NSError *error);
typedef void (^boardGameCompletionBlock)(LXBoardGame *boardGame, NSError *error);

@interface LXBoardGameGeek : NSObject

+ (LXBoardGameGeek *)sharedInstance;

+ (void)search:(NSString *)name options:(NSArray *)options completion:(boardGamesCompletionBlock)completion;

/**
 *  Tries to find a LXBoardGame with ID matching gameID
 *
 *  @description fasdf
 *
 *  @param gameID     ID of the game
 *  @param options    NSDictionary with following options:
 * KEY: kBoardGameOptionStats VALUE: YES/NO
 * Show statistics about game
 *
 *  @param completion Completion block with arguments: (LXBoardGame *boardGame, NSError *error)
 */
+ (void)gameWithID:(int)gameID options:(NSArray *)options completion:(boardGameCompletionBlock)completion;
//- (LXBoardGameExpansion *)expansionWithID:(NSInteger *)expansionID;
+ (void)gamesFromArray:(NSArray *)gameIDs options:(NSArray *)options completion:(boardGamesCompletionBlock)completion;
+ (void)gamesFromString:(NSString *)gameIDs options:(NSArray *)options completion:(boardGamesCompletionBlock)completion;

@end