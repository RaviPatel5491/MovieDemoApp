//
//  Constants.swift
//  MovieDemo
//
//  Created by Jigar Patel on 07/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit

// whole app constants defined here
let DATABASE_NAME = "SEARCH.DB"
let colorPrimary = UIColor(hexString: "#0d1a3a")
let colorPrimaryDark = UIColor(hexString: "#000016")
let colorAccent = UIColor(hexString: "#384065")

// api urls
let HOMEURL = "https://easy-mock.com/mock/5c19c6ff64b4573fc81a61f3/movieapp/home"
let SEARCH_URL = "https://easy-mock.com/mock/5c19c6ff64b4573fc81a61f3/movieapp/search?"

let SOMETHING_WENT_WRONG = "Something went wrong!"

//database table fields

let T_SEARCH = "tSearch";
let T_SEARCH_ID = "rowid";
let T_SEARCH_TEXT = "Text";
let T_SEARCH_TS = "Timestamp";

var CREATE_SEARCH_TABLE = "CREATE TABLE " + T_SEARCH + "(" +
    T_SEARCH_ID + " INTEGER PRIMARY KEY AUTOINCREMENT," +
    T_SEARCH_TS + " TEXT," +
    T_SEARCH_TEXT + " INTEGER" + ")"

class Constants
{
    
}

