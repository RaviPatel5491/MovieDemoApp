//
//  SearchViewModel.swift
//  MovieDemo
//
//  Created by Jigar Patel on 07/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit

class SearchViewModel {

    func addKeyWordToDB(keyword:String)
    {
        DatabaseManager.shared.addTextToSearch(text: keyword)
    }
    func deleteKeyWordToDB(rowid:Int)
    {
        DatabaseManager.shared.deleteTextFromDB(rowId: rowid)
    }
    func getLastSearchWords()->[Search]
    {
        let arrDictLastSearch = DatabaseManager.shared.getTableData(T_SEARCH as NSString, condition: " order by \(T_SEARCH_TS) desc  limit 10  " as NSString)
        return Search.modelsFromDictionaryArray(array: arrDictLastSearch)
    }
}
