//
//  LXBoardGame.h
//  Pods
//
//  Created by Anton Gunnarsson on 2015-01-23.
//
//

#import <Foundation/Foundation.h>
#import "LXBoardGameStats.h"

@interface LXBoardGame : NSObject

@property (nonatomic) int gameID;
@property (nonatomic, strong) NSURL *thumbURL;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *alternateNames;
@property (nonatomic, strong) NSString *gameDescription;
@property (nonatomic) int yearPublished;
@property (nonatomic) int maxPlayers;
@property (nonatomic) int minPlayers;
//Suggested numplayers
@property (nonatomic) int playingTime;
@property (nonatomic) int minAge;
//Suggested age
//Language dependence
@property (nonatomic, strong) NSArray *links; //Should contain dictionary with type, id, value

@property (nonatomic, strong) LXBoardGameStats *statistics;

@end
