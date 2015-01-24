//
//  LXBoardGameStats.h
//  Pods
//
//  Created by Anton Gunnarsson on 2015-01-23.
//
//

#import <Foundation/Foundation.h>

@interface LXBoardGameStats : NSObject

@property (nonatomic) int usersRated;
@property (nonatomic) float averageRating;
@property (nonatomic) float bayesAverageRating;
@property (nonatomic, strong) NSArray *ranks; //Dictionaries with type, id, name, friendlyname, value, bayesaverage
@property (nonatomic) float stddev;
@property (nonatomic) float median;
@property (nonatomic) int owned;
@property (nonatomic) int trading;
@property (nonatomic) int wanting;
@property (nonatomic) int wishing;
@property (nonatomic) int numComments;
@property (nonatomic) int numWeights;
@property (nonatomic) float averageWeight;

@end
