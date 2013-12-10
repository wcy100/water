//
//  TableView.m
//  LiveByTouch
//
//  Created by hao.li on 11-7-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableView.h"
#import "EGORefreshTableHeaderView.h"

@implementation TableView
@synthesize refreshDelegate,tableArray,mutableArray,currentPage,added,pg;
@synthesize refreshFootView = _refreshFootView;
@synthesize refreshHeaderView = _refreshHeaderView;
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        pg = [[Paging alloc]init];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
		//self.userInteractionEnabled = YES;

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {

	}
	return self;
}

-(void) addRefreshView{
	added = YES;
	currentPage = 1;
	// Initialization code.
	if (_refreshHeaderView == nil) {
		_refreshHeaderView =  [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.frame.size.height, self.frame.size.width, self.frame.size.height)];
		//NSLog(@"%@", NSStringFromCGRect( _refreshHeaderView.frame ));
		_refreshHeaderView.delegate = self;
		[self addSubview:_refreshHeaderView];
	}
	
	//  update the last update date
    //[_refreshHeaderView refreshLastUpdatedDate:lastRefreshTime];
	
	//显示刷新条 并且即将要执行刷新的动作
	//[_refreshHeaderView egoRefreshScrollViewDidEndDragging:self isFirstTime:YES];
}

-(void) addMoreView{
    	currentPage = 1;
	if (_refreshFootView == nil) {
		_refreshFootView = [[EGORefreshTableFootView alloc] initWithFrame: CGRectMake(0.0f, self.contentSize.height, 320, 650)];
		//[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		//NSLog(@"%@", NSStringFromCGRect( v.frame ));
		_refreshFootView.delegate = self;
		[self addSubview:_refreshFootView];
		_refreshFootView.hidden = YES;
	}
	
	//  update the last update date
	//[_refreshFootView refreshLastUpdatedDate];
}
-(void) modifyMoreFrame{
	_refreshFootView.frame = CGRectMake(0.0f, self.contentSize.height, 320, 650);
}

-(void) addConfirmView:(TableViewConfirm)TableViewConfirm{
//	[ivConfirm removeFromSuperview];
//	[ivConfirm release];
//	ivConfirm = nil;
//	ivConfirm = [[ImageView alloc] initWithPath:@"pull_notice.png" ImageType:ImageDefault];
//	[ivConfirm setPosition:CGPointMake(0, 0)];
//	[self addSubview:ivConfirm];
	//self.separatorStyle = UITableViewCellSeparatorStyleNone;
	//self.backgroundColor = [UIColor whiteColor];
}

-(void) delConfirmView{
//	[ivConfirm removeFromSuperview];
	//self.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
	//self.backgroundColor = [UIColor whiteColor];
	//self.backgroundColor = BARBACKGROUND;
	self.separatorColor = BORDERCOLOR;
}


-(void) setLastRefreshTime:(PageLastRefreshTime)pagetype{
	lastRefreshTime = pagetype;
}


#pragma mark Table view methods

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 10;
//}
//


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

	[self modifyMoreFrame];
}

// Override to support row selection in the table view.
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	if (indexPath.row == [tableArray count]) {
//        
//		UITableViewCell *loadMoreCell = [tableView cellForRowAtIndexPath:indexPath];
//		[loadMoreCell setDisplayText:@"loading more ..."];
//        [loadMoreCell setAnimating:YES];
//        [self performSelectorInBackground:@selector(loadMore) withObject:nil];
//        //[loadMoreCell setHighlighted:NO];
//        [self deselectRowAtIndexPath:indexPath animated:YES];
//        return;
//    }	
//}




//-(void)loadMore
//{
//    NSMutableArray *more; 
//	//加载你的数据
//    [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:more waitUntilDone:NO];
//}
//
//-(void) appendTableWith:(NSMutableArray *)data
//{
//	
//    for (int i=0;i<[data count];i++) {
//        [tableArray addObject:[data objectAtIndex:i]];
//    }
//    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
//    for (int ind = 0; ind < [data count]; ind++) {
//        NSIndexPath    *newPath =  [NSIndexPath indexPathForRow:[tableArray indexOfObject:[data objectAtIndex:ind]] inSection:0];
//        [insertIndexPaths addObject:newPath];
//    }
//    [self insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
//	
//}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	currentPage = 1;
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	//刷新数据去吧
	if (refreshDelegate!=nil) {
		[refreshDelegate reloadRefreshDataSource:currentPage];
	}
	
	_reloading = YES;
}

- (void)doneLoadingTableViewData{
	_refreshFootView.frame = CGRectMake(0.0f, self.contentSize.height, 320, 650);
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}


#pragma mark -

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
	point =scrollView.contentOffset;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	CGPoint pt =scrollView.contentOffset;
	if (point.y < pt.y) {//向上提加载更多
		if (_refreshFootView.hidden) {
			return;
		}
		[_refreshFootView egoRefreshScrollViewDidScroll:self];
	}
	else {
		[_refreshHeaderView egoRefreshScrollViewDidScroll:self];
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView{
	CGPoint pt =scrollView.contentOffset;
	if (point.y < pt.y) {//向上提加载更多
		if (_refreshFootView.hidden) {
			return;
		}
		[_refreshFootView egoRefreshScrollViewDidEndDragging:self];
	}
	else {//向下拉加载更多
		[_refreshHeaderView egoRefreshScrollViewDidEndDragging:self isFirstTime:NO];
	}
}
//显示状态条
- (void)showStateBar{
	//显示刷新条 并且即将要执行刷新的动作
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:self isFirstTime:YES];
}


#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5f];	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/



#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableFootDidTriggerRefresh:(EGORefreshTableFootView*)view{
	
	[self reloadTableViewDataSource1];
	//[self performSelector:@selector(doneLoadingTableViewData1) withObject:nil afterDelay:3.0f];
	
}

- (BOOL)egoRefreshTableFootDataSourceIsLoading:(EGORefreshTableFootView*)view{
	
	return _reloading; // should return if data source model is reloading
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource1{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	//刷新数据去吧
	if (refreshDelegate != nil) {
		currentPage = currentPage + 1;
		[refreshDelegate reloadRefreshDataSource:currentPage];
	}
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData1{
	//  model should call this when its done loading
	[self modifyMoreFrame];
	_reloading = NO;
	[_refreshFootView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}


#pragma mark -

- (void)reloadData{
	[super reloadData];
}


-(void) reload:(int)rows{

    [pg setCurrent: currentPage];
	if (pg.isEnd) {
		_refreshFootView.hidden = YES;
	}
	else {
		_refreshFootView.hidden = NO;
	}

	if (currentPage == 1) {
		//[self doneLoadingTableViewData];
		[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.01f];
	}
	else {
		//[self doneLoadingTableViewData1];
		[self performSelector:@selector(doneLoadingTableViewData1) withObject:nil afterDelay:0.01f];
	}

	[super reloadData];
}


- (int) getWidth{
	return self.frame.size.width;
}
- (int) getHeigth{
	return self.frame.size.height;
}
- (int) getX{
	return self.frame.origin.x;
}
- (int) getY{
	return self.frame.origin.y;
}

#pragma mark -

- (void)dealloc {
	[_refreshHeaderView release];
	_refreshHeaderView = nil;
	
	[_refreshFootView release];
	_refreshFootView = nil;
	
	[pg release];
	pg = nil;

    [super dealloc];
}


@end
