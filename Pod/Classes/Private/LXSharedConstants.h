//
//  LXSharedConstants.h
//  Pods
//
//  Created by Anton Gunnarsson on 2015-01-23.
//
//

#import <Foundation/Foundation.h>

#pragma mark - General keys

static NSString * const kBoardGameGeekAPIURL        = @"http://www.boardgamegeek.com/xmlapi2/";
static NSString * const kBoardGameValueKey          = @"_value";
static NSString * const kBoardGameIDKey             = @"_id";
static NSString * const kAPIThingKey                = @"thing?";
static NSString * const kAPIIdKey                   = @"id=";
static NSString * const kAPISearchKey               = @"search?query=";
static NSString * const kAPIStatsKey                = @"&stats=1";
static NSString * const kAPITypeKey                 = @"&type=";
static NSString * const kAPIExactKey                 = @"&exact=1";
//Possible to merge a few of these

#pragma mark - BoardGame Keys

/* General */
//Missing all polls
static NSString * const kBoardGameItemKey           = @"item";
static NSString * const kBoardGameThumbnailKey      = @"thumbnail";
static NSString * const kBoardGameImageKey          = @"image";
static NSString * const kBoardGameNameKey           = @"name";
static NSString * const kBoardGamePrimaryNameKey    = @"primary";
static NSString * const kBoardGameAlternateNameKey  = @"alternate";
static NSString * const kBoardGameDescriptionKey    = @"description";
static NSString * const kBoardGameYearKey           = @"yearpublished";
static NSString * const kBoardGameMaxPlayersKey     = @"maxplayers";
static NSString * const kBoardGameMinPlayersKey     = @"minplayers";
static NSString * const kBoardGamePlayTimeKey       = @"playingtime";
static NSString * const kBoardGameMinAgeKey         = @"minage";
static NSString * const kBoardGameLinkKey           = @"link";
static NSString * const kBoardGameTypeKey           = @"_type";
//Missing link types

/* Stats */
static NSString * const kBoardGameStatsKey          = @"statistics";
static NSString * const kBoardGameRatingsKey        = @"ratings";
static NSString * const kBoardGameNumUsersRatedKey  = @"usersrated";
static NSString * const kBoardGameAverageRatingKey  = @"average";
static NSString * const kBoardGameBayesAverageKey   = @"bayesaverage";
static NSString * const kBoardGameRanksKey          = @"ranks";
static NSString * const kBoardGameRankKey           = @"rank";
//Missing rank types
static NSString * const kBoardGameStddevKey         = @"stddev";
static NSString * const kBoardGameMedianKey         = @"median";
static NSString * const kBoardGameOwnedKey          = @"owned";
static NSString * const kBoardGameTradingKey        = @"trading";
static NSString * const kBoardGameWantingKey        = @"wanting";
static NSString * const kBoardGameWishingKey        = @"wishing";
static NSString * const kBoardGameNumCommentsKey    = @"numcomments";
static NSString * const kBoardGameNumWeightsKey     = @"numweights";
static NSString * const kBoardGameAverageWeightKey  = @"averageweight";

//No support for versions atm

/* Videos */
static NSString * const kBoardGameVideosKey = @"videos";
static NSString * const kBoardGameVideoKey = @"video";
//Missing all video types

/* Marketplace */
//No marketplace support

#pragma mark - BoardGameExpansion Keys


#pragma mark - Other
typedef NS_ENUM(int, EndPointType) {
    EndPointSearch,
    EndPointThing
};

@interface LXSharedConstants : NSObject

@end
