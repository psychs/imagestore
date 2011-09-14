// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "RootViewController.h"
#import "AppDelegate.h"
#import "Status.h"
#import "StatusCell.h"


#define CELL_ID     @"StatusCell"


@implementation RootViewController

- (void)dealloc
{
    [conn release];
    [imageStore release];
    [super dealloc];
}

- (IBAction)refresh:(id)sender
{
    if (!conn) {
        conn = [TimelineController new];
        conn.delegate = self;
    }
    
    if (!imageStore) {
        imageStore = [ImageStore new];
        imageStore.delegate = self;
    }
    
    [conn update];
}

- (void)timelineControllerDidUpdate:(TimelineController*)sender
{
    [self.tableView reloadData];
}

- (void)imageStoreDidGetNewImage:(ImageStore*)sender url:(NSString*)url
{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (conn) {
        return conn.statuses.count;
    }
    else {
        return 0;
    }
}

- (Status*)statusAtIndexPath:(NSIndexPath*)path
{
    return [conn.statuses objectAtIndex:conn.statuses.count - path.row - 1];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)path
{
    Status* m = [self statusAtIndexPath:path];
    [m calculateGeometries];
    return m.cellHeight + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path
{
    StatusCell* c = (StatusCell*)[tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (!c) {
        c = [[[StatusCell alloc] initWithReuseIdentifier:CELL_ID] autorelease];
        c.imageStore = imageStore;
    }
    
    Status* m = [self statusAtIndexPath:path];
    c.status = m;
    [imageStore getImage:m.user.profileImageUrl];
    return c;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path
{
}

@end
