//
//  LXViewController.m
//  objective-bgg
//
//  Created by = on 01/23/2015.
//  Copyright (c) 2014 =. All rights reserved.
//

#import "LXViewController.h"
#import <LXBoardGameGeek.h>

@interface LXViewController ()

@property (nonatomic, strong) NSArray *games;

@end

@implementation LXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];    
	// Do any additional setup after loading the view, typically from a nib.
    /*NSArray *options = @[kBGGOptionTypeBoardGame];
    
    [LXBoardGameGeek search:@"Settlers of Catan" options:options completion:^(NSArray *games, NSError *error) {
        self.games = games;
        [self.tableView reloadData];
    }];*/
    
    [LXBoardGameGeek gamesFromString:@"15, 273" options:nil completion:^(NSArray *boardGames, NSError *error) {
        self.games = boardGames;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.games count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    LXBoardGame *game = self.games[indexPath.row];
    cell.textLabel.text = game.name;
    
    return cell;
}

@end
