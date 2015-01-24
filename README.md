# LXBoardGameGeek

[![CI Status](http://img.shields.io/travis/=/LXBoardGameGeek.svg?style=flat)](https://travis-ci.org/=/LXBoardGameGeek)
[![Version](https://img.shields.io/cocoapods/v/LXBoardGameGeek.svg?style=flat)](http://cocoadocs.org/docsets/LXBoardGameGeek)
[![License](https://img.shields.io/cocoapods/l/LXBoardGameGeek.svg?style=flat)](http://cocoadocs.org/docsets/LXBoardGameGeek)
[![Platform](https://img.shields.io/cocoapods/p/LXBoardGameGeek.svg?style=flat)](http://cocoadocs.org/docsets/LXBoardGameGeek)

## Installation

LXBoardGameGeek is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

pod "LXBoardGameGeek"


## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

`LXBoardGameGeek` is created as a singleton (i.e. it doesn't need to be explicitly allocated and instantiated; you directly call `[LXBoardGameGeek method]`).

Quick example that returns all boardgames that matches "Settlers of catan":
```objc
NSArray *options = @[kBGGOptionTypeBoardGame];

[LXBoardGameGeek search:@"Settlers of Catan" options:options completion:^(NSArray *games, NSError *error) {
    if (!error) {
        //Do something with games
    }
}];
```

###Available endpoints:
```objc
+ (void)gameWithID:(int)gameID options:(NSArray *)options completion:(boardGameCompletionBlock)completion;
+ (void)search:(NSString *)name options:(NSArray *)options completion:(boardGamesCompletionBlock)completion;
+ (void)gamesFromArray:(NSArray *)gameIDs options:(NSArray *)options completion:(boardGamesCompletionBlock)completion;
+ (void)gamesFromString:(NSString *)gameIDs options:(NSArray *)options completion:(boardGamesCompletionBlock)completion;
```

#####Options
Every call takes an NSArray with kBGGOptions. These are available right now:
######Search:
 - `kBGGOptionTypeBoardGame` (Return boardgames only)
 - `kBGGOptionTypeExpansion` (Return boardgameexpansions only)
 - `kBGGOptionSearchExact` (Match name exactly)

######gameWithID:
 - kBGGOptionShowStats (Also fetch statistics)

#####LXBoardGame
LXBoardGame is the primary model returned by most methods. See LXBoardGame.h for all available properties.

## Requirements
LXBoardGameGeek is using [XMLDictionary](https://github.com/nicklockwood/XMLDictionary) by [Nick Lockwood](https://github.com/nicklockwood) which is included as a CocoaPod.

##Disclaimer
I am in no way a obj-c guru or even that experienced with GitHub but i'd love to hear from you if i've done something stupid. Send a PR or shoot me an [email](anton@lyxit.se).

## License

LXBoardGameGeek is available under the MIT license. See the LICENSE file for more info.