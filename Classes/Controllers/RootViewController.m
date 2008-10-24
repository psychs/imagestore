// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "RootViewController.h"
#import "AppDelegate.h"
#import "Message.h"
#import "MessageCell.h"

#define CELL_ID	@"TweetCell"

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
		return conn.messages.count;
	}
	else {
		return 0;
	}
}

- (Message*)messageAtIndexPath:(NSIndexPath*)path
{
	return [conn.messages objectAtIndex:conn.messages.count - path.row - 1];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)path
{
	Message* m = [self messageAtIndexPath:path];
	[m calculateGeometries];
	return m.cellHeight + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path
{
    MessageCell* cell = (MessageCell*)[tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (!cell) {
        cell = [[[MessageCell alloc] initWithFrame:CGRectZero reuseIdentifier:CELL_ID] autorelease];
		cell.imageStore = imageStore;
    }
	
	Message* m = [self messageAtIndexPath:path];
	cell.message = m;
	[imageStore getImage:m.user.profileImageUrl];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path
{
}

@end
