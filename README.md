# objective-bgg

[![CI Status](http://img.shields.io/travis/=/objective-bgg.svg?style=flat)](https://travis-ci.org/=/objective-bgg)
[![Version](https://img.shields.io/cocoapods/v/objective-bgg.svg?style=flat)](http://cocoadocs.org/docsets/objective-bgg)
[![License](https://img.shields.io/cocoapods/l/objective-bgg.svg?style=flat)](http://cocoadocs.org/docsets/objective-bgg)
[![Platform](https://img.shields.io/cocoapods/p/objective-bgg.svg?style=flat)](http://cocoadocs.org/docsets/objective-bgg)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

`LXBoardGameGeek` is created as a singleton (i.e. it doesn't need to be explicitly allocated and instantiated; you directly call `[[LXBoardGameGeek sharedInstance] method]`).

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
+ (void)search:(NSString *)name options:(NSArray *)options completion:(boardGamesCompletionBlock)completion;
+ (void)gameWithID:(int)gameID options:(NSArray *)options completion:(boardGameCompletionBlock)completion;
```

###Options
Every call takes an NSArray with kBGGOptions. These are available right now:
#####Search:
 - kBGGOptionTypeBoardGame (Return boardgames only)
 - kBGGOptionTypeExpansion (Return boardgameexpansions only)
 - kBGGOptionSearchExact (Match name exactly)

#####gameWithID:
 - kBGGOptionShowStats (Also fetch statistics)

###LXBoardGame
LXBoardGame is the primary model returned by most methods. See LXBoardGame.h for all available properties.

## Requirements
LXBoardGameGeek is using [XMLDictionary](https://github.com/nicklockwood/XMLDictionary) by [Nick Lockwood](https://github.com/nicklockwood) but it is included as a CocoaPod.

## Installation

objective-bgg is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

pod "objective-bgg"

## License

objective-bgg is available under the MIT license. See the LICENSE file for more info.