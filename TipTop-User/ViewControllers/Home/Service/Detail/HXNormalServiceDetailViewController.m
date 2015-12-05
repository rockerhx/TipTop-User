//
//  HXNormalServiceDetailViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXNormalServiceDetailViewController.h"
#import "HXNormalDetailAdviserCell.h"
#import "HXServiceDetailDesingerCell.h"
#import "HXServiceDetialContentCell.h"
#import "HXDetailPersonalIntroduceCell.h"
#import "HXDetailContentIntroduceCell.h"
#import "HXDetailCaseCardCell.h"
#import "HXDetailCaseContentCell.h"
#import "HXDetialMoreAdvisoryCell.h"
#import "HXNormalAdviserCell.h"
#import "HXDetailMoreCommentCell.h"
#import "HXDetailCommentCell.h"
#import "HXHomePageAdviserDetialViewModel.h"
#import "MJRefresh.h"

@interface HXNormalServiceDetailViewController () <HXDetailCaseCardCellDelegate>
@end

@implementation HXNormalServiceDetailViewController {
    HXHomePageAdviserDetialViewModel *_viewModel;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _viewModel = [HXHomePageAdviserDetialViewModel instanceWithListType:_listType];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewConfig {
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameList;
}

#pragma mark - Event Response
- (IBAction)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 
- (void)loadNewData {
    __weak __typeof__(self)weakSelf = self;
    [_viewModel requestWithID:_aid cid:_cid completed:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    HXHomePageAdviserDetialCellRow row = ((NSNumber *)_viewModel.rowTypes[indexPath.row]).integerValue;
    switch (row) {
        case HXHomePageAdviserDetialCellRowNormalAdviser: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXNormalDetailAdviserCell class]) forIndexPath:indexPath];
            [(HXNormalDetailAdviserCell *)cell displayWithNormalAdviser:_viewModel.adviser];
            break;
        }
        case HXHomePageAdviserDetialCellRowDesigner: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXServiceDetailDesingerCell class]) forIndexPath:indexPath];
            [(HXServiceDetailDesingerCell *)cell displayWithNormalAdviser:_viewModel.adviser];
            break;
        }
        case HXHomePageAdviserDetialCellRowServiceContent: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXServiceDetialContentCell class]) forIndexPath:indexPath];
            ((HXServiceDetialContentCell *)cell).contentLabel.text = _viewModel.adviser.services;
            break;
        }
        case HXHomePageAdviserDetialCellRowPersonalIntroduce: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXDetailPersonalIntroduceCell class]) forIndexPath:indexPath];
            ((HXDetailPersonalIntroduceCell *)cell).contentLabel.text = _viewModel.adviser.about;
            break;
        }
        case HXHomePageAdviserDetialCellRowCaseIntroduce: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXDetailContentIntroduceCell class]) forIndexPath:indexPath];
            ((HXDetailContentIntroduceCell *)cell).contentLabel.text = _viewModel.selectedCase.introduce;
            break;
        }
        case HXHomePageAdviserDetialCellRowCase: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXDetailCaseCardCell class]) forIndexPath:indexPath];
            [(HXDetailCaseCardCell *)cell displayWithCases:_viewModel.cases];
            break;
        }
        case HXHomePageAdviserDetialCellRowCaseContent: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXDetailCaseContentCell class]) forIndexPath:indexPath];
            ((HXDetailCaseContentCell *)cell).contentLabel.text = _viewModel.selectedCase.content;
            break;
        }
        case HXHomePageAdviserDetialCellRowAdvisoryMore: {
            ;
            break;
        }
        case HXHomePageAdviserDetialCellRowAdvisoryAdviser: {
            ;
            break;
        }
        case HXHomePageAdviserDetialCellRowCommentPrompt: {
            ;
            break;
        }
        case HXHomePageAdviserDetialCellRowComment: {
            ;
            break;
        }
    }
    return cell;
}

#pragma mark - Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    HXHomePageAdviserDetialCellRow row = ((NSNumber *)_viewModel.rowTypes[indexPath.row]).integerValue;
    switch (row) {
        case HXHomePageAdviserDetialCellRowNormalAdviser: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXNormalDetailAdviserCell class]) cacheByIndexPath:indexPath configuration:^(HXNormalDetailAdviserCell *cell) {
                [cell displayWithNormalAdviser:_viewModel.adviser];
            }];
            break;
        }
        case HXHomePageAdviserDetialCellRowDesigner: {
            height = _viewModel.designerHeight;
            break;
        }
        case HXHomePageAdviserDetialCellRowServiceContent: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXServiceDetialContentCell class]) cacheByIndexPath:indexPath configuration:^(HXServiceDetialContentCell *cell) {
                cell.contentLabel.text = _viewModel.adviser.services;
            }];
            break;
        }
        case HXHomePageAdviserDetialCellRowPersonalIntroduce: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXDetailPersonalIntroduceCell class]) cacheByIndexPath:indexPath configuration:^(HXDetailPersonalIntroduceCell *cell) {
                cell.contentLabel.text = _viewModel.adviser.about;
            }];
            break;
        }
        case HXHomePageAdviserDetialCellRowCaseIntroduce: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXDetailContentIntroduceCell class]) cacheByIndexPath:indexPath configuration:^(HXDetailContentIntroduceCell *cell) {
                cell.contentLabel.text = _viewModel.selectedCase.introduce;
            }];
            break;
        }
        case HXHomePageAdviserDetialCellRowCase: {
            height = _viewModel.caseCardHeight;
            break;
        }
        case HXHomePageAdviserDetialCellRowCaseContent: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXDetailCaseContentCell class]) cacheByIndexPath:indexPath configuration:^(HXDetailCaseContentCell *cell) {
                cell.contentLabel.text = _viewModel.selectedCase.content;
            }];
            break;
        }
        case HXHomePageAdviserDetialCellRowAdvisoryMore: {
            ;
            break;
        }
        case HXHomePageAdviserDetialCellRowAdvisoryAdviser: {
            ;
            break;
        }
        case HXHomePageAdviserDetialCellRowCommentPrompt: {
            ;
            break;
        }
        case HXHomePageAdviserDetialCellRowComment: {
            ;
            break;
        }
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - HXDetailCaseCardCellDelegate Methods
- (void)cardCellScrollAtIndex:(NSInteger)index {
    _viewModel.selectIndex = index;
    [self.tableView reloadData];
}

@end
