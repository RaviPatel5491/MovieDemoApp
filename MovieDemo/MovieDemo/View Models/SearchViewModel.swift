//
//  SearchViewModel.swift
//  MovieDemo
//
//  Created by Jigar Patel on 07/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
struct SearchViewModel {
    
    let searchText = Variable("")
    var arrSearch = Variable<[Search]>([])
    
    init() {
        // Load local data
        getLastSearchWords()
    }
       ///////////
    func addKeyWordToDB(keyword:String)
    {
        DatabaseManager.shared.addTextToSearch(text: keyword)
    }
    func deleteKeyWordToDB(rowid:Int)
    {
        DatabaseManager.shared.deleteTextFromDB(rowId: rowid)
    }
    mutating func getLastSearchWords()
    {
        let arrDictLastSearch = DatabaseManager.shared.getTableData(T_SEARCH as NSString, condition: " order by \(T_SEARCH_TS) desc  limit 10  " as NSString)
         arrSearch.value = Search.modelsFromDictionaryArray(array: arrDictLastSearch)
    }
}
